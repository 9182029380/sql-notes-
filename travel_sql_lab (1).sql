-- ============================================================================
-- TRAVEL APPLICATION - SQL JOINS LAB MANUAL
-- Database Systems Lab - Student Notes
-- ============================================================================

-- ============================================================================
-- LAB OBJECTIVES:
-- 1. Understand different types of SQL joins
-- 2. Practice with real-world travel application scenario
-- 3. Learn when to use each join type
-- 4. Master query optimization techniques
-- ============================================================================

-- ============================================================================
-- SECTION 1: TABLE CREATION & RELATIONSHIPS
-- ============================================================================

-- Create Airlines Table (Master Data)
CREATE TABLE airlines (
    airline_id INT PRIMARY KEY,
    airline_name VARCHAR(50) NOT NULL,
    airline_code VARCHAR(5) UNIQUE NOT NULL,
    country VARCHAR(30),
    fleet_size INT,
    founded_year INT
);

-- Create Flights Table (Operational Data)
CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    airline_id INT,
    flight_number VARCHAR(10) NOT NULL,
    departure_city VARCHAR(30) NOT NULL,
    arrival_city VARCHAR(30) NOT NULL,
    departure_time DATETIME,
    arrival_time DATETIME,
    aircraft_type VARCHAR(20),
    total_seats INT,
    base_price DECIMAL(8,2),
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

-- Create Passengers Table (Customer Data)
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    flight_id INT,
    passenger_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    seat_number VARCHAR(5),
    ticket_price DECIMAL(8,2),
    booking_date DATE,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- ============================================================================
-- SECTION 2: SAMPLE DATA INSERTION
-- ============================================================================

-- Insert 15 Airlines
INSERT INTO airlines (airline_id, airline_name, airline_code, country, fleet_size, founded_year) VALUES
(1, 'SkyHigh Airways', 'SHA', 'USA', 120, 1985),
(2, 'Global Wings', 'GW', 'UK', 85, 1992),
(3, 'AeroConnect', 'AC', 'Germany', 95, 1988),
(4, 'Pacific Air', 'PA', 'Japan', 75, 1995),
(5, 'Continental Express', 'CE', 'USA', 110, 1978),
(6, 'Nordic Flights', 'NF', 'Norway', 45, 2001),
(7, 'Desert Airlines', 'DA', 'UAE', 60, 1999),
(8, 'Mountain Air', 'MA', 'Switzerland', 35, 2005),
(9, 'Ocean Breeze', 'OB', 'Australia', 55, 1990),
(10, 'Sunrise Aviation', 'SA', 'India', 40, 2003),
(11, 'Liberty Airways', 'LA', 'USA', 90, 1983),
(12, 'Euro Connect', 'EC', 'France', 70, 1996),
(13, 'Asian Sky', 'AS', 'Singapore', 65, 1998),
(14, 'Polar Express', 'PE', 'Canada', 50, 2000),
(15, 'Tropical Wings', 'TW', 'Brazil', 80, 1994);

