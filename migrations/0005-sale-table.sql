CREATE TABLE "Sale" (
    "Id" SERIAL PRIMARY KEY,
    "SaleDate" DATE NOT NULL,
    "EmployeeId" INT NOT NULL,
    "ShiftId" INT NOT NULL,
    "TotalSales" NUMERIC(18,2) NOT NULL,
    "CashDiscrepancy" NUMERIC(18,2) NOT NULL,
    "DateCreated" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "IsActive" BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_sale_employee FOREIGN KEY ("EmployeeId") REFERENCES "Employee"("Id") ON DELETE RESTRICT
);