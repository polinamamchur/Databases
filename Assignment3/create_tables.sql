USE online_store;

-- Users Table
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the user',
    first_name VARCHAR(50) NOT NULL COMMENT 'User\'s first name',
    last_name VARCHAR(50) NOT NULL COMMENT 'User\'s last name',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT 'User\'s email address',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Password hash for security',
    phone VARCHAR(15) COMMENT 'User\'s phone number'
);

-- Home Products Table
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the product',
    product_name VARCHAR(100) NOT NULL COMMENT 'Product name',
    description TEXT COMMENT 'Product description',
    price DECIMAL(10, 2) NOT NULL COMMENT 'Product price',
    stock_quantity INT DEFAULT 0 COMMENT 'Stock quantity',
    category ENUM('Furniture', 'Kitchen', 'Bedroom', 'Living Room', 'Bathroom', 'Lighting', 'Textiles') 
        COMMENT 'Home product category'
);

-- Orders Table
CREATE TABLE `Order` (
    order_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the order',
    user_id INT NOT NULL COMMENT 'ID of the user who placed the order',
    order_date DATE NOT NULL COMMENT 'Order creation date',
    total_price DECIMAL(10, 2) NOT NULL COMMENT 'Total order price',
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending' COMMENT 'Order status',
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Order Details Table
CREATE TABLE OrderDetail (
    order_id INT NOT NULL COMMENT 'ID of the order',
    product_id INT NOT NULL COMMENT 'ID of the product in the order',
    quantity INT NOT NULL COMMENT 'Quantity of the product',
    price DECIMAL(10, 2) NOT NULL COMMENT 'Product price at the time of the order',
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Discounts Table
CREATE TABLE Discount (
    discount_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the discount',
    discount_name VARCHAR(100) NOT NULL COMMENT 'Discount or promotion name',
    discount_percentage DECIMAL(5, 2) NOT NULL COMMENT 'Discount percentage',
    start_date DATE NOT NULL COMMENT 'Discount start date',
    end_date DATE NOT NULL COMMENT 'Discount end date'
);

-- Product-Discount Relationship Table (many-to-many)
CREATE TABLE Product_Discount (
    product_id INT NOT NULL COMMENT 'ID of the product that has the discount',
    discount_id INT NOT NULL COMMENT 'ID of the discount applied to the product',
    PRIMARY KEY (product_id, discount_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES Discount(discount_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Carts Table
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the cart',
    user_id INT NOT NULL COMMENT 'ID of the user who owns the cart',
    total_price DECIMAL(10, 2) DEFAULT 0 COMMENT 'Total cart amount',
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Cart Items Table
CREATE TABLE CartItem (
    cart_id INT NOT NULL COMMENT 'ID of the cart',
    product_id INT NOT NULL COMMENT 'ID of the product in the cart',
    quantity INT NOT NULL COMMENT 'Quantity of the product in the cart',
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Suppliers Table
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for the supplier',
    supplier_name VARCHAR(100) NOT NULL COMMENT 'Supplier name',
    contact_email VARCHAR(100) NOT NULL COMMENT 'Supplier contact email',
    contact_phone VARCHAR(15) COMMENT 'Supplier contact phone number'
);

-- Supplier-Product Relationship Table (many-to-many)
CREATE TABLE Supplier_Product (
    supplier_id INT NOT NULL COMMENT 'ID of the supplier',
    product_id INT NOT NULL COMMENT 'ID of the product supplied',
    PRIMARY KEY (supplier_id, product_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);


SHOW TABLE STATUS LIKE 'User';

DELETE FROM OrderDetail;
DELETE FROM `Order`;
DELETE FROM User;
DELETE FROM Product;

ALTER TABLE User AUTO_INCREMENT = 1;
ALTER TABLE Product AUTO_INCREMENT = 1;
ALTER TABLE `order` AUTO_INCREMENT = 1;
ALTER TABLE orderdetail AUTO_INCREMENT = 1;


SELECT MIN(product_id), MAX(product_id) FROM Product;


-- Indexes for optimization
CREATE INDEX idx_order_user_id ON `Order`(user_id);
CREATE INDEX idx_cart_user_id ON Cart(user_id);
CREATE INDEX idx_cartitem_cart_id ON CartItem(cart_id);
CREATE INDEX idx_orderdetail_order_id ON OrderDetail(order_id);
CREATE INDEX idx_product_discount_product_id ON Product_Discount(product_id);
CREATE INDEX idx_product_discount_discount_id ON Product_Discount(discount_id);