-- Insert 20 Flights
INSERT INTO flights (flight_id, airline_id, flight_number, departure_city, arrival_city, departure_time, arrival_time, aircraft_type, total_seats, base_price, status) VALUES
(101, 1, 'SHA001', 'New York', 'London', '2024-03-15 08:00:00', '2024-03-15 20:00:00', 'Boeing 777', 350, 899.99, 'Scheduled'),
(102, 1, 'SHA002', 'Los Angeles', 'Tokyo', '2024-03-15 10:30:00', '2024-03-16 15:30:00', 'Airbus A350', 300, 1299.99, 'Scheduled'),
(103, 2, 'GW101', 'London', 'Paris', '2024-03-15 14:00:00', '2024-03-15 15:30:00', 'Airbus A320', 180, 299.99, 'Scheduled'),
(104, 2, 'GW102', 'Manchester', 'Dubai', '2024-03-16 09:00:00', '2024-03-16 19:00:00', 'Boeing 787', 250, 799.99, 'Scheduled'),
(105, 3, 'AC201', 'Berlin', 'Rome', '2024-03-16 11:00:00', '2024-03-16 13:30:00', 'Airbus A319', 150, 399.99, 'Scheduled'),
(106, 4, 'PA301', 'Tokyo', 'Seoul', '2024-03-17 07:00:00', '2024-03-17 09:30:00', 'Boeing 737', 160, 349.99, 'Scheduled'),
(107, 5, 'CE401', 'Chicago', 'Miami', '2024-03-17 13:00:00', '2024-03-17 16:30:00', 'Airbus A321', 200, 499.99, 'Delayed'),
(108, 6, 'NF501', 'Oslo', 'Stockholm', '2024-03-18 12:00:00', '2024-03-18 13:30:00', 'Boeing 737', 140, 249.99, 'Scheduled'),
(109, 7, 'DA601', 'Dubai', 'Mumbai', '2024-03-18 16:00:00', '2024-03-18 20:30:00', 'Airbus A330', 280, 599.99, 'Scheduled'),
(110, 8, 'MA701', 'Zurich', 'Vienna', '2024-03-19 10:00:00', '2024-03-19 11:30:00', 'Embraer E190', 100, 199.99, 'Scheduled'),
(111, 9, 'OB801', 'Sydney', 'Melbourne', '2024-03-19 15:00:00', '2024-03-19 16:30:00', 'Boeing 737', 180, 299.99, 'Scheduled'),
(112, 10, 'SA901', 'Delhi', 'Bangalore', '2024-03-20 06:00:00', '2024-03-20 08:30:00', 'Airbus A320', 170, 199.99, 'Scheduled'),
(113, 11, 'LA001', 'Boston', 'Atlanta', '2024-03-20 14:00:00', '2024-03-20 17:00:00', 'Boeing 757', 220, 449.99, 'Cancelled'),
(114, 12, 'EC101', 'Paris', 'Barcelona', '2024-03-21 11:00:00', '2024-03-21 12:30:00', 'Airbus A319', 150, 279.99, 'Scheduled'),
(115, 13, 'AS201', 'Singapore', 'Bangkok', '2024-03-21 18:00:00', '2024-03-21 19:30:00', 'Boeing 737', 160, 329.99, 'Scheduled'),
-- Flights without airlines (for demonstration)
(116, 99, 'XX999', 'Unknown', 'Unknown', '2024-03-22 12:00:00', '2024-03-22 14:00:00', 'Unknown', 100, 0.00, 'Cancelled'),
(117, 98, 'YY888', 'Test City', 'Test Dest', '2024-03-22 15:00:00', '2024-03-22 17:00:00', 'Test', 50, 0.00, 'Cancelled'),
(118, 1, 'SHA003', 'San Francisco', 'Seattle', '2024-03-22 09:00:00', '2024-03-22 11:30:00', 'Boeing 737', 180, 399.99, 'Scheduled'),
(119, 2, 'GW103', 'London', 'Amsterdam', '2024-03-22 16:00:00', '2024-03-22 17:30:00', 'Airbus A320', 180, 249.99, 'Scheduled'),
(120, 3, 'AC202', 'Frankfurt', 'Munich', '2024-03-23 08:00:00', '2024-03-23 09:30:00', 'Boeing 737', 160, 199.99, 'Scheduled');

