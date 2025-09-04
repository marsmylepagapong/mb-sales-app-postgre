-- Add EmployeeId column (nullable, since not all expenses may have employees)
ALTER TABLE "Expense"
ADD COLUMN "EmployeeId" INT NULL;

-- Create the foreign key relationship to Employee table
ALTER TABLE "Expense"
ADD CONSTRAINT fk_expense_employee
FOREIGN KEY ("EmployeeId") REFERENCES "Employee"("Id")
ON DELETE SET NULL;  -- if an Employee is deleted, keep the expense but null out EmployeeId
