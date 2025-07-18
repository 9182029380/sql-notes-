-- =====================================================
-- E-COMMERCE DATABASE TUTORIAL
-- Topics: Joins, Sub-queries, Views, and Indexes
-- Database: MySQL
-- Domain: Indian E-commerce Platform
-- =====================================================

-- Create Database
CREATE DATABASE ecommerce_india;
USE ecommerce_india;

-- =====================================================
-- TABLE CREATION
-- =====================================================

-- 1. CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    registration_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- 2. CATEGORIES TABLE
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    is_active BOOLEAN DEFAULT TRUE
);

-- 3. PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    brand VARCHAR(100),
    description TEXT,
    created_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    payment_method VARCHAR(50),
    shipping_address TEXT,
    delivery_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. ORDER_ITEMS TABLE
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. SUPPLIERS TABLE
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    rating DECIMAL(3,2) DEFAULT 0.0,
    is_active BOOLEAN DEFAULT TRUE
);

-- 7. PRODUCT_SUPPLIERS TABLE (Many-to-Many relationship)
CREATE TABLE product_suppliers (
    product_id INT,
    supplier_id INT,
    supply_price DECIMAL(10,2),
    last_supply_date DATE,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- =====================================================
-- DATA INSERTION
-- =====================================================

-- INSERT CUSTOMERS (20 records)
INSERT INTO customers (first_name, last_name, email, phone, city, state, pincode, registration_date, is_active) VALUES
('Rajesh', 'Sharma', 'rajesh.sharma@gmail.com', '9876543210', 'Mumbai', 'Maharashtra', '400001', '2023-01-15', TRUE),
('Priya', 'Singh', 'priya.singh@yahoo.com', '9876543211', 'Delhi', 'Delhi', '110001', '2023-02-20', TRUE),
('Amit', 'Patel', 'amit.patel@gmail.com', '9876543212', 'Ahmedabad', 'Gujarat', '380001', '2023-03-10', TRUE),
('Sneha', 'Gupta', 'sneha.gupta@hotmail.com', '9876543213', 'Pune', 'Maharashtra', '411001', '2023-04-05', TRUE),
('Vikram', 'Reddy', 'vikram.reddy@gmail.com', '9876543214', 'Hyderabad', 'Telangana', '500001', '2023-05-12', TRUE),
('Anita', 'Joshi', 'anita.joshi@gmail.com', '9876543215', 'Jaipur', 'Rajasthan', '302001', '2023-06-18', TRUE),
('Rohit', 'Kumar', 'rohit.kumar@yahoo.com', '9876543216', 'Bangalore', 'Karnataka', '560001', '2023-07-22', TRUE),
('Kavya', 'Nair', 'kavya.nair@gmail.com', '9876543217', 'Kochi', 'Kerala', '682001', '2023-08-14', TRUE),
('Arjun', 'Mehta', 'arjun.mehta@hotmail.com', '9876543218', 'Chennai', 'Tamil Nadu', '600001', '2023-09-25', TRUE),
('Pooja', 'Agarwal', 'pooja.agarwal@gmail.com', '9876543219', 'Kolkata', 'West Bengal', '700001', '2023-10-30', TRUE),
('Suresh', 'Yadav', 'suresh.yadav@yahoo.com', '9876543220', 'Lucknow', 'Uttar Pradesh', '226001', '2023-11-15', TRUE),
('Meera', 'Iyer', 'meera.iyer@gmail.com', '9876543221', 'Coimbatore', 'Tamil Nadu', '641001', '2023-12-05', TRUE),
('Karan', 'Malhotra', 'karan.malhotra@hotmail.com', '9876543222', 'Chandigarh', 'Chandigarh', '160001', '2024-01-10', TRUE),
('Ritu', 'Bansal', 'ritu.bansal@gmail.com', '9876543223', 'Indore', 'Madhya Pradesh', '452001', '2024-02-14', TRUE),
('Deepak', 'Tiwari', 'deepak.tiwari@yahoo.com', '9876543224', 'Varanasi', 'Uttar Pradesh', '221001', '2024-03-20', TRUE),
('Sonia', 'Chopra', 'sonia.chopra@gmail.com', '9876543225', 'Amritsar', 'Punjab', '143001', '2024-04-12', TRUE),
('Manish', 'Sinha', 'manish.sinha@hotmail.com', '9876543226', 'Patna', 'Bihar', '800001', '2024-05-08', TRUE),
('Nisha', 'Verma', 'nisha.verma@gmail.com', '9876543227', 'Bhopal', 'Madhya Pradesh', '462001', '2024-06-16', TRUE),
('Rahul', 'Jain', 'rahul.jain@yahoo.com', '9876543228', 'Surat', 'Gujarat', '395001', '2024-07-03', TRUE),
('Divya', 'Saxena', 'divya.saxena@gmail.com', '9876543229', 'Nagpur', 'Maharashtra', '440001', '2024-08-19', FALSE);

-- INSERT CATEGORIES (20 records)
INSERT INTO categories (category_name, description, parent_category_id, is_active) VALUES
('Electronics', 'Electronic devices and gadgets', NULL, TRUE),
('Fashion', 'Clothing and accessories', NULL, TRUE),
('Home & Kitchen', 'Home appliances and kitchen items', NULL, TRUE),
('Books', 'Books and educational materials', NULL, TRUE),
('Sports', 'Sports equipment and accessories', NULL, TRUE),
('Smartphones', 'Mobile phones and accessories', 1, TRUE),
('Laptops', 'Laptops and computers', 1, TRUE),
('Headphones', 'Audio devices and headphones', 1, TRUE),
('Mens Fashion', 'Clothing for men', 2, TRUE),
('Womens Fashion', 'Clothing for women', 2, TRUE),
('Kitchen Appliances', 'Kitchen tools and appliances', 3, TRUE),
('Home Decor', 'Decorative items for home', 3, TRUE),
('Fiction Books', 'Fiction literature', 4, TRUE),
('Non-Fiction Books', 'Educational and reference books', 4, TRUE),
('Cricket Equipment', 'Cricket bats, balls, and gear', 5, TRUE),
('Fitness Equipment', 'Gym and fitness accessories', 5, TRUE),
('Tablets', 'Tablets and e-readers', 1, TRUE),
('Watches', 'Wrist watches and smart watches', 2, TRUE),
('Cookware', 'Pots, pans, and cooking utensils', 3, TRUE),
('Outdoor Sports', 'Outdoor games and equipment', 5, TRUE);

-- INSERT PRODUCTS (20 records)
INSERT INTO products (product_name, category_id, price, stock_quantity, brand, description, created_date, is_active) VALUES
('iPhone 14 Pro', 6, 89999.00, 50, 'Apple', 'Latest iPhone with pro camera system', '2024-01-15', TRUE),
('Samsung Galaxy S23', 6, 74999.00, 30, 'Samsung', 'Flagship Android smartphone', '2024-01-20', TRUE),
('MacBook Air M2', 7, 114999.00, 25, 'Apple', 'Ultra-thin laptop with M2 chip', '2024-02-10', TRUE),
('Dell XPS 13', 7, 89999.00, 20, 'Dell', 'Premium ultrabook for professionals', '2024-02-15', TRUE),
('Sony WH-1000XM4', 8, 24999.00, 40, 'Sony', 'Noise-cancelling wireless headphones', '2024-03-05', TRUE),
('Nike Air Max 270', 9, 8999.00, 60, 'Nike', 'Comfortable running shoes for men', '2024-03-10', TRUE),
('Levis 511 Jeans', 9, 3999.00, 80, 'Levis', 'Slim fit denim jeans', '2024-03-15', TRUE),
('Zara Summer Dress', 10, 2999.00, 45, 'Zara', 'Trendy summer dress for women', '2024-04-01', TRUE),
('LG Front Load Washing Machine', 11, 34999.00, 15, 'LG', '7kg automatic washing machine', '2024-04-10', TRUE),
('Philips Air Fryer', 11, 8999.00, 35, 'Philips', 'Healthy cooking with air fryer', '2024-04-15', TRUE),
('The Alchemist', 13, 399.00, 100, 'HarperCollins', 'Paulo Coelho bestseller', '2024-05-01', TRUE),
('Atomic Habits', 14, 599.00, 75, 'Random House', 'Self-help book by James Clear', '2024-05-05', TRUE),
('MRF Cricket Bat', 15, 4999.00, 25, 'MRF', 'Professional cricket bat', '2024-05-10', TRUE),
('Reebok Dumbbells Set', 16, 2999.00, 30, 'Reebok', '10kg adjustable dumbbells', '2024-05-15', TRUE),
('iPad Pro 11-inch', 17, 71999.00, 20, 'Apple', 'Professional tablet with M2 chip', '2024-06-01', TRUE),
('Fossil Gen 6 Smartwatch', 18, 18999.00, 40, 'Fossil', 'Android smartwatch with GPS', '2024-06-05', TRUE),
('Hawkins Pressure Cooker', 19, 1999.00, 50, 'Hawkins', '5L aluminum pressure cooker', '2024-06-10', TRUE),
('Badminton Racket Set', 20, 3999.00, 35, 'Yonex', 'Professional badminton racket', '2024-06-15', TRUE),
('OnePlus 11', 6, 56999.00, 40, 'OnePlus', 'Flagship killer smartphone', '2024-07-01', TRUE),
('Boat Headphones', 8, 1999.00, 70, 'Boat', 'Wireless Bluetooth headphones', '2024-07-05', TRUE);

-- INSERT SUPPLIERS (20 records)
INSERT INTO suppliers (supplier_name, contact_person, email, phone, city, state, rating, is_active) VALUES
('TechWorld Distributors', 'Rajesh Kumar', 'rajesh@techworld.com', '9876501234', 'Mumbai', 'Maharashtra', 4.5, TRUE),
('Fashion Hub Suppliers', 'Priya Sharma', 'priya@fashionhub.com', '9876501235', 'Delhi', 'Delhi', 4.2, TRUE),
('Home Essentials Ltd', 'Amit Patel', 'amit@homeessentials.com', '9876501236', 'Ahmedabad', 'Gujarat', 4.3, TRUE),
('Book Paradise', 'Sneha Gupta', 'sneha@bookparadise.com', '9876501237', 'Pune', 'Maharashtra', 4.4, TRUE),
('Sports Zone', 'Vikram Reddy', 'vikram@sportszone.com', '9876501238', 'Hyderabad', 'Telangana', 4.1, TRUE),
('Mobile Mart', 'Anita Joshi', 'anita@mobilemart.com', '9876501239', 'Jaipur', 'Rajasthan', 4.6, TRUE),
('Laptop Galaxy', 'Rohit Kumar', 'rohit@laptopgalaxy.com', '9876501240', 'Bangalore', 'Karnataka', 4.3, TRUE),
('Audio Solutions', 'Kavya Nair', 'kavya@audiosolutions.com', '9876501241', 'Kochi', 'Kerala', 4.2, TRUE),
('Mens Collection', 'Arjun Mehta', 'arjun@menscollection.com', '9876501242', 'Chennai', 'Tamil Nadu', 4.0, TRUE),
('Womens Style', 'Pooja Agarwal', 'pooja@womensstyle.com', '9876501243', 'Kolkata', 'West Bengal', 4.4, TRUE),
('Kitchen Kings', 'Suresh Yadav', 'suresh@kitchenkings.com', '9876501244', 'Lucknow', 'Uttar Pradesh', 4.5, TRUE),
('Decor Dreams', 'Meera Iyer', 'meera@decordreams.com', '9876501245', 'Coimbatore', 'Tamil Nadu', 4.2, TRUE),
('Story House', 'Karan Malhotra', 'karan@storyhouse.com', '9876501246', 'Chandigarh', 'Chandigarh', 4.3, TRUE),
('Knowledge Hub', 'Ritu Bansal', 'ritu@knowledgehub.com', '9876501247', 'Indore', 'Madhya Pradesh', 4.4, TRUE),
('Cricket Central', 'Deepak Tiwari', 'deepak@cricketcentral.com', '9876501248', 'Varanasi', 'Uttar Pradesh', 4.1, TRUE),
('Fitness First', 'Sonia Chopra', 'sonia@fitnessfirst.com', '9876501249', 'Amritsar', 'Punjab', 4.3, TRUE),
('Tablet Town', 'Manish Sinha', 'manish@tablettown.com', '9876501250', 'Patna', 'Bihar', 4.2, TRUE),
('Watch World', 'Nisha Verma', 'nisha@watchworld.com', '9876501251', 'Bhopal', 'Madhya Pradesh', 4.5, TRUE),
('Cook Well', 'Rahul Jain', 'rahul@cookwell.com', '9876501252', 'Surat', 'Gujarat', 4.3, TRUE),
('Sports Arena', 'Divya Saxena', 'divya@sportsarena.com', '9876501253', 'Nagpur', 'Maharashtra', 4.0, TRUE);

-- INSERT ORDERS (20 records)
INSERT INTO orders (customer_id, order_date, total_amount, order_status, payment_method, shipping_address, delivery_date) VALUES
(1, '2024-01-20', 89999.00, 'Delivered', 'Credit Card', '123 Marine Drive, Mumbai, Maharashtra 400001', '2024-01-25'),
(2, '2024-02-15', 74999.00, 'Delivered', 'UPI', '456 Connaught Place, Delhi, Delhi 110001', '2024-02-20'),
(3, '2024-03-10', 114999.00, 'Delivered', 'Debit Card', '789 SG Highway, Ahmedabad, Gujarat 380001', '2024-03-15'),
(4, '2024-03-20', 24999.00, 'Shipped', 'Credit Card', '321 FC Road, Pune, Maharashtra 411001', '2024-03-25'),
(5, '2024-04-05', 17998.00, 'Delivered', 'UPI', '654 Hi-Tech City, Hyderabad, Telangana 500001', '2024-04-10'),
(6, '2024-04-15', 3999.00, 'Delivered', 'Cash on Delivery', '987 Pink City, Jaipur, Rajasthan 302001', '2024-04-20'),
(7, '2024-05-01', 2999.00, 'Processing', 'UPI', '147 Brigade Road, Bangalore, Karnataka 560001', NULL),
(8, '2024-05-10', 34999.00, 'Shipped', 'Credit Card', '258 Marine Drive, Kochi, Kerala 682001', '2024-05-15'),
(9, '2024-05-20', 8999.00, 'Delivered', 'Debit Card', '369 T Nagar, Chennai, Tamil Nadu 600001', '2024-05-25'),
(10, '2024-06-01', 399.00, 'Delivered', 'UPI', '741 Park Street, Kolkata, West Bengal 700001', '2024-06-05'),
(11, '2024-06-10', 599.00, 'Delivered', 'Cash on Delivery', '852 Hazratganj, Lucknow, Uttar Pradesh 226001', '2024-06-15'),
(12, '2024-06-20', 4999.00, 'Cancelled', 'Credit Card', '963 Race Course, Coimbatore, Tamil Nadu 641001', NULL),
(13, '2024-07-01', 2999.00, 'Delivered', 'UPI', '159 Sector 17, Chandigarh, Chandigarh 160001', '2024-07-05'),
(14, '2024-07-10', 71999.00, 'Shipped', 'Credit Card', '357 Malhar Mega Mall, Indore, Madhya Pradesh 452001', '2024-07-15'),
(15, '2024-07-15', 18999.00, 'Processing', 'Debit Card', '468 Vishwanath Gali, Varanasi, Uttar Pradesh 221001', NULL),
(16, '2024-07-20', 1999.00, 'Delivered', 'UPI', '579 Hall Gate, Amritsar, Punjab 143001', '2024-07-25'),
(17, '2024-08-01', 3999.00, 'Delivered', 'Cash on Delivery', '681 Boring Road, Patna, Bihar 800001', '2024-08-05'),
(18, '2024-08-10', 56999.00, 'Pending', 'Credit Card', '792 New Market, Bhopal, Madhya Pradesh 462001', NULL),
(19, '2024-08-15', 1999.00, 'Delivered', 'UPI', '814 Ring Road, Surat, Gujarat 395001', '2024-08-20'),
(20, '2024-08-20', 25998.00, 'Processing', 'Debit Card', '925 Sitabuldi, Nagpur, Maharashtra 440001', NULL);

-- INSERT ORDER_ITEMS (20 records)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 1, 89999.00, 89999.00),
(2, 2, 1, 74999.00, 74999.00),
(3, 3, 1, 114999.00, 114999.00),
(4, 5, 1, 24999.00, 24999.00),
(5, 6, 2, 8999.00, 17998.00),
(6, 7, 1, 3999.00, 3999.00),
(7, 8, 1, 2999.00, 2999.00),
(8, 9, 1, 34999.00, 34999.00),
(9, 10, 1, 8999.00, 8999.00),
(10, 11, 1, 399.00, 399.00),
(11, 12, 1, 599.00, 599.00),
(12, 13, 1, 4999.00, 4999.00),
(13, 14, 1, 2999.00, 2999.00),
(14, 15, 1, 71999.00, 71999.00),
(15, 16, 1, 18999.00, 18999.00),
(16, 17, 1, 1999.00, 1999.00),
(17, 18, 1, 3999.00, 3999.00),
(18, 19, 1, 56999.00, 56999.00),
(19, 20, 1, 1999.00, 1999.00),
(20, 5, 1, 24999.00, 24999.00);

