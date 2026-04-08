-- Sales Report View definition to avoid unnecessary joins in application code every time

CREATE VIEW sales_report AS
SELECT 
    p.name AS product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;