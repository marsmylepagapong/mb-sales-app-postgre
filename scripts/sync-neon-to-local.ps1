# Neon → Local Postgres Incremental Sync for ALL Tables
# Only runs on tables that contain a "DateCreated" column

# Neon connection
$NEON_CONN = "postgresql://neondb_owner:npg_ZXW8Q9AhvRBl@ep-noisy-rice-a1q4amcf-pooler.ap-southeast-1.aws.neon.tech/mbsalesapp-db?sslmode=require&channel_binding=require"

# Local connection
$LOCAL_DB = "Host=localhost;Port=5432;Database=MbSalesDb_Prod_Copy;Username=postgres;Password=V@nn3P@g@p0ng"

# 1. Get all tables from Neon
$tables = psql "$NEON_CONN" -t -A -c "SELECT tablename FROM pg_tables WHERE schemaname='public';"

foreach ($table in $tables) {
    Write-Host "---- Checking table: $table ----"

    # 2. Check if table has a DateCreated column in Neon
    $hasDateCreated = psql "$NEON_CONN" -t -A -c "SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='$table' AND column_name='DateCreated';"

    if (-not $hasDateCreated) {
        Write-Host "⏭️  Skipping $table (no DateCreated column)."
        continue
    }

    # 3. Check if table exists in local
    $tableExists = psql "$LOCAL_DB" -t -A -c "SELECT to_regclass('public.\"$table\"');"

    if (-not $tableExists) {
        Write-Host "⚠️  Table $table does not exist in local. Creating..."
        # Dump schema for this table from Neon
        $schemaFile = "schema_${table}.sql"
        pg_dump "$NEON_CONN" --schema-only --table=$table -f $schemaFile
        # Apply schema to local
        psql "$LOCAL_DB" -f $schemaFile
        Write-Host "✅ Created table $table in local."
    }

    # 4. Get last DateCreated in local
    $lastDate = psql "$LOCAL_DB" -t -A -c "SELECT COALESCE(MAX(\"DateCreated\"), '1970-01-01') FROM \"$table\";" 2>$null

    if (-not $lastDate) {
        Write-Host "⚠️  Skipping $table (could not determine last DateCreated)."
        continue
    }

    Write-Host "📅 Last DateCreated in local for $table: $lastDate"

    # 5. Export only new rows from Neon
    $exportFile = "new_${table}.csv"
    psql "$NEON_CONN" -c "\COPY (SELECT * FROM \"$table\" WHERE \"DateCreated\" > '$lastDate') TO '$exportFile' CSV HEADER"

    # 6. Import into local
    psql "$LOCAL_DB" -c "\COPY \"$table\" FROM '$exportFile' CSV HEADER"

    Write-Host "✅ Synced new rows for $table"
}
