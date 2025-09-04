CREATE TABLE public."InventoryItem" (
    "Id" SERIAL PRIMARY KEY,
    "InventoryId" INTEGER NOT NULL,
    "ItemId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "Cost" NUMERIC(18,2) NOT NULL,
    "Price" NUMERIC(18,2) NOT NULL,
    "DateCreated" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "IsActive" BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_inventory FOREIGN KEY ("InventoryId") REFERENCES public."Inventory"("Id") ON DELETE CASCADE,
    CONSTRAINT fk_item FOREIGN KEY ("ItemId") REFERENCES public."Item"("Id")
);