-- INSERT PRODUCT_SUPPLIERS (20 records)
INSERT INTO product_suppliers (product_id, supplier_id, supply_price, last_supply_date) VALUES
(1, 1, 85000.00, '2024-01-10'),
(2, 6, 70000.00, '2024-01-15'),
(3, 7, 110000.00, '2024-02-05'),
(4, 7, 85000.00, '2024-02-10'),
(5, 8, 22000.00, '2024-02-28'),
(6, 9, 7500.00, '2024-03-05'),
(7, 9, 3500.00, '2024-03-10'),
(8, 10, 2500.00, '2024-03-25'),
(9, 11, 32000.00, '2024-04-05'),
(10, 11, 7500.00, '2024-04-10'),
(11, 13, 350.00, '2024-04-25'),
(12, 14, 520.00, '2024-04-30'),
(13, 15, 4500.00, '2024-05-05'),
(14, 16, 2700.00, '2024-05-10'),
(15, 17, 68000.00, '2024-05-25'),
(16, 18, 17000.00, '2024-05-30'),
(17, 19, 1800.00, '2024-06-05'),
(18, 20, 3500.00, '2024-06-10'),
(19, 6, 54000.00, '2024-06-25'),
(20, 8, 1700.00, '2024-06-30');

-- =====================================================
-- JOINS AND THEIR TYPES
-- =====================================================

