-- Active: 1706439060085@@127.0.0.1@5432@nitras


CREATE VIEW triple_customers
AS
SELECT id, email, name FROM customers_orders_gt_3;