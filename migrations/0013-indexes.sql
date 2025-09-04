
CREATE INDEX idx_inventory_date ON public."Inventory"("InventoryDate");
CREATE INDEX idx_inventoryitem_inventoryid ON public."InventoryItem"("InventoryId");
CREATE INDEX idx_inventoryitem_itemid ON public."InventoryItem"("ItemId");
CREATE INDEX idx_sale_employee ON "Sale"("EmployeeId");
CREATE INDEX idx_sale_shift ON "Sale"("ShiftId");
CREATE INDEX idx_saleitem_sale ON "SaleItem"("SaleId");
CREATE INDEX idx_saleitem_item ON "SaleItem"("ItemId");
CREATE INDEX idx_denom_sale ON "Denom"("SaleId");
CREATE INDEX idx_expense_sale ON "Expense"("SaleId");
--- last run