-- 1. INNER JOIN
-- Find all orders with customer details
SELECT 
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.total_amount,
    o.order_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 2. LEFT JOIN
-- Show all customers and their orders (including customers without orders)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount,
    o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 3. RIGHT JOIN
-- Show all orders and customer details (including orders without customer info)
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount,
    o.order_date
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- 4. FULL OUTER JOIN (MySQL doesn't support FULL OUTER JOIN directly, use UNION)
-- Show all customers and orders (MySQL alternative using UNION)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. CROSS JOIN
-- Show all possible combinations of customers and categories
SELECT 
    c.first_name,
    c.last_name,
    cat.category_name
FROM customers c
CROSS JOIN categories cat
WHERE c.customer_id <= 3 AND cat.category_id <= 3;

-- 6. SELF JOIN
-- Find categories and their parent categories
SELECT 
    c1.category_name AS child_category,
    c2.category_name AS parent_category
FROM categories c1
INNER JOIN categories c2 ON c1.parent_category_id = c2.category_id;

-- 7. MULTIPLE TABLE JOINS
-- Complete order details with customer, product, and category information
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    oi.total_price
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN categories cat ON p.category_id = cat.category_id;

-- =====================================================
-- SUB-QUERIES
-- =====================================================

-- 1. SIMPLE SUB-QUERY
-- Find customers who have placed orders worth more than 50000
SELECT 
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE customer_id IN (
    SELECT customer_id 
    FROM orders 
    WHERE total_amount > 50000
);

-- 2. CORRELATED SUB-QUERY
-- Find customers with above-average order amounts
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    (SELECT AVG(total_amount) FROM orders o WHERE o.customer_id = c.customer_id) AS avg_order_amount
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id 
    AND o.total_amount > (SELECT AVG(total_amount) FROM orders)
);

