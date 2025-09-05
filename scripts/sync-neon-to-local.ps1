# --------------------------------------
# Neon to Local: Schema + Data Import
# --------------------------------------

# Neon connection URL
$NEON_CONN = // replace neon connection string

# Local PostgreSQL connection
$LOCAL_DB = // replace local connection string

# -----------------------
# Step 1: Dump and apply schema
# -----------------------
$schemaFile = "schema.sql"
Write-Host "Dumping entire public schema from Neon to $schemaFile..."
pg_dump $NEON_CONN --schema-only --schema=public --no-owner --no-privileges -f $schemaFile

Write-Host "Applying schema to local database..."
psql $LOCAL_DB -f $schemaFile

Write-Host "Deleting temporary schema file..."
Remove-Item $schemaFile -Force
Write-Host "Schema applied and temporary file deleted successfully.`n"

# -----------------------
# Step 2: Dump and apply data
# -----------------------
$dataFile = "data.sql"
Write-Host "Dumping data from Neon to $dataFile..."
pg_dump $NEON_CONN --data-only --inserts --column-inserts --schema=public -f $dataFile

Write-Host "Importing data into local database..."
psql $LOCAL_DB -f $dataFile

Write-Host "Deleting temporary data file..."
Remove-Item $dataFile -Force
Write-Host "Data import completed successfully."