-- Insert 25 Passengers
INSERT INTO passengers (passenger_id, flight_id, passenger_name, email, phone, seat_number, ticket_price, booking_date, booking_status) VALUES
(1001, 101, 'John Anderson', 'john.anderson@email.com', '555-0101', '12A', 899.99, '2024-02-15', 'Confirmed'),
(1002, 101, 'Sarah Johnson', 'sarah.j@email.com', '555-0102', '12B', 899.99, '2024-02-15', 'Confirmed'),
(1003, 102, 'Michael Chen', 'michael.chen@email.com', '555-0103', '5F', 1299.99, '2024-02-20', 'Confirmed'),
(1004, 103, 'Emily Davis', 'emily.davis@email.com', '555-0104', '8C', 299.99, '2024-02-25', 'Confirmed'),
(1005, 103, 'Robert Wilson', 'robert.w@email.com', '555-0105', '8D', 299.99, '2024-02-25', 'Confirmed'),
(1006, 104, 'Lisa Brown', 'lisa.brown@email.com', '555-0106', '15A', 799.99, '2024-03-01', 'Confirmed'),
(1007, 105, 'David Martinez', 'david.m@email.com', '555-0107', '10B', 399.99, '2024-03-02', 'Confirmed'),
(1008, 106, 'Jennifer Taylor', 'jennifer.t@email.com', '555-0108', '7E', 349.99, '2024-03-03', 'Confirmed'),
(1009, 107, 'James Garcia', 'james.garcia@email.com', '555-0109', '11A', 499.99, '2024-03-04', 'Cancelled'),
(1010, 108, 'Maria Rodriguez', 'maria.r@email.com', '555-0110', '6C', 249.99, '2024-03-05', 'Confirmed'),
(1011, 109, 'Christopher Lee', 'chris.lee@email.com', '555-0111', '18F', 599.99, '2024-03-06', 'Confirmed'),
(1012, 110, 'Amanda White', 'amanda.white@email.com', '555-0112', '4A', 199.99, '2024-03-07', 'Confirmed'),
(1013, 111, 'Daniel Harris', 'daniel.h@email.com', '555-0113', '9B', 299.99, '2024-03-08', 'Confirmed'),
(1014, 112, 'Jessica Clark', 'jessica.c@email.com', '555-0114', '13D', 199.99, '2024-03-09', 'Confirmed'),
(1015, 113, 'Matthew Lewis', 'matthew.l@email.com', '555-0115', '16A', 449.99, '2024-03-10', 'Refunded'),
(1016, 114, 'Nicole Walker', 'nicole.w@email.com', '555-0116', '8B', 279.99, '2024-03-11', 'Confirmed'),
(1017, 115, 'Andrew Young', 'andrew.y@email.com', '555-0117', '12C', 329.99, '2024-03-12', 'Confirmed'),
(1018, 101, 'Samantha King', 'samantha.k@email.com', '555-0118', '14A', 899.99, '2024-02-18', 'Confirmed'),
(1019, 102, 'Ryan Wright', 'ryan.wright@email.com', '555-0119', '7A', 1299.99, '2024-02-22', 'Confirmed'),
(1020, 118, 'Ashley Green', 'ashley.g@email.com', '555-0120', '5B', 399.99, '2024-03-13', 'Confirmed'),
-- Passengers for non-existent flights (for demonstration)
(1021, 999, 'Test Passenger1', 'test1@email.com', '555-9999', '1A', 100.00, '2024-03-14', 'Error'),
(1022, 998, 'Test Passenger2', 'test2@email.com', '555-9998', '1B', 100.00, '2024-03-14', 'Error'),
(1023, 119, 'Kevin Scott', 'kevin.s@email.com', '555-0123', '10A', 249.99, '2024-03-15', 'Confirmed'),
(1024, 120, 'Rachel Adams', 'rachel.a@email.com', '555-0124', '8A', 199.99, '2024-03-16', 'Confirmed'),
(1025, 101, 'Brandon Hall', 'brandon.h@email.com', '555-0125', '16B', 899.99, '2024-02-28', 'Confirmed');

-- ============================================================================
-- SECTION 3: SQL JOINS THEORY & PRACTICAL EXAMPLES
-- ============================================================================

/* 
LAB LESSON 1: UNDERSTANDING JOIN RELATIONSHIPS

Table Relationships:
airlines (1) -----> (Many) flights
flights (1) -----> (Many) passengers

This creates a three-level hierarchy:
Airlines -> Flights -> Passengers
*/

-- ============================================================================
-- LESSON 2: INNER JOIN - The Foundation
-- ============================================================================

-- STUDENT NOTE: INNER JOIN returns only matching records from both tables
-- Use when you need complete, valid data from both tables

-- Example 1: Show flights with their airline information
SELECT 
    a.airline_name,
    a.airline_code,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.base_price,
    f.status
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id;

-- EXPLANATION: Only flights that have valid airline records will appear
-- Flights with invalid airline_id (like 99, 98) won't show up

