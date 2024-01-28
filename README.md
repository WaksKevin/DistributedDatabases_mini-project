# Mini Project Assignment
- **Wakhisi Kevin Wasike - P15/1928/2020** <br />
- **Staicy Nelima Muthoni Mugo - P15/1915/2020**

Create a distributed heterogeneous database environment comprising three sites with three different participating database platforms, and at least two different operating systems. Use the above environment to demonstrate your grasp of fragmentation and reconstruction.

Think of a domain area comprising of at least four distributed relations. Write out your applications/reports and use them to perform fragmentation. Come up with appropriate query access frequencies of your choice. Allocate the fragments by implementing them physically in the participating databases. Choose one of the sites to be the decision site and perform reconstruction using either views, functions, stored procedures or any other technique.

## Domain - Ecommerce

_The company Nitras is an online retailer that sells a variety of products, such as clothing, electronics, books, and home appliances. Nitras wants to use a distributed database to store and manage its inventory, orders, customers, and suppliers across 3 different counties. You have been hired as a consultant to design and develop the distributed database._

| 3 sites | 3 different Database Platforms | at least 2 Operating Systems | addresses |
| --- | --- | --- | --- |
| Machakos (Decision site) | PostgreSQL | Windows | localhost |
| Nairobi  | MySQL | Linux | 24.144.94.53 |
| Nakuru | MariaDB | Linux | 146.190.146.117 |


## Global Tables

| Table | Field Description |
| --- | --- |
| category | **id**: Unique identifier<br>**name**: Type of goods dealt with (clothing, electronics, books, etc.)<br> **storehouse**: the storehouse that deals with that category (either Nairobi, Nakuru or Machakos)|
| inventory | **id**: Unique identifier for each product<br>**name**: Name of the product<br>**category_id**: Foreign key referencing the id of the category that this product belongs to <br>**description**: Brief description of the product<br>**price**: Price of the product<br>**quantity**: Number of units available for the product<br>**supplier\_id**: Foreign key referencing the id of the supplier who provides the product |
| orders | **id**: Unique identifier for each order<br>**customer\_id**: Foreign key referencing the id of the customer who placed the order<br>**date**: Date of the order<br>**item**: Foreign Key referencing product in Inventories<br>**status**: Status of the order (pending, shipped, delivered, etc.)<br>**total**: Total amount of the order<br>**shipped\_from**: Storehouse where that item is located( either Nairobi, Nakuru or Machakos)<br>**shipping\_address**: Shipping address of the order |
| customers | **id**: Unique identifier for each customer<br>**name**: Name of the customer<br>**email**: Email of the customer<br>**password**: Password of the customer<br>**phone**: Phone number of the customer<br>**address**: Address of the customer<br>**orders\_count**: Number of orders placed by the customer |
| suppliers | **id**: Unique identifier for each supplier<br>**name**: Name of the supplier<br>**email**: Email of the supplier<br>**phone**: Phone number of the supplier<br>**address**: Address of the supplier<br>**products\_count**: Number of products provided by the supplier |

### `category` Table


```sql
CREATE TABLE category (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    storehouse VARCHAR(50) NOT NULL
);

INSERT INTO category (id, name, storehouse) VALUES
(1, 'Clothing', 'Nairobi'),
(2, 'Electronics', 'Nakuru'),
(3, 'Books', 'Machakos'),
(4, 'Toys', 'Nairobi'),
(5, 'Furniture', 'Nakuru');
```

### `suppliers` Table


```sql
CREATE TABLE suppliers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    products_count INT
);

INSERT INTO suppliers (id, name, email, phone, address, products_count) VALUES
(1, 'Supplier A', 'supplierA@example.com', '111-222-3333', '400 Supplier St', 5),
(2, 'Supplier B', 'supplierB@example.com', '444-555-6666', '500 Supplier St', 3),
(3, 'Supplier C', 'supplierC@example.com', '777-888-9999', '600 Supplier St', 7),
(4, 'Supplier D', 'supplierD@example.com', '999-888-7777', '700 Supplier St', 10),
(5, 'Supplier E', 'supplierE@example.com', '333-555-1111', '800 Supplier St', 8);
```

### `inventory` Table