-- 3. SUB-QUERY WITH AGGREGATE FUNCTIONS
-- Find products with price higher than average price in their category
SELECT 
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price) 
    FROM products p2 
    WHERE p2.category_id = p.category_id
);

-- 4. SUB-QUERY WITH EXISTS
-- Find customers who have placed orders in 2024
SELECT 
    customer_id,
    first_name,
    last_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id 
    AND YEAR(o.order_date) = 2024
);

-- 5. SUB-QUERY WITH NOT EXISTS
-- Find customers who haven't placed any orders
SELECT 
    customer_id,
    first_name,
    last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);

-- 6. SUB-QUERY WITH ANY/ALL
-- Find products cheaper than ANY Apple product
SELECT 
    product_name,
    price,
    brand
FROM products
WHERE price < ANY (
    SELECT price 
    FROM products 
    WHERE brand = 'Apple'
);

-- Find products more expensive than ALL Samsung products
SELECT 
    product_name,
    price,
    brand
FROM products
WHERE price > ALL (
    SELECT price 
    FROM products 
    WHERE brand = 'Samsung'
);

-- =====================================================
-- VIEWS
-- =====================================================

-- 1. SIMPLE VIEW
-- Create a view for customer order summary
CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    COUNT(o.order_id) as total_orders,
    COALESCE(AVG(o.total_amount), 0) as avg_order_amount,
    MAX(o.order_date) as last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city;

