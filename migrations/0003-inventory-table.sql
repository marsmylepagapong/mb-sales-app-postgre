CREATE TABLE public."Inventory" (
    "Id" SERIAL PRIMARY KEY,
    "TypeId" INTEGER NOT NULL,
    "ShiftId" INTEGER NOT NULL,
    "InventoryDate" DATE NOT NULL,
    "DateCreated" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "IsActive" BOOLEAN NOT NULL DEFAULT TRUE
);