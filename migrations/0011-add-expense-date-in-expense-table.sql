-- 1. Make SaleId nullable
ALTER TABLE "Expense"
ALTER COLUMN "SaleId" DROP NOT NULL;

-- 2. Add new column ExpenseDate (temporarily nullable so we can fill it)
ALTER TABLE "Expense"
ADD COLUMN "ExpenseDate" DATE;

-- 3. Copy values from DateCreated into ExpenseDate
UPDATE "Expense"
SET "ExpenseDate" = DATE("DateCreated");

-- 4. Set the column as NOT NULL
ALTER TABLE "Expense"
ALTER COLUMN "ExpenseDate" SET NOT NULL;