-- Query the view
SELECT * FROM customer_order_summary WHERE total_orders > 0;

-- 2. COMPLEX VIEW WITH JOINS
-- Create a view for product performance analysis
CREATE VIEW product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    p.brand,
    c.category_name,
    p.price,
    p.stock_quantity,
    COUNT(oi.order_item_id) as times_ordered,
    COALESCE(SUM(oi.quantity), 0) as total_quantity_sold,
    COALESCE(SUM(oi.total_price), 0) as total_revenue,
    COALESCE(AVG(oi.unit_price), 0) as avg_selling_price,
    CASE 
        WHEN COUNT(oi.order_item_id) > 0 THEN 'Active'
        ELSE 'No Sales'
    END as sales_status
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.brand, c.category_name, p.price, p.stock_quantity;

-- Query the view
SELECT * FROM product_performance ORDER BY total_revenue DESC;

-- 3. VIEW WITH AGGREGATION
-- Create a view for monthly sales report
CREATE VIEW monthly_sales_report AS
SELECT 
    YEAR(o.order_date) as year,
    MONTH(o.order_date) as month,
    MONTHNAME(o.order_date) as month_name,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_sales,
    AVG(o.total_amount) as avg_order_value,
    COUNT(DISTINCT o.customer_id) as unique_customers