-- Example 2: Show passengers with their flight details
SELECT 
    p.passenger_name,
    p.seat_number,
    p.ticket_price,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id;

-- EXPLANATION: Only passengers with valid flights will appear
-- Passengers with invalid flight_id won't show up

-- ============================================================================
-- LESSON 3: THREE-TABLE INNER JOIN
-- ============================================================================

-- STUDENT NOTE: You can join multiple tables in a single query
-- This shows the complete travel booking information

SELECT 
    a.airline_name,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    p.passenger_name,
    p.seat_number,
    p.ticket_price,
    p.booking_status
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
INNER JOIN passengers p ON f.flight_id = p.flight_id
WHERE p.booking_status = 'Confirmed'
ORDER BY a.airline_name, f.flight_number;

-- ============================================================================
-- LESSON 4: LEFT JOIN - Keep All Records from Left Table
-- ============================================================================

-- STUDENT NOTE: LEFT JOIN shows ALL airlines, even those without flights
-- Missing data appears as NULL

-- Example 1: All airlines and their flights (if any)
SELECT 
    a.airline_name,
    a.country,
    a.fleet_size,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.status
FROM airlines a
LEFT JOIN flights f ON a.airline_id = f.airline_id
ORDER BY a.airline_name;

-- Example 2: Find airlines with NO flights
SELECT 
    a.airline_name,
    a.country,
    a.fleet_size
FROM airlines a
LEFT JOIN flights f ON a.airline_id = f.airline_id
WHERE f.airline_id IS NULL;

-- Example 3: All flights and their passengers (if any)
SELECT 
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.total_seats,
    COUNT(p.passenger_id) as booked_passengers,
    (f.total_seats - COUNT(p.passenger_id)) as available_seats
FROM flights f
LEFT JOIN passengers p ON f.flight_id = p.flight_id
GROUP BY f.flight_id, f.flight_number, f.departure_city, f.arrival_city, f.total_seats
ORDER BY available_seats DESC;

-- ============================================================================
-- LESSON 5: RIGHT JOIN - Keep All Records from Right Table
-- ============================================================================

-- STUDENT NOTE: RIGHT JOIN shows ALL flights, even those without valid airlines
-- Less commonly used but useful for data validation

SELECT 
    a.airline_name,
    a.airline_code,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.status
FROM airlines a
RIGHT JOIN flights f ON a.airline_id = f.airline_id
ORDER BY f.flight_number;

-- Find flights with invalid airline references
SELECT 
    f.flight_id,
    f.flight_number,
    f.airline_id,
    f.departure_city,
    f.arrival_city
FROM airlines a
RIGHT JOIN flights f ON a.airline_id = f.airline_id
WHERE a.airline_id IS NULL;

-- ============================================================================
-- LESSON 6: FULL OUTER JOIN - Everything from Both Tables
-- ============================================================================

-- STUDENT NOTE: FULL OUTER JOIN shows all records from both tables
-- Useful for complete data auditing

SELECT 
    a.airline_name,
    a.airline_code,
    f.flight_number,
    f.departure_city,
    f.arrival_city
FROM airlines a
FULL OUTER JOIN flights f ON a.airline_id = f.airline_id
ORDER BY a.airline_name, f.flight_number;

-- ============================================================================
-- LESSON 7: PRACTICAL BUSINESS QUERIES
-- ============================================================================

-- Query 1: Revenue by airline
SELECT 
    a.airline_name,
    a.country,
    COUNT(p.passenger_id) as total_passengers,
    SUM(p.ticket_price) as total_revenue,
    AVG(p.ticket_price) as avg_ticket_price
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
INNER JOIN passengers p ON f.flight_id = p.flight_id
WHERE p.booking_status = 'Confirmed'
GROUP BY a.airline_id, a.airline_name, a.country
ORDER BY total_revenue DESC;

-- Query 2: Most popular routes
SELECT 
    f.departure_city,
    f.arrival_city,
    COUNT(p.passenger_id) as passenger_count,
    AVG(p.ticket_price) as avg_price
