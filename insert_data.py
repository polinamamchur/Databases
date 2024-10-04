import mysql.connector
import random
from faker import Faker
from datetime import datetime, timedelta
from dotenv import load_dotenv
import os


load_dotenv()


db_config = {
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'host': os.getenv('DB_HOST'),
    'database': os.getenv('DB_DATABASE'),
    'port': os.getenv('DB_PORT')
}


def insert_customers(cursor, num_customers):
    emails = set() 
    while len(emails) < num_customers:
        name = fake.name()
        email = fake.email()
        city = fake.city()

        # email is unique
        if email not in emails:
            emails.add(email)
            cursor.execute(
                "INSERT INTO Customers (name, email, city) VALUES (%s, %s, %s)",
                (name, email, city)
            )
        else:
            print(f"Duplicate email generated: {email}. Generating a new one.")


def insert_categories(cursor, categories):
    for category in categories:
        try:
            cursor.execute(
                "INSERT INTO Categories (category_name) VALUES (%s)",
                (category,)
            )
        except mysql.connector.IntegrityError:
            print(f"Category '{category}' already exists. Skipping.")

def insert_products(cursor, num_products):
    cursor.execute("SELECT category_id FROM Categories")
    categories = [row[0] for row in cursor.fetchall()]

    for _ in range(num_products):
        product_name = fake.word().capitalize()
        category = random.choice(categories)
        price = round(random.uniform(1.00, 100.00), 2)
        cursor.execute(
            "INSERT INTO Products (product_name, category, price) VALUES (%s, %s, %s)",
            (product_name, category, price)
        )

def insert_orders(cursor, num_orders):
    cursor.execute("SELECT customer_id FROM Customers")
    customers = [row[0] for row in cursor.fetchall()]

    for _ in range(num_orders):
        customer_id = random.choice(customers)
        order_date = fake.date_between(start_date='-1y', end_date='today')
        total_amount = round(random.uniform(10.00, 500.00), 2)
        cursor.execute(
            "INSERT INTO Orders (customer_id, order_date, total_amount) VALUES (%s, %s, %s)",
            (customer_id, order_date, total_amount)
        )

def insert_order_items(cursor, num_order_items):
    cursor.execute("SELECT order_id FROM Orders")
    orders = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT product_id FROM Products")
    products = [row[0] for row in cursor.fetchall()]

    for _ in range(num_order_items):
        order_id = random.choice(orders)
        product_id = random.choice(products)
        quantity = random.randint(1, 5)
        cursor.execute(
            "INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (%s, %s, %s)",
            (order_id, product_id, quantity)
        )

def generate_data():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    global fake
    fake = Faker()

    print("Inserting Customers...")
    insert_customers(cursor, 1000)

    print("Inserting Categories...")
    categories = ['Electronics', 'Furniture', 'Clothing', 'Books', 'Toys']
    insert_categories(cursor, categories)

    print("Inserting Products...")
    insert_products(cursor, 10000)

    print("Inserting Orders...")
    insert_orders(cursor, 5000)

    print("Inserting Order Items...")
    insert_order_items(cursor, 15000)

    conn.commit()
    cursor.close()
    conn.close()

if __name__ == "__main__":
    generate_data()