FROM orders o
WHERE o.order_status != 'Cancelled'
GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date);

-- Query the view
SELECT * FROM monthly_sales_report ORDER BY year DESC, month DESC;

-- 4. VIEW FOR SUPPLIER ANALYSIS
CREATE VIEW supplier_performance AS
SELECT 
    s.supplier_id,
    s.supplier_name,
    s.city,
    s.state,
    s.rating,
    COUNT(ps.product_id) as products_supplied,
    AVG(ps.supply_price) as avg_supply_price,
    MAX(ps.last_supply_date) as last_supply_date,
    DATEDIFF(CURDATE(), MAX(ps.last_supply_date)) as days_since_last_supply
FROM suppliers s
LEFT JOIN product_suppliers ps ON s.supplier_id = ps.supplier_id
GROUP BY s.supplier_id, s.supplier_name, s.city, s.state, s.rating;

-- Query the view
SELECT * FROM supplier_performance ORDER BY rating DESC;

-- 5. VIEW FOR CATEGORY WISE SALES
CREATE VIEW category_sales_analysis AS
SELECT 
    c.category_id,
    c.category_name,
    COUNT(DISTINCT p.product_id) as total_products,
    COUNT(DISTINCT oi.order_item_id) as total_orders,
    SUM(oi.quantity) as total_quantity_sold,
    SUM(oi.total_price) as total_revenue,
    AVG(oi.unit_price) as avg_selling_price,
    MAX(oi.unit_price) as max_selling_price,
    MIN(oi.unit_price) as min_selling_price
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
HAVING total_revenue > 0;

