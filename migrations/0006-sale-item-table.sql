CREATE TABLE "SaleItem" (
    "Id" SERIAL PRIMARY KEY,
    "SaleId" INT NOT NULL,
    "ItemId" INT NOT NULL,
    "Beginning" INT NOT NULL,
    "In" INT NOT NULL,
    "Out" INT NOT NULL,
    "Available" INT NOT NULL,
    "Ending" INT NOT NULL,
    "Sold" INT NOT NULL,
    "Cost" NUMERIC(18,2) NOT NULL,
    "Price" NUMERIC(18,2) NOT NULL,
    "TotalAmount" NUMERIC(18,2) NOT NULL,
    "DateCreated" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "IsActive" BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_saleitem_sale FOREIGN KEY ("SaleId") REFERENCES "Sale"("Id") ON DELETE CASCADE,
    CONSTRAINT fk_saleitem_item FOREIGN KEY ("ItemId") REFERENCES "Item"("Id") ON DELETE RESTRICT
);