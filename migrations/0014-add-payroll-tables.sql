-- =====================
-- PAYROLL
-- =====================
CREATE TABLE "Payroll" (
    "Id" SERIAL PRIMARY KEY,
    "DateFrom" date NOT NULL,
    "DateTo" date NOT NULL,
    "TotalNetPay" numeric(18,2) NOT NULL DEFAULT 0,
    "DateCreated" timestamptz NOT NULL DEFAULT now(),
    "IsActive" boolean NOT NULL DEFAULT true
);

CREATE INDEX idx_payroll_date ON "Payroll" ("DateFrom", "DateTo");


-- =====================
-- PAYROLL ITEM
-- =====================
CREATE TABLE "PayrollItem" (
    "Id" SERIAL PRIMARY KEY,
    "PayrollId" int NOT NULL,
    "EmployeeId" int NOT NULL,
    "NoOfDays" int NOT NULL DEFAULT 0,
    "TotalEarnings" numeric(18,2) NOT NULL DEFAULT 0,
    "TotalDeductions" numeric(18,2) NOT NULL DEFAULT 0,
    "NetPay" numeric(18,2) NOT NULL DEFAULT 0,
    "Note" text,
    "DateCreated" timestamptz NOT NULL DEFAULT now(),
    "IsActive" boolean NOT NULL DEFAULT true,

    CONSTRAINT fk_payrollitem_payroll FOREIGN KEY ("PayrollId")
        REFERENCES "Payroll"("Id")
        ON DELETE CASCADE,

    CONSTRAINT fk_payrollitem_employee FOREIGN KEY ("EmployeeId")
        REFERENCES "Employee"("Id")
        ON DELETE RESTRICT
);

CREATE INDEX idx_payrollitem_payroll ON "PayrollItem" ("PayrollId");
CREATE INDEX idx_payrollitem_employee ON "PayrollItem" ("EmployeeId");


-- =====================
-- PAYROLL EARNING
-- =====================
CREATE TABLE "PayrollEarning" (
    "Id" SERIAL PRIMARY KEY,
    "PayrollItemId" int NOT NULL,
    "TypeId" int NOT NULL,
    "Amount" numeric(18,2) NOT NULL DEFAULT 0,
    "Note" text,
    "DateCreated" timestamptz NOT NULL DEFAULT now(),
    "IsActive" boolean NOT NULL DEFAULT true,

    CONSTRAINT fk_payrollearning_item FOREIGN KEY ("PayrollItemId")
        REFERENCES "PayrollItem"("Id")
        ON DELETE CASCADE
);

CREATE INDEX idx_payrollearning_item ON "PayrollEarning" ("PayrollItemId");
CREATE INDEX idx_payrollearning_type ON "PayrollEarning" ("TypeId");


-- =====================
-- PAYROLL DEDUCTION
-- =====================
CREATE TABLE "PayrollDeduction" (
    "Id" SERIAL PRIMARY KEY,
    "PayrollItemId" int NOT NULL,
    "TypeId" int NOT NULL,
    "Amount" numeric(18,2) NOT NULL DEFAULT 0,
    "Note" text,
    "DateCreated" timestamptz NOT NULL DEFAULT now(),
    "IsActive" boolean NOT NULL DEFAULT true,

    CONSTRAINT fk_payrolldeduction_item FOREIGN KEY ("PayrollItemId")
        REFERENCES "PayrollItem"("Id")
        ON DELETE CASCADE
);

CREATE INDEX idx_payrolldeduction_item ON "PayrollDeduction" ("PayrollItemId");
CREATE INDEX idx_payrolldeduction_type ON "PayrollDeduction" ("TypeId");