FROM flights f
INNER JOIN passengers p ON f.flight_id = p.flight_id
WHERE p.booking_status = 'Confirmed'
GROUP BY f.departure_city, f.arrival_city
HAVING COUNT(p.passenger_id) > 1
ORDER BY passenger_count DESC;

-- Query 3: Flight utilization report
SELECT 
    a.airline_name,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.total_seats,
    COUNT(p.passenger_id) as booked_seats,
    ROUND((COUNT(p.passenger_id) * 100.0 / f.total_seats), 2) as utilization_percent
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
LEFT JOIN passengers p ON f.flight_id = p.flight_id AND p.booking_status = 'Confirmed'
GROUP BY a.airline_name, f.flight_id, f.flight_number, f.departure_city, f.arrival_city, f.total_seats
ORDER BY utilization_percent DESC;

-- ============================================================================
-- SECTION 4: PRACTICE QUESTIONS FOR STUDENTS
-- ============================================================================

/*
BASIC LEVEL QUESTIONS:

1. Write a query to show all confirmed passengers with their flight details.

2. Find all airlines from the USA and their flight count.

3. List all flights scheduled for March 15, 2024, with airline names.

4. Show passengers who have cancelled their bookings.

5. Find the most expensive ticket price for each airline.

INTERMEDIATE LEVEL QUESTIONS:

6. Which flights have no passengers booked?

7. Calculate the total revenue for each country's airlines.

8. Find airlines that have more than 2 flights scheduled.

9. Show the average ticket price for each departure city.

10. List passengers flying on Boeing aircraft only.

ADVANCED LEVEL QUESTIONS:

11. Find the airline with the highest average ticket price.

12. Which routes (departure-arrival city pairs) generate the most revenue?

13. Show flights that are over 80% booked.

14. Find passengers who paid more than the average price for their route.

15. Create a report showing airline performance (total flights, passengers, revenue).
*/

-- ============================================================================
-- SECTION 5: SAMPLE SOLUTIONS FOR PRACTICE
-- ============================================================================

-- Solution 1: Confirmed passengers with flight details
SELECT 
    p.passenger_name,
    p.seat_number,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id
WHERE p.booking_status = 'Confirmed';

-- Solution 2: USA airlines and flight count
SELECT 
    a.airline_name,
    a.airline_code,
    COUNT(f.flight_id) as flight_count
FROM airlines a
LEFT JOIN flights f ON a.airline_id = f.airline_id
WHERE a.country = 'USA'
GROUP BY a.airline_id, a.airline_name, a.airline_code
ORDER BY flight_count DESC;

-- Solution 6: Flights with no passengers
SELECT 
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time,
    f.total_seats
FROM flights f
LEFT JOIN passengers p ON f.flight_id = p.flight_id
WHERE p.flight_id IS NULL;

-- Solution 11: Airline with highest average ticket price
SELECT 
    a.airline_name,
    AVG(p.ticket_price) as avg_ticket_price
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
INNER JOIN passengers p ON f.flight_id = p.flight_id
WHERE p.booking_status = 'Confirmed'
GROUP BY a.airline_id, a.airline_name
ORDER BY avg_ticket_price DESC
LIMIT 1;

-- ============================================================================
-- SECTION 6: PERFORMANCE OPTIMIZATION NOTES
-- ============================================================================

-- Create indexes for better join performance
CREATE INDEX idx_flights_airline_id ON flights(airline_id);
CREATE INDEX idx_passengers_flight_id ON passengers(flight_id);
CREATE INDEX idx_passengers_status ON passengers(booking_status);
CREATE INDEX idx_flights_status ON flights(status);

-- ============================================================================
-- SECTION 7: COMMON MISTAKES & TROUBLESHOOTING
-- ============================================================================

/*
COMMON STUDENT MISTAKES:

1. Forgetting the ON clause in joins
   WRONG: SELECT * FROM airlines JOIN flights
   RIGHT: SELECT * FROM airlines JOIN flights ON airlines.airline_id = flights.airline_id

2. Using INNER JOIN when LEFT JOIN is needed
   - Use INNER JOIN only when you want matching records from both tables
   - Use LEFT JOIN when you want all records from the left table

3. Not handling NULL values
   - When using LEFT/RIGHT JOIN, expect NULL values
   - Use IS NULL / IS NOT NULL for checking

4. Confusing join types
   - INNER: Only matching records
   - LEFT: All from left + matching from right
   - RIGHT: All from right + matching from left
   - FULL OUTER: All from both tables

5. Performance issues
   - Always join on indexed columns
   - Filter early with WHERE clauses
   - Avoid SELECT * in production queries
*/