-- Query the view
SELECT * FROM category_sales_analysis ORDER BY total_revenue DESC;

-- =====================================================
-- INDEXES
-- =====================================================

-- 1. SINGLE COLUMN INDEXES
-- Create index on frequently searched columns
CREATE INDEX idx_customer_email ON customers(email);
CREATE INDEX idx_customer_city ON customers(city);
CREATE INDEX idx_product_brand ON products(brand);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_order_status ON orders(order_status);

-- 2. COMPOSITE INDEXES
-- Create composite index for multiple column searches
CREATE INDEX idx_customer_city_state ON customers(city, state);
CREATE INDEX idx_product_category_price ON products(category_id, price);
CREATE INDEX idx_order_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_order_date_status ON orders(order_date, order_status);

-- 3. UNIQUE INDEXES
-- Create unique index (already exists on email due to UNIQUE constraint)
-- CREATE UNIQUE INDEX idx_unique_customer_email ON customers(email);

-- 4. PARTIAL INDEXES (MySQL doesn't support partial indexes like PostgreSQL)
-- Alternative: Use filtered queries with regular indexes

-- 5. FUNCTION-BASED INDEXES
-- Create index on expression (available in MySQL 8.0+)
CREATE INDEX idx_customer_full_name ON customers((CONCAT(first_name, ' ', last_name)));

-- =====================================================
-- PRACTICAL EXAMPLES AND QUERIES
-- =====================================================

-- 1. Find top 5 customers by total spending
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    SUM(o.total_amount) as total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spent DESC
LIMIT 5;

-- 2. Find products never ordered
SELECT 
    p.product_name,
    p.brand,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM order_items 
    WHERE product_id IS NOT NULL
);

-- 3. Find customers from Maharashtra with orders > 20000
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    o.order_date,
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.state = 'Maharashtra' 
AND o.total_amount > 20000
ORDER BY o.total_amount DESC;

-- 4. Find average order value by state
SELECT 
    c.state,
    COUNT(o.order_id) as total_orders,
    AVG(o.total_amount) as avg_order_value,
    MAX(o.total_amount) as max_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY avg_order_value DESC;

