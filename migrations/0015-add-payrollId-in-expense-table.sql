-- Add PayrollId column if not exists
ALTER TABLE "Expense"
ADD COLUMN IF NOT EXISTS "PayrollId" int NULL;

-- Add foreign key constraint
ALTER TABLE "Expense"
ADD CONSTRAINT fk_expense_payroll
FOREIGN KEY ("PayrollId") REFERENCES "Payroll"("Id")
ON DELETE RESTRICT;

-- Optional index for faster lookups
CREATE INDEX IF NOT EXISTS idx_expense_payroll ON "Expense" ("PayrollId");
