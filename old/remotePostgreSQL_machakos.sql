CREATE DATABASE nitras451;

USE nitras451;

-- Create Categories Table
CREATE TABLE Category (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    storehouse VARCHAR(50) NOT NULL
);

-- Insert Sample Data into Categories Table
INSERT INTO Category (id, name, storehouse) VALUES
(1, 'Clothing', 'Nairobi'),
(2, 'Electronics', 'Nakuru'),
(3, 'Books', 'Machakos'),
(4, 'Toys', 'Nairobi'),
(5, 'Furniture', 'Nakuru');

-- Create Suppliers Table
CREATE TABLE Suppliers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    products_count INT
);

-- Insert Sample Data into Suppliers Table
INSERT INTO Suppliers (id, name, email, phone, address, products_count) VALUES
(1, 'Supplier A', 'supplierA@example.com', '111-222-3333', '400 Supplier St', 5),
(2, 'Supplier B', 'supplierB@example.com', '444-555-6666', '500 Supplier St', 3),
(3, 'Supplier C', 'supplierC@example.com', '777-888-9999', '600 Supplier St', 7),
(4, 'Supplier D', 'supplierD@example.com', '999-888-7777', '700 Supplier St', 10),
(5, 'Supplier E', 'supplierE@example.com', '333-555-1111', '800 Supplier St', 8);

-- Create Inventory Table
CREATE TABLE Inventory (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category INT,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    supplier_id INT,
    FOREIGN KEY (category) REFERENCES Category(id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);

-- Insert Sample Data into Inventory Table
INSERT INTO Inventory (id, name, category, description, price, quantity, supplier_id) VALUES
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

-- Create Customers Table
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    orders_count INT
);

-- Insert Sample Data into Customers Table
INSERT INTO Customers (id, name, email, password, phone, address, orders_count) VALUES
(1, 'John Doe', 'john@example.com', 'password123', '123-456-7890', '101 Main St', 2),
(2, 'Jane Smith', 'jane@example.com', 'pass456', '987-654-3210', '202 Oak St', 1),
(3, 'Bob Johnson', 'bob@example.com', 'secret321', '555-123-4567', '303 Pine St', 3),
(4, 'Alice Brown', 'alice@example.com', 'qwerty', '777-888-1234', '404 Maple St', 2),
(5, 'Charlie Davis', 'charlie@example.com', 'abcdef', '555-999-1111', '505 Cedar St', 4);

-- Create Orders Table
CREATE TABLE Orders (
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

-- Insert Sample Data into Orders Table
INSERT INTO Orders (id, customer_id, date, item, status, total, shipped_from, shipping_address) VALUES
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



-- HORIZONTAL PARTIONING
CREATE DATABASE nitras_nakuru;

USE nitras_nakuru;

-- Create Inventory Table Fragment for Nakuru
CREATE TABLE Inventory_Nakuru AS
SELECT *
FROM nitras451.Inventory
WHERE category IN (SELECT id FROM nitras451.Category WHERE storehouse = 'Nakuru');

-- Insert data into Inventory_Nakuru
INSERT INTO Inventory_Nakuru
SELECT *
FROM nitras451.Inventory
WHERE category IN (SELECT id FROM nitras451.Category WHERE storehouse = 'Nakuru');




-- DROP Main Database so as to remain with main fragment
DROP DATABASE nitras451;

