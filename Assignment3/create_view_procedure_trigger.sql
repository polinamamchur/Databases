USE online_store;

-- VIEW for displaying active orders for the last month
CREATE VIEW DetailedActiveOrders AS
SELECT 
    o.order_id, 
    u.first_name, 
    u.last_name, 
    o.order_date, 
    o.total_price AS order_total, 
    o.status,
    GROUP_CONCAT(CONCAT(p.product_name, ' (', od.quantity, ')') SEPARATOR ', ') AS ordered_products,
    SUM(od.quantity * od.price) AS calculated_total
FROM `Order` o
JOIN User u ON o.user_id = u.user_id
JOIN OrderDetail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
WHERE o.status <> 'Cancelled'
AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY o.order_id, u.first_name, u.last_name, o.order_date, o.total_price, o.status;

SELECT * FROM DetailedActiveOrders;



-- PROCEDURE for displaying active orders for a specific user and by specific status
CREATE PROCEDURE GetActiveOrdersForUser (
    IN input_user_id INT,
    IN input_status ENUM('Pending', 'Shipped', 'Delivered')
)
BEGIN
    -- 
    SELECT o.order_id, u.first_name, u.last_name, o.order_date, o.total_price, o.status
    FROM `Order` o
    JOIN User u ON o.user_id = u.user_id
    WHERE o.user_id = input_user_id
    AND o.status = input_status;
END 


CALL GetActiveOrdersForUser(1, 'Pending');



-- TRIGGER for updating the total price of the shopping cart after adding an item
CREATE TRIGGER UpdateCartTotal AFTER INSERT ON CartItem
FOR EACH ROW
BEGIN
    UPDATE Cart
    SET total_price = (SELECT SUM(ci.quantity * p.price)
                       FROM CartItem ci
                       JOIN Product p ON ci.product_id = p.product_id
                       WHERE ci.cart_id = NEW.cart_id)
    WHERE cart_id = NEW.cart_id;
END 

INSERT INTO CartItem (cart_id, product_id, quantity) VALUES (1, 2, 2);
SELECT cart_id, total_price FROM Cart WHERE cart_id = 1;