-- 5. Find products with low stock (less than 30 units)
SELECT 
    p.product_name,
    p.brand,
    p.stock_quantity,
    c.category_name,
    CASE 
        WHEN p.stock_quantity < 10 THEN 'Critical'
        WHEN p.stock_quantity < 20 THEN 'Low'
        WHEN p.stock_quantity < 30 THEN 'Medium'
        ELSE 'Good'
    END as stock_status
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.stock_quantity < 30
ORDER BY p.stock_quantity ASC;

-- 6. Monthly revenue growth analysis
SELECT 
    YEAR(order_date) as year,
    MONTH(order_date) as month,
    SUM(total_amount) as monthly_revenue,
    LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) as prev_month_revenue,
    ROUND(
        ((SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date))) / 
         LAG(SUM(total_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date))) * 100, 2
    ) as growth_percentage
FROM orders
WHERE order_status != 'Cancelled'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 7. Find suppliers with best price offers
SELECT 
    s.supplier_name,
    p.product_name,
    ps.supply_price,
    p.price as selling_price,
    (p.price - ps.supply_price) as profit_margin,
    ROUND(((p.price - ps.supply_price) / ps.supply_price) * 100, 2) as profit_percentage
FROM suppliers s
INNER JOIN product_suppliers ps ON s.supplier_id = ps.supplier_id
INNER JOIN products p ON ps.product_id = p.product_id
ORDER BY profit_percentage DESC;

-- =====================================================
-- PERFORMANCE OPTIMIZATION TIPS
-- =====================================================

-- 1. Use EXPLAIN to analyze query performance
EXPLAIN SELECT 
    c.first_name,
    c.last_name,
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.city = 'Mumbai';

-- 2. Use covering indexes for better performance
CREATE INDEX idx_covering_customer ON customers(city, customer_id, first_name, last_name);

-- 3. Avoid SELECT * in production queries
-- Bad: SELECT * FROM customers;
-- Good: SELECT customer_id, first_name, last_name FROM customers;

-- 4. Use LIMIT for pagination
SELECT 
    product_name,
    price,
    brand
FROM products
ORDER BY price DESC
LIMIT 10 OFFSET 0;

-- 5. Use appropriate data types and constraints
-- Already implemented in table creation

-- =====================================================
-- CLEANUP (Optional)
-- =====================================================

-- Drop views if needed
-- DROP VIEW IF EXISTS customer_order_summary;
-- DROP VIEW IF EXISTS product_performance;
-- DROP VIEW IF EXISTS monthly_sales_report;
-- DROP VIEW IF EXISTS supplier_performance;
-- DROP VIEW IF EXISTS category_sales_analysis;

-- Drop indexes if needed
-- DROP INDEX idx_customer_email ON customers;
-- DROP INDEX idx_customer_city ON customers;
-- etc.

-- =====================================================
-- SUMMARY
-- =====================================================

/*
This tutorial covers:

1. JOINS:
   - INNER JOIN: Returns matching records from both tables
   - LEFT JOIN: Returns all records from left table + matching from right
   - RIGHT JOIN: Returns all records from right table + matching from left
   - FULL OUTER JOIN: Returns all records when there's a match in either table
   - CROSS JOIN: Returns Cartesian product of both tables
   - SELF JOIN: Joins a table with itself

2. SUB-QUERIES:
   - Simple sub-queries with IN, EXISTS, ANY, ALL
   - Correlated sub-queries
   - Sub-queries with aggregate functions
   - Performance considerations

3. VIEWS:
   - Simple views for data abstraction
   - Complex views with joins and aggregations
   - Views for reporting and analysis
   - Updatable vs non-updatable views

4. INDEXES:
   - Single column indexes for faster searches
   - Composite indexes for multi-column queries
   - Unique indexes for data integrity
   - Function-based indexes for expression searches
   - Performance impact and maintenance

Best Practices:
- Use appropriate join types based on requirements
- Optimize sub-queries vs joins based on performance
- Create views for commonly used complex queries
- Index frequently queried columns
- Monitor and maintain index performance
- Use EXPLAIN to analyze query execution plans
*/SUM(o.total_amount), 0) as total_spent,
    COALESCE(