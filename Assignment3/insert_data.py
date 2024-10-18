import pymysql
import random
from faker import Faker
from dotenv import load_dotenv
import os

load_dotenv()

db_config = {
    'port': int(os.getenv('DB_PORT', 3306)),
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''),
    'database': os.getenv('DB_DATABASE', '')
}
fake = Faker()


# Function to insert users
def insert_users(cursor, num_users):
    for _ in range(num_users):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.unique.email()
        password_hash = fake.password()
        phone = fake.phone_number()[:15]
        cursor.execute("""
            INSERT INTO User (first_name, last_name, email, password_hash, phone)
            VALUES (%s, %s, %s, %s, %s)
        """, (first_name, last_name, email, password_hash, phone))


# Function to insert products
def insert_products(cursor, num_products):
    categories = ['Furniture', 'Kitchen', 'Bedroom', 'Living Room', 'Bathroom', 'Lighting', 'Textiles']
    for _ in range(num_products):
        product_name = fake.word() + ' ' + fake.word()
        description = fake.text(max_nb_chars=200)
        price = round(random.uniform(10, 500), 2)
        stock_quantity = random.randint(0, 100)
        category = random.choice(categories)
        cursor.execute("""
            INSERT INTO Product (product_name, description, price, stock_quantity, category)
            VALUES (%s, %s, %s, %s, %s)
        """, (product_name, description, price, stock_quantity, category))


# Function to insert discounts
def insert_discounts(cursor, num_discounts):
    for _ in range(num_discounts):
        discount_name = fake.word() + " " + fake.word() + " discount"
        discount_percentage = round(random.uniform(5, 50), 2)
        start_date = fake.date_this_year()
        end_date = fake.date_between(start_date=start_date, end_date='+30d')
        cursor.execute("""
            INSERT INTO Discount (discount_name, discount_percentage, start_date, end_date)
            VALUES (%s, %s, %s, %s)
        """, (discount_name, discount_percentage, start_date, end_date))


# Function to insert product-discount relationships
def insert_product_discounts(cursor, num_records):
    cursor.execute("SELECT product_id FROM Product")
    product_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT discount_id FROM Discount")
    discount_ids = [row[0] for row in cursor.fetchall()]

    for _ in range(num_records):
        product_id = random.choice(product_ids)
        discount_id = random.choice(discount_ids)
        cursor.execute("""
            INSERT INTO Product_Discount (product_id, discount_id)
            VALUES (%s, %s)
        """, (product_id, discount_id))


# Function to insert carts
def insert_carts(cursor, num_carts):
    for _ in range(num_carts):
        user_id = random.randint(1, 500000)  # Adjust for valid user_id range
        total_price = round(random.uniform(50, 1000), 2)
        cursor.execute("""
            INSERT INTO Cart (user_id, total_price)
            VALUES (%s, %s)
        """, (user_id, total_price))


# Function to insert cart items
def insert_cart_items(cursor, num_cart_items):
    cursor.execute("SELECT cart_id FROM Cart")
    cart_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT product_id FROM Product")
    product_ids = [row[0] for row in cursor.fetchall()]

    for _ in range(num_cart_items):
        cart_id = random.choice(cart_ids)
        product_id = random.choice(product_ids)
        quantity = random.randint(1, 5)
        cursor.execute("""
            INSERT INTO CartItem (cart_id, product_id, quantity)
            VALUES (%s, %s, %s)
        """, (cart_id, product_id, quantity))


# Function to insert suppliers
def insert_suppliers(cursor, num_suppliers):
    for _ in range(num_suppliers):
        supplier_name = fake.company()
        contact_email = fake.email()
        contact_phone = fake.phone_number()[:15]
        cursor.execute("""
            INSERT INTO Supplier (supplier_name, contact_email, contact_phone)
            VALUES (%s, %s, %s)
        """, (supplier_name, contact_email, contact_phone))


# Function to insert supplier-product relationships
def insert_supplier_products(cursor, num_records):
    cursor.execute("SELECT supplier_id FROM Supplier")
    supplier_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT product_id FROM Product")
    product_ids = [row[0] for row in cursor.fetchall()]

    used_pairs = set()  # Set to store unique (supplier_id, product_id) pairs

    for _ in range(num_records):
        while True:
            supplier_id = random.choice(supplier_ids)
            product_id = random.choice(product_ids)
            pair = (supplier_id, product_id)

            # Ensure the pair (supplier_id, product_id) is unique
            if pair not in used_pairs:
                used_pairs.add(pair)
                break  # Exit the loop once a unique pair is found

        cursor.execute("""
            INSERT INTO Supplier_Product (supplier_id, product_id)
            VALUES (%s, %s)
        """, (supplier_id, product_id))


# Main function to insert data
def main():
    try:
        connection = pymysql.connect(**db_config)
        with connection.cursor() as cursor:
            connection.begin()

            # Uncomment the required function calls

            # # Insert 500,000 users
            # print("Inserting users...")
            # insert_users(cursor, 500000)
            # connection.commit()

            # # Insert 200,000 products
            # print("Inserting products...")
            # insert_products(cursor, 200000)
            # connection.commit()

            # # Insert 500,000 orders
            # print("Inserting orders and order details...")
            # insert_orders(cursor, 500000, 500000)
            # connection.commit()

            # # Insert discounts
            # print("Inserting discounts...")
            # insert_discounts(cursor, 1000)
            # connection.commit()
            #
            # # Insert product-discount relationships
            # print("Inserting product-discount relationships...")
            # insert_product_discounts(cursor, 5000)
            # connection.commit()
            #
            # # Insert suppliers
            # print("Inserting suppliers...")
            # insert_suppliers(cursor, 500)
            # connection.commit()

            # Insert supplier-product relationships
            print("Inserting supplier-product relationships...")
            insert_supplier_products(cursor, 5000)
            connection.commit()

            # Insert carts
            print("Inserting carts...")
            insert_carts(cursor, 10000)
            connection.commit()

            # Insert cart items
            print("Inserting cart items...")
            insert_cart_items(cursor, 50000)
            connection.commit()

            print("Data insertion completed successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
        connection.rollback()
    finally:
        connection.close()


if __name__ == "__main__":
    main()