-- ============================================================================
-- SECTION 8: DATABASE VIEWS - SIMPLIFYING COMPLEX QUERIES
-- ============================================================================

/*
WHAT ARE VIEWS?
- Virtual tables created from SQL queries
- Don't store data physically, just the query definition
- Provide simplified access to complex joins
- Enhance security by hiding sensitive columns
- Create reusable query components

BENEFITS OF VIEWS:
1. Simplify complex queries for end users
2. Provide data security and access control
3. Create consistent data presentation
4. Hide implementation details
5. Improve query reusability
*/

-- ============================================================================
-- LESSON 8.1: BASIC VIEWS
-- ============================================================================

-- View 1: Flight Summary - Combines flights with airline info
CREATE VIEW flight_summary AS
SELECT 
    f.flight_id,
    a.airline_name,
    a.airline_code,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time,
    f.arrival_time,
    f.aircraft_type,
    f.total_seats,
    f.base_price,
    f.status
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id;

-- Using the view (much simpler than writing the full join every time)
SELECT * FROM flight_summary 
WHERE departure_city = 'London';

-- View 2: Passenger Bookings - Complete booking information
CREATE VIEW passenger_bookings AS
SELECT 
    p.passenger_id,
    p.passenger_name,
    p.email,
    p.seat_number,
    p.ticket_price,
    p.booking_date,
    p.booking_status,
    f.flight_number,
    a.airline_name,
    f.departure_city,
    f.arrival_city,
    f.departure_time
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id
INNER JOIN airlines a ON f.airline_id = a.airline_id;

-- Using the passenger bookings view
SELECT * FROM passenger_bookings 
WHERE booking_status = 'Confirmed' 
ORDER BY departure_time;

-- ============================================================================
-- LESSON 8.2: ANALYTICAL VIEWS
-- ============================================================================

-- View 3: Airline Performance Dashboard
CREATE VIEW airline_performance AS
SELECT 
    a.airline_id,
    a.airline_name,
    a.country,
    a.fleet_size,
    COUNT(DISTINCT f.flight_id) as total_flights,
    COUNT(DISTINCT p.passenger_id) as total_passengers,
    COALESCE(SUM(p.ticket_price), 0) as total_revenue,
    COALESCE(AVG(p.ticket_price), 0) as avg_ticket_price,
    COUNT(DISTINCT CASE WHEN f.status = 'Scheduled' THEN f.flight_id END) as scheduled_flights,
    COUNT(DISTINCT CASE WHEN f.status = 'Delayed' THEN f.flight_id END) as delayed_flights,
    COUNT(DISTINCT CASE WHEN f.status = 'Cancelled' THEN f.flight_id END) as cancelled_flights
FROM airlines a
LEFT JOIN flights f ON a.airline_id = f.airline_id
LEFT JOIN passengers p ON f.flight_id = p.flight_id AND p.booking_status = 'Confirmed'
GROUP BY a.airline_id, a.airline_name, a.country, a.fleet_size;

-- Using the performance view
SELECT 
    airline_name,
    country,
    total_flights,
    total_passengers,
    ROUND(total_revenue, 2) as revenue,
    ROUND(avg_ticket_price, 2) as avg_price
FROM airline_performance 
WHERE total_flights > 0
ORDER BY total_revenue DESC;

-- View 4: Flight Utilization Report
CREATE VIEW flight_utilization AS
SELECT 
    f.flight_id,
    a.airline_name,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.total_seats,
    COUNT(p.passenger_id) as booked_seats,
    (f.total_seats - COUNT(p.passenger_id)) as available_seats,
    ROUND((COUNT(p.passenger_id) * 100.0 / f.total_seats), 2) as utilization_percent,
    CASE 
        WHEN COUNT(p.passenger_id) * 100.0 / f.total_seats >= 90 THEN 'High'
        WHEN COUNT(p.passenger_id) * 100.0 / f.total_seats >= 70 THEN 'Medium'
        ELSE 'Low'
    END as utilization_category
