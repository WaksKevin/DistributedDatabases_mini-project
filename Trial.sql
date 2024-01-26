USE nitras_nairobi;

CREATE VIEW nitras451 AS
SELECT * FROM nitras451_nairobi.Inventory
UNION
SELECT * FROM nitras451_NAKURU.Inventory