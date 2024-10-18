USE orders_db


-- non-optimized query
EXPLAIN ANALYZE
SELECT c.name, o.order_id, p.product_name, oi.quantity, 
    (oi.quantity * p.price) AS unit_price,
    (SELECT COUNT(*) FROM Orders o2 WHERE o2.customer_id = c.customer_id) AS total_orders,
    (SELECT SUM(oi2.quantity * p2.price) 
     FROM OrderItems oi2 
     JOIN Products p2 ON oi2.product_id = p2.product_id 
     WHERE oi2.order_id = o.order_id) AS order_total
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE c.city = 'Kyiv'
AND p.category IN (SELECT category_id FROM Categories WHERE category_name LIKE '%Electronics%')
ORDER BY order_total DESC;



-- optimized query
CREATE INDEX idx_customers_city ON Customers(city);
CREATE INDEX idx_products_category ON Products(category);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orderitems_order_id ON OrderItems(order_id);
CREATE INDEX idx_orderitems_product_id ON OrderItems(product_id);



EXPLAIN ANALYZE
WITH FilteredCustomers AS (
    SELECT customer_id, name
    FROM Customers
    WHERE city = 'Kyiv'
),
OrderSummary AS (
    SELECT o.customer_id, o.order_id, SUM(oi.quantity * p.price) AS order_total
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE p.category IN (SELECT category_id FROM Categories WHERE category_name LIKE '%Electronics%')
    GROUP BY o.customer_id, o.order_id
)
SELECT fc.name, os.order_id, p.product_name, oi.quantity, 
       (oi.quantity * p.price) AS unit_price, 
       (SELECT COUNT(*) FROM Orders WHERE customer_id = fc.customer_id) AS total_orders,
       os.order_total
FROM FilteredCustomers fc
JOIN OrderSummary os ON fc.customer_id = os.customer_id
JOIN OrderItems oi ON os.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY os.order_total DESC;