FROM flights f
INNER JOIN airlines a ON f.airline_id = a.airline_id
LEFT JOIN passengers p ON f.flight_id = p.flight_id AND p.booking_status = 'Confirmed'
GROUP BY f.flight_id, a.airline_name, f.flight_number, f.departure_city, f.arrival_city, f.total_seats;

-- Using the utilization view
SELECT * FROM flight_utilization 
WHERE utilization_category = 'High'
ORDER BY utilization_percent DESC;

-- ============================================================================
-- LESSON 8.3: SPECIALIZED VIEWS FOR DIFFERENT USER ROLES
-- ============================================================================

-- View 5: Customer Service View (Limited passenger info)
CREATE VIEW customer_service_view AS
SELECT 
    p.passenger_id,
    p.passenger_name,
    p.email,
    p.seat_number,
    p.booking_status,
    f.flight_number,
    a.airline_name,
    f.departure_city,
    f.arrival_city,
    f.departure_time,
    f.status as flight_status
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id
INNER JOIN airlines a ON f.airline_id = a.airline_id;

-- View 6: Management Revenue Summary
CREATE VIEW revenue_summary AS
SELECT 
    DATE(p.booking_date) as booking_date,
    a.airline_name,
    a.country,
    COUNT(p.passenger_id) as bookings_count,
    SUM(p.ticket_price) as daily_revenue,
    AVG(p.ticket_price) as avg_ticket_price
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id
INNER JOIN airlines a ON f.airline_id = a.airline_id
WHERE p.booking_status = 'Confirmed'
GROUP BY DATE(p.booking_date), a.airline_name, a.country;

-- View 7: Route Analysis View
CREATE VIEW route_analysis AS
SELECT 
    f.departure_city,
    f.arrival_city,
    CONCAT(f.departure_city, ' → ', f.arrival_city) as route,
    COUNT(DISTINCT f.flight_id) as total_flights,
    COUNT(p.passenger_id) as total_passengers,
    AVG(p.ticket_price) as avg_price,
    SUM(p.ticket_price) as total_revenue,
    AVG(f.total_seats) as avg_aircraft_size
FROM flights f
LEFT JOIN passengers p ON f.flight_id = p.flight_id AND p.booking_status = 'Confirmed'
GROUP BY f.departure_city, f.arrival_city;

-- ============================================================================
-- LESSON 8.4: PRACTICAL VIEW USAGE EXAMPLES
-- ============================================================================

-- Example 1: Find underutilized flights
SELECT 
    airline_name,
    flight_number,
    departure_city,
    arrival_city,
    utilization_percent
FROM flight_utilization
WHERE utilization_percent < 50
ORDER BY utilization_percent ASC;

-- Example 2: Top performing airlines
SELECT 
    airline_name,
    country,
    total_passengers,
    ROUND(total_revenue, 2) as revenue,
    scheduled_flights,
    delayed_flights,
    cancelled_flights
FROM airline_performance
WHERE total_flights > 1
ORDER BY total_revenue DESC
LIMIT 5;

-- Example 3: Daily revenue trends
SELECT 
    booking_date,
    SUM(daily_revenue) as total_daily_revenue,
    SUM(bookings_count) as total_bookings,
    AVG(avg_ticket_price) as overall_avg_price
FROM revenue_summary
GROUP BY booking_date
ORDER BY booking_date DESC;

-- Example 4: Most popular routes
SELECT 
    route,
    total_flights,
    total_passengers,
    ROUND(avg_price, 2) as avg_ticket_price,
    ROUND(total_revenue, 2) as route_revenue
FROM route_analysis
WHERE total_passengers > 0
ORDER BY total_passengers DESC
LIMIT 10;

-- ============================================================================
-- LESSON 8.5: VIEW MANAGEMENT OPERATIONS
-- ============================================================================

-- Check if a view exists
SELECT TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'VIEW' AND TABLE_SCHEMA = DATABASE();

