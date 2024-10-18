-- Create a user to read data
CREATE USER 'customer_reader'@'localhost' IDENTIFIED BY 'customerread1!';

GRANT SELECT ON online_store.User TO 'customer_reader'@'localhost';

-- Creating an administrator with full rights
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpassword!';

GRANT ALL PRIVILEGES ON online_store.* TO 'admin_user'@'localhost';

-- Create a user to manage products
CREATE USER 'supplier_manager'@'localhost' IDENTIFIED BY 'supplierpassword!';

GRANT INSERT, UPDATE, DELETE ON online_store.Product TO 'supplier_manager'@'localhost';


SHOW GRANTS FOR 'customer_reader'@'localhost';
SHOW GRANTS FOR 'admin_user'@'localhost';
SHOW GRANTS FOR 'supplier_manager'@'localhost';