```sql
CREATE TABLE inventory (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    supplier_id INT,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

INSERT INTO inventory (id, name, category_id, description, price, quantity, supplier_id) VALUES
(1, 'T-Shirt', 1, 'Cotton T-Shirt', 19.99, 100, 1),
(2, 'Laptop', 2, 'High-performance laptop', 899.99, 30, 2),
(3, 'Harry Potter Book', 3, 'Fantasy novel', 15.99, 50, 3),
(4, 'Action Figure', 4, 'Superhero action figure', 9.99, 80, 4),
(5, 'Sofa', 5, 'Comfortable sofa', 499.99, 10, 5),
(6, 'Jeans', 1, 'Blue jeans', 29.99, 50, 1),
(7, 'Smartphone', 2, 'Latest smartphone model', 699.99, 20, 2),
(8, 'Cookbook', 3, 'Collection of recipes', 12.99, 40, 3),
(9, 'Board Game', 4, 'Family board game', 24.99, 60, 4),
(10, 'Coffee Table', 5, 'Wooden coffee table', 129.99, 15, 5),
(11, 'Dress', 1, 'Elegant dress', 39.99, 30, 1),
(12, 'Headphones', 2, 'Noise-canceling headphones', 149.99, 25, 2),
(13, 'Mystery Novel', 3, 'Thriller mystery novel', 18.99, 35, 3),
(14, 'Building Blocks', 4, 'Educational building blocks', 14.99, 70, 4),
(15, 'Bed Frame', 5, 'Queen-sized bed frame', 299.99, 8, 5),
(16, 'Polo Shirt', 1, 'Casual polo shirt', 24.99, 40, 1),
(17, 'Tablet', 2, 'Android tablet', 199.99, 15, 2),
(18, 'Science Book', 3, 'Scientific exploration book', 20.99, 25, 3),
(19, 'Puzzle Set', 4, 'Challenging puzzle set', 17.99, 55, 4),
(20, 'Bookshelf', 5, 'Wooden bookshelf', 179.99, 12, 5);
```

### `customers` Table


```sql
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    orders_count INT
);

INSERT INTO customers (id, name, email, password, phone, address, orders_count) VALUES
(1, 'John Doe', 'john@example.com', 'password123', '123-456-7890', '101 Main St', 2),
(2, 'Jane Smith', 'jane@example.com', 'pass456', '987-654-3210', '202 Oak St', 1),
(3, 'Bob Johnson', 'bob@example.com', 'secret321', '555-123-4567', '303 Pine St', 3),
(4, 'Alice Brown', 'alice@example.com', 'qwerty', '777-888-1234', '404 Maple St', 2),
(5, 'Charlie Davis', 'charlie@example.com', 'abcdef', '555-999-1111', '505 Cedar St', 4);
```

### `orders` Table


```sql
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    date DATE,
    item INT,
    status VARCHAR(20),
    total DECIMAL(10, 2),
    shipped_from VARCHAR(50),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (item) REFERENCES Inventory(id)
);

INSERT INTO orders (id, customer_id, date, item, status, total, shipped_from, shipping_address) VALUES
(1, 1, '2024-01-01', 1, 'Shipped', 199.95, 'Nairobi', '123 Main St, Nairobi'),
(2, 2, '2024-01-02', 3, 'Pending', 31.98, 'Machakos', '456 Oak St, Machakos'),
(3, 3, '2024-01-03', 2, 'Delivered', 899.99, 'Nakuru', '789 Pine St, Nakuru'),
(4, 4, '2024-01-04', 5, 'Shipped', 649.95, 'Nairobi', '404 Maple St, Nairobi'),
(5, 5, '2024-01-05', 8, 'Pending', 149.99, 'Machakos', '505 Cedar St, Machakos'),
(6, 1, '2024-01-06', 12, 'Delivered', 299.97, 'Nairobi', '123 Main St, Nairobi'),
(7, 2, '2024-01-07', 15, 'Shipped', 2399.92, 'Nakuru', '202 Oak St, Nakuru'),
(8, 3, '2024-01-08', 18, 'Delivered', 419.85, 'Machakos', '303 Pine St, Machakos'),
(9, 4, '2024-01-09', 20, 'Pending', 359.98, 'Nairobi', '404 Maple St, Nairobi'),
(10, 5, '2024-01-10', 16, 'Shipped', 999.60, 'Nakuru', '505 Cedar St, Nakuru');
```

## Applications

- Application 1 - Find the name and price of the least ordered product in each store/branch
- Application 2 - Find the email and name of the customers who have ordered more than 3 times
- Application 3 - Find the total number of products in stock in for each supplier

## Query Execution Frequencies

|  | Machakos | Nairobi | Nakuru |
| --- | --- | --- | --- |
| Q1 |  |  |  |
| Q2 |  |  |  |
| Q3 |  |  |  |

## HORIZONTAL PARTIONING

- Partioning of the inventories table based on the `category` attribute because each category's products are stored in a particular site / storehouse.

- Partionining of the Orders table based on the `shipped_from` attribute.


```sql

```
