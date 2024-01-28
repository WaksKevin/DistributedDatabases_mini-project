CREATE VIEW inventory_View
AS
SELECT * FROM inventory_machakos
UNION
SELECT * FROM inventory_nairobi
UNION
SELECT * FROM inventory_nakuru;