-- View the definition of a view
SHOW CREATE VIEW flight_summary;

-- Update a view (recreate with OR REPLACE)
CREATE OR REPLACE VIEW flight_summary AS
SELECT 
    f.flight_id,
    a.airline_name,
    a.airline_code,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time,
    f.aircraft_type,
    f.total_seats,
    f.base_price,
    f.status,
    -- Added new column
    TIMEDIFF(f.arrival_time, f.departure_time) as flight_duration
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id;

-- Drop a view when no longer needed
-- DROP VIEW IF EXISTS view_name;

-- ============================================================================
-- LESSON 8.6: VIEW PRACTICE QUESTIONS FOR STUDENTS
-- ============================================================================

/*
VIEW PRACTICE EXERCISES:

BASIC LEVEL:
1. Create a view showing only active flights with airline names.
2. Create a view for confirmed passengers with their contact information.
3. Write a query using flight_summary view to find all Boeing flights.

INTERMEDIATE LEVEL:
4. Create a view showing flights departing today with passenger count.
5. Use the airline_performance view to find airlines with zero cancelled flights.
6. Create a view for premium passengers (ticket price > $500).

ADVANCED LEVEL:
7. Create a materialized view simulation for monthly revenue reports.
8. Design a view that shows overbooking situations (if any).
9. Create a security view that hides sensitive passenger information.
10. Build a view that combines all three tables with calculated fields.
*/

-- ============================================================================
-- LESSON 8.7: VIEW ADVANTAGES & LIMITATIONS
-- ============================================================================

/*
ADVANTAGES OF VIEWS:
✓ Simplify complex queries for end users
✓ Provide data security by hiding sensitive columns
✓ Create reusable query components
✓ Maintain consistent data presentation
✓ Abstract database structure changes
✓ Enable role-based data access

LIMITATIONS OF VIEWS:
✗ Performance can be slower than direct table access
✗ Complex views may not be updatable
✗ Dependency management (if underlying tables change)
✗ No indexes on views (in most databases)
✗ May hide performance issues in underlying queries

BEST PRACTICES:
1. Use descriptive view names
2. Document view purposes and dependencies
3. Avoid views based on other views (deep nesting)
4. Consider performance implications
5. Use views for security and simplification, not just convenience
6. Regular maintenance and optimization
*/

-- Sample Solutions for View Practice Questions

-- Solution 1: Active flights with airline names
CREATE VIEW active_flights AS
SELECT 
    a.airline_name,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_time,
    f.status
FROM airlines a
INNER JOIN flights f ON a.airline_id = f.airline_id
WHERE f.status IN ('Scheduled', 'Delayed');

-- Solution 6: Premium passengers view
CREATE VIEW premium_passengers AS
SELECT 
    p.passenger_name,
    p.email,
    p.ticket_price,
    f.flight_number,
    a.airline_name,
    f.departure_city,
    f.arrival_city
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id
INNER JOIN airlines a ON f.airline_id = a.airline_id
WHERE p.ticket_price > 500 AND p.booking_status = 'Confirmed';

-- ============================================================================
-- SECTION 9: LAB SUMMARY & KEY TAKEAWAYS
-- ============================================================================

/*
STUDENT SUMMARY:

KEY CONCEPTS LEARNED:
✓ SQL Join types and when to use each
✓ Multi-table relationships in travel applications
✓ Real-world business query examples
✓ Data validation using joins
✓ Performance considerations

JOIN SELECTION GUIDE:
- Need only complete data? → INNER JOIN
- Need all from left table? → LEFT JOIN
- Need all from right table? → RIGHT JOIN
- Need everything? → FULL OUTER JOIN
- Need to find missing relationships? → LEFT/RIGHT JOIN with IS NULL

REMEMBER:
1. Always specify the ON condition
2. Think about what data you actually need
3. Consider NULL values in outer joins
4. Use appropriate indexes for performance
5. Test with small datasets first

NEXT STEPS:
- Practice with the provided questions
- Try creating your own travel scenarios
- Experiment with different join combinations
- Focus on understanding business requirements
*/