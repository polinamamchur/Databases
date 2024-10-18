INSERT INTO Customers (customer_id, name, email, city) VALUES
(1, 'John Doe', 'john.doe@example.com', 'New York'),
(2, 'Jane Smith', 'jane.smith@example.com', 'Los Angeles'),
(3, 'Alice Johnson', 'alice.johnson@example.com', 'Chicago'),
(4, 'Bob Williams', 'bob.williams@example.com', 'New York'),
(5, 'Charlie Brown', 'charlie.brown@example.com', 'San Francisco'),
(6, 'David Lee', 'david.lee@example.com', 'Houston'),
(7, 'Eva Davis', 'eva.davis@example.com', 'Seattle'),
(8, 'Frank Green', 'frank.green@example.com', 'Boston'),
(9, 'Grace King', 'grace.king@example.com', 'New York'),
(10, 'Harry White', 'harry.white@example.com', 'Chicago'),
(11, 'Isla Adams', 'isla.adams@example.com', 'Los Angeles'),
(12, 'Jack Ford', 'jack.ford@example.com', 'Houston'),
(13, 'Karen Brooks', 'karen.brooks@example.com', 'Seattle'),
(14, 'Liam Cooper', 'liam.cooper@example.com', 'New York'),
(15, 'Mia Thompson', 'mia.thompson@example.com', 'Boston'),
(16, 'Nathan Harris', 'nathan.harris@example.com', 'San Francisco'),
(17, 'Olivia Clark', 'olivia.clark@example.com', 'Chicago'),
(18, 'Paul Walker', 'paul.walker@example.com', 'New York'),
(19, 'Quinn Edwards', 'quinn.edwards@example.com', 'Los Angeles'),
(20, 'Rachel Taylor', 'rachel.taylor@example.com', 'Houston');


INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Clothing'),
(4, 'Books'),
(5, 'Toys');

INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 1, 1200.00),
(2, 'Smartphone', 1, 800.00),
(3, 'Tablet', 1, 600.00),
(4, 'Office Chair', 2, 150.00),
(5, 'Desk', 2, 300.00),
(6, 'Sofa', 2, 700.00),
(7, 'T-shirt', 3, 20.00),
(8, 'Jeans', 3, 50.00),
(9, 'Jacket', 3, 120.00),
(10, 'Fiction Book', 4, 15.00),
(11, 'Non-fiction Book', 4, 25.00),
(12, 'Children Book', 4, 10.00),
(13, 'Action Figure', 5, 30.00),
(14, 'Doll', 5, 25.00),
(15, 'Board Game', 5, 40.00),
(16, 'Camera', 1, 500.00),
(17, 'Headphones', 1, 200.00),
(18, 'Printer', 1, 250.00),
(19, 'Dining Table', 2, 600.00),
(20, 'Sweater', 3, 80.00);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-15', 200.00),
(2, 2, '2023-02-20', 450.00),
(3, 3, '2023-03-05', 800.00),
(4, 4, '2023-04-10', 1500.00),
(5, 5, '2023-05-15', 600.00),
(6, 6, '2023-06-20', 300.00),
(7, 7, '2023-07-25', 1200.00),
(8, 8, '2023-08-30', 250.00),
(9, 9, '2023-09-05', 1300.00),
(10, 10, '2023-10-10', 700.00),
(11, 11, '2023-11-15', 550.00),
(12, 12, '2023-12-20', 400.00),
(13, 13, '2023-01-05', 150.00),
(14, 14, '2023-02-10', 120.00),
(15, 15, '2023-03-15', 1800.00),
(16, 16, '2023-04-20', 1100.00),
(17, 17, '2023-05-25', 2500.00),
(18, 18, '2023-06-30', 700.00),
(19, 19, '2023-07-05', 300.00),
(20, 20, '2023-08-10', 1000.00);


INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 1),
(4, 4, 4, 3),
(5, 5, 5, 2),
(6, 6, 6, 1),
(7, 7, 7, 5),
(8, 8, 8, 2),
(9, 9, 9, 1),
(10, 10, 10, 4),
(11, 11, 11, 1),
(12, 12, 12, 6),
(13, 13, 13, 1),
(14, 14, 14, 2),
(15, 15, 15, 1),
(16, 16, 16, 2),
(17, 17, 17, 1),
(18, 18, 18, 2),
(19, 19, 19, 1),
(20, 20, 20, 2);




