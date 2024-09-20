USE orders_db;

-- the query receives information about sales of goods by customers from the city of New York for the period from 2023-01-01 to 2023-12-31
SELECT 
    c.customer_id,
    c.name AS customer_name,
    p.product_name,
    cat.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    OrderItems oi ON o.order_id = oi.order_id
JOIN 
    Products p ON oi.product_id = p.product_id
JOIN 
    Categories cat ON p.category = cat.category_id
WHERE 
    o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND c.city = 'New York'
GROUP BY 
    c.customer_id, c.name, p.product_name, cat.category_name
ORDER BY 
    total_sales_amount DESC;


-- the query receives information about sales of goods by customers from the city of New York and for Los Angeles for the period from 2023-01-01 to 2023-12-31
SELECT 
    c.customer_id,
    c.name AS customer_name,
    p.product_name,
    cat.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount,
    'New York' AS city
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    OrderItems oi ON o.order_id = oi.order_id
JOIN 
    Products p ON oi.product_id = p.product_id
JOIN 
    Categories cat ON p.category = cat.category_id
WHERE 
    o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND c.city = 'New York'
GROUP BY 
    c.customer_id, c.name, p.product_name, cat.category_name

UNION ALL

SELECT 
    c.customer_id,
    c.name AS customer_name,
    p.product_name,
    cat.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount,
    'Los Angeles' AS city
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    OrderItems oi ON o.order_id = oi.order_id
JOIN 
    Products p ON oi.product_id = p.product_id
JOIN 
    Categories cat ON p.category = cat.category_id
WHERE 
    o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND c.city = 'Los Angeles'
GROUP BY 
    c.customer_id, c.name, p.product_name, cat.category_name

ORDER BY 
    total_sales_amount DESC;


-- CTE
CREATE TABLE SalesData AS 
(
    -- Запит для міста New York
    SELECT 
        c.customer_id,
        c.name AS customer_name,
        p.product_name,
        cat.category_name,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.quantity * p.price) AS total_sales_amount,
        'New York' AS city
    FROM 
        Customers c
    JOIN 
        Orders o ON c.customer_id = o.customer_id
    JOIN 
        OrderItems oi ON o.order_id = oi.order_id
    JOIN 
        Products p ON oi.product_id = p.product_id
    JOIN 
        Categories cat ON p.category = cat.category_id
    WHERE 
        o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
        AND c.city = 'New York'
    GROUP BY 
        c.customer_id, c.name, p.product_name, cat.category_name

    UNION ALL

    -- Запит для міста Los Angeles
    SELECT 
        c.customer_id,
        c.name AS customer_name,
        p.product_name,
        cat.category_name,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.quantity * p.price) AS total_sales_amount,
        'Los Angeles' AS city
    FROM 
        Customers c
    JOIN 
        Orders o ON c.customer_id = o.customer_id
    JOIN 
        OrderItems oi ON o.order_id = oi.order_id
    JOIN 
        Products p ON oi.product_id = p.product_id
    JOIN 
        Categories cat ON p.category = cat.category_id
    WHERE 
        o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
        AND c.city = 'Los Angeles'
    GROUP BY 
        c.customer_id, c.name, p.product_name, cat.category_name
);

  -- Using CTE test 
SELECT 
    customer_id,
    customer_name,
    product_name,
    category_name,
    total_quantity_sold,
    total_sales_amount,
    city
FROM 
    SalesData
ORDER BY 
    total_sales_amount DESC;
   


