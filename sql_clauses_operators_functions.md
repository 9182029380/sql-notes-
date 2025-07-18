# SQL Clauses, Operators, and Functions - TripMaster Case Study

## Executive Summary

This comprehensive study examines SQL clauses, operators, and functions through the lens of the TripMaster travel application database. Students will learn how these fundamental SQL components work together to create powerful queries for data retrieval, manipulation, and analysis in real-world business scenarios. The case study demonstrates practical applications of WHERE clauses, JOIN operations, aggregate functions, and advanced SQL features that are essential for modern database applications.

---

## 1. SQL Clauses - Foundation of Query Structure

### 1.1 Understanding SQL Clauses

SQL clauses are the building blocks of SQL statements that define how data should be retrieved, filtered, grouped, and ordered. In the TripMaster application, clauses help users find specific trips, analyze booking patterns, and generate meaningful reports.

### 1.2 SELECT Clause - Data Retrieval Foundation

The SELECT clause determines which columns to retrieve from the database tables.

```sql
-- Basic SELECT examples for TripMaster
-- Retrieve all user information
SELECT * FROM users;

-- Retrieve specific columns for user profile display
SELECT user_id, first_name, last_name, email, registration_date 
FROM users;

-- Using aliases for better presentation
SELECT 
    user_id AS 'User ID',
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    email AS 'Email Address',
    registration_date AS 'Member Since'
FROM users;

-- Retrieve calculated columns for trip analysis
SELECT 
    trip_id,
    trip_name,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS 'Trip Duration (Days)',
    total_budget,
    ROUND(total_budget / DATEDIFF(end_date, start_date), 2) AS 'Daily Budget'
FROM trips;
```

### 1.3 FROM Clause - Specifying Data Sources

The FROM clause identifies the tables or views from which to retrieve data.

```sql
-- Single table queries
SELECT destination_name, country, average_cost_per_day
FROM destinations;

-- Multiple table sources (will be covered in JOIN section)
SELECT u.first_name, u.last_name, t.trip_name
FROM users u, trips t
WHERE u.user_id = t.user_id;
```

### 1.4 WHERE Clause - Data Filtering

The WHERE clause filters records based on specified conditions, crucial for finding specific information in the TripMaster system.

```sql
-- Simple WHERE conditions for user queries
SELECT * FROM users 
WHERE is_active = TRUE;

-- Date-based filtering for trip planning
SELECT * FROM trips 
WHERE start_date >= '2024-06-01' AND start_date <= '2024-12-31';

-- Budget-based filtering for cost-conscious travelers
SELECT trip_name, destination_id, total_budget
FROM trips 
WHERE total_budget BETWEEN 1000 AND 3000;

-- Status-based filtering for trip management
SELECT * FROM trips 
WHERE trip_status IN ('planned', 'ongoing');

-- Text pattern matching for destination search
SELECT * FROM destinations 
WHERE destination_name LIKE '%Tower%' OR city LIKE 'Paris%';

-- Complex conditions for business intelligence
SELECT 
    u.first_name,
    u.last_name,
    t.trip_name,
    t.total_budget
FROM users u
JOIN trips t ON u.user_id = t.user_id
WHERE t.total_budget > 2000 
  AND t.trip_status = 'completed'
  AND u.registration_date >= '2024-01-01';
```

### 1.5 GROUP BY Clause - Data Aggregation

The GROUP BY clause groups rows sharing common values for aggregate calculations.

```sql
-- User trip statistics
SELECT 
    user_id,
    COUNT(*) AS total_trips,
    AVG(total_budget) AS average_budget,
    MAX(total_budget) AS highest_budget,
    MIN(total_budget) AS lowest_budget
FROM trips
GROUP BY user_id;

-- Destination popularity analysis
SELECT 
    d.destination_name,
    d.country,
    COUNT(t.trip_id) AS trip_count,
    AVG(t.total_budget) AS avg_trip_cost
FROM destinations d
JOIN trips t ON d.destination_id = t.destination_id
GROUP BY d.destination_id, d.destination_name, d.country;

-- Monthly booking patterns
SELECT 
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month,
    booking_type,
    COUNT(*) AS total_bookings,
    SUM(total_amount) AS total_revenue
FROM bookings
WHERE booking_status = 'confirmed'
GROUP BY YEAR(booking_date), MONTH(booking_date), booking_type;
```

### 1.6 HAVING Clause - Filtering Grouped Data

The HAVING clause filters groups after GROUP BY operations, unlike WHERE which filters individual rows.

```sql
-- Find users with multiple trips
SELECT 
    user_id,
    COUNT(*) AS trip_count,
    AVG(total_budget) AS avg_budget
FROM trips
GROUP BY user_id
HAVING COUNT(*) >= 2;

-- Popular destinations with high average ratings
SELECT 
    d.destination_name,
    COUNT(r.review_id) AS review_count,
    AVG(r.rating) AS avg_rating
FROM destinations d
JOIN reviews r ON d.destination_id = r.destination_id
GROUP BY d.destination_id, d.destination_name
HAVING COUNT(r.review_id) >= 2 AND AVG(r.rating) >= 4.0;

-- High-value booking analysis
SELECT 
    booking_type,
    COUNT(*) AS booking_count,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_booking_value
FROM bookings
WHERE booking_status = 'confirmed'
GROUP BY booking_type
HAVING SUM(total_amount) > 1000;
```

### 1.7 ORDER BY Clause - Result Sorting

The ORDER BY clause sorts query results in ascending or descending order.

```sql
-- Sort users by registration date
SELECT first_name, last_name, email, registration_date
FROM users
ORDER BY registration_date DESC;

-- Sort trips by budget and date
SELECT trip_name, start_date, total_budget
FROM trips
ORDER BY total_budget DESC, start_date ASC;

-- Complex sorting with calculated columns
SELECT 
    u.first_name,
    u.last_name,
    t.trip_name,
    t.total_budget,
    DATEDIFF(t.end_date, t.start_date) AS duration,
    ROUND(t.total_budget / DATEDIFF(t.end_date, t.start_date), 2) AS daily_cost
FROM users u
JOIN trips t ON u.user_id = t.user_id
ORDER BY daily_cost DESC, duration ASC;
```

### 1.8 LIMIT Clause - Result Limitation

The LIMIT clause restricts the number of rows returned, useful for pagination and top-N queries.

```sql
-- Top 5 most expensive trips
SELECT trip_name, total_budget, start_date
FROM trips
ORDER BY total_budget DESC
LIMIT 5;

-- Pagination for user listing (page 2, 10 users per page)
SELECT user_id, first_name, last_name, email
FROM users
ORDER BY user_id
LIMIT 10 OFFSET 10;

-- Recent reviews with limit
SELECT 
    r.review_title,
    r.rating,
    r.review_date,
    u.first_name,
    d.destination_name
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN destinations d ON r.destination_id = d.destination_id
ORDER BY r.review_date DESC
LIMIT 10;
```

---

## 2. SQL Operators - Data Comparison and Manipulation

### 2.1 Arithmetic Operators

Arithmetic operators perform mathematical calculations on numerical data.

```sql
-- Budget calculations and financial analysis
SELECT 
    trip_name,
    total_budget,
    actual_cost,
    (total_budget - actual_cost) AS budget_remaining,
    (actual_cost / total_budget) * 100 AS budget_utilization_percent,
    ROUND((total_budget - actual_cost) / DATEDIFF(end_date, start_date), 2) AS daily_savings
FROM trips
WHERE actual_cost IS NOT NULL;

-- Booking cost analysis with arithmetic operations
SELECT 
    booking_reference,
    booking_type,
    total_amount,
    total_amount * 0.1 AS tax_amount,
    total_amount + (total_amount * 0.1) AS total_with_tax,
    DATEDIFF(check_out_date, check_in_date) AS nights,
    ROUND(total_amount / DATEDIFF(check_out_date, check_in_date), 2) AS cost_per_night
FROM bookings
WHERE booking_type = 'hotel' AND check_out_date IS NOT NULL;
```

### 2.2 Comparison Operators

Comparison operators compare values and return boolean results.

```sql
-- Equal to (=) - Find specific trips
SELECT * FROM trips WHERE trip_status = 'completed';

-- Not equal to (!=, <>) - Exclude certain conditions
SELECT * FROM users WHERE is_active != FALSE;
SELECT * FROM bookings WHERE booking_status <> 'cancelled';

-- Greater than (>) and Less than (<) - Numeric comparisons
SELECT * FROM trips WHERE total_budget > 2500;
SELECT * FROM destinations WHERE average_cost_per_day < 100;

-- Greater than or equal to (>=) and Less than or equal to (<=)
SELECT * FROM trips WHERE start_date >= '2024-06-01';
SELECT * FROM reviews WHERE rating <= 3;

-- Complex comparison scenarios
SELECT 
    u.first_name,
    u.last_name,
    t.trip_name,
    t.total_budget,
    t.actual_cost
FROM users u
JOIN trips t ON u.user_id = t.user_id
WHERE t.actual_cost > t.total_budget * 0.9  -- Over 90% of budget used
  AND t.trip_status = 'completed';
```

### 2.3 Logical Operators

Logical operators combine multiple conditions in WHERE clauses.

```sql
-- AND operator - Multiple conditions must be true
SELECT * FROM trips 
WHERE start_date >= '2024-06-01' 
  AND total_budget BETWEEN 1000 AND 3000 
  AND trip_status = 'planned';

-- OR operator - At least one condition must be true
SELECT * FROM destinations 
WHERE country = 'France' 
  OR country = 'Italy' 
  OR average_cost_per_day < 100;

-- NOT operator - Negates a condition
SELECT * FROM users 
WHERE NOT (is_active = FALSE);

-- Complex logical combinations
SELECT 
    t.trip_name,
    t.start_date,
    t.trip_status,
    t.total_budget
FROM trips t
JOIN users u ON t.user_id = u.user_id
WHERE (t.trip_status = 'planned' OR t.trip_status = 'ongoing')
  AND t.total_budget > 2000
  AND NOT (u.registration_date < '2024-01-01');
```

### 2.4 Pattern Matching Operators

Pattern matching operators are used for text searching and filtering.

```sql
-- LIKE operator with wildcards
-- % represents zero or more characters
SELECT * FROM destinations 
WHERE destination_name LIKE '%Tower%';

-- _ represents exactly one character
SELECT * FROM users 
WHERE first_name LIKE 'J_hn';

-- Case-insensitive pattern matching
SELECT * FROM destinations 
WHERE LOWER(city) LIKE '%paris%';

-- Multiple pattern matching
SELECT * FROM trips 
WHERE trip_name LIKE '%Adventure%' 
  OR trip_name LIKE '%Explorer%' 
  OR trip_name LIKE '%Discovery%';

-- NOT LIKE for exclusion
SELECT * FROM destinations 
WHERE destination_name NOT LIKE '%Museum%';
```

### 2.5 Range and Set Operators

Range and set operators check if values fall within specified ranges or sets.

```sql
-- BETWEEN operator for range checking
SELECT * FROM trips 
WHERE start_date BETWEEN '2024-06-01' AND '2024-12-31';

SELECT * FROM destinations 
WHERE average_cost_per_day BETWEEN 100 AND 200;

-- IN operator for set membership
SELECT * FROM trips 
WHERE trip_status IN ('planned', 'ongoing');

SELECT * FROM bookings 
WHERE booking_type IN ('flight', 'hotel');

-- NOT IN for exclusion
SELECT * FROM users 
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM trips 
    WHERE trip_status = 'cancelled'
);

-- Combining range and set operators
SELECT 
    d.destination_name,
    d.country,
    d.average_cost_per_day
FROM destinations d
WHERE d.country IN ('France', 'Italy', 'Spain')
  AND d.average_cost_per_day BETWEEN 80 AND 180;
```

### 2.6 NULL Handling Operators

NULL operators handle missing or undefined values in the database.

```sql
-- IS NULL - Find records with missing values
SELECT * FROM users WHERE phone IS NULL;

SELECT * FROM trips WHERE actual_cost IS NULL;

-- IS NOT NULL - Find records with values
SELECT * FROM reviews WHERE review_text IS NOT NULL;

-- COALESCE for NULL handling in calculations
SELECT 
    trip_name,
    total_budget,
    actual_cost,
    COALESCE(actual_cost, 0) AS cost_with_default,
    total_budget - COALESCE(actual_cost, 0) AS remaining_budget
FROM trips;

-- NULLIF for conditional NULL assignment
SELECT 
    booking_reference,
    booking_type,
    NULLIF(total_amount, 0) AS valid_amount
FROM bookings;
```

---

## 3. SQL Functions - Data Processing and Analysis

### 3.1 String Functions

String functions manipulate and analyze text data in the TripMaster system.

```sql
-- CONCAT - Combine strings
SELECT 
    user_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(first_name, ' (', email, ')') AS name_with_email
FROM users;

-- LENGTH - String length calculation
SELECT 
    destination_name,
    LENGTH(destination_name) AS name_length,
    description,
    LENGTH(description) AS description_length
FROM destinations;

-- UPPER and LOWER - Case conversion
SELECT 
    UPPER(destination_name) AS destination_upper,
    LOWER(country) AS country_lower,
    INITCAP(city) AS city_proper
FROM destinations;

-- SUBSTRING - Extract parts of strings
SELECT 
    email,
    SUBSTRING(email, 1, POSITION('@' IN email) - 1) AS username,
    SUBSTRING(email, POSITION('@' IN email) + 1) AS domain
FROM users;

-- TRIM and string cleaning
SELECT 
    destination_name,
    TRIM(destination_name) AS clean_name,
    LTRIM(RTRIM(description)) AS clean_description
FROM destinations;

-- REPLACE - String replacement
SELECT 
    trip_name,
    REPLACE(trip_name, 'Adventure', 'Journey') AS modified_name
FROM trips;

-- String formatting for reports
SELECT 
    u.first_name,
    u.last_name,
    CONCAT(
        'Trip: ', t.trip_name, 
        ' | Destination: ', d.destination_name,
        ' | Budget: $', FORMAT(t.total_budget, 2)
    ) AS trip_summary
FROM users u
JOIN trips t ON u.user_id = t.user_id
JOIN destinations d ON t.destination_id = d.destination_id;
```

### 3.2 Numeric Functions

Numeric functions perform mathematical operations and calculations.

```sql
-- ROUND - Rounding numbers
SELECT 
    trip_name,
    total_budget,
    ROUND(total_budget, 0) AS rounded_budget,
    ROUND(total_budget / DATEDIFF(end_date, start_date), 2) AS daily_budget
FROM trips;

-- CEILING and FLOOR - Rounding up and down
SELECT 
    destination_name,
    average_cost_per_day,
    CEILING(average_cost_per_day) AS rounded_up,
    FLOOR(average_cost_per_day) AS rounded_down
FROM destinations;

-- ABS - Absolute value
SELECT 
    trip_name,
    total_budget,
    actual_cost,
    ABS(total_budget - actual_cost) AS budget_variance
FROM trips
WHERE actual_cost IS NOT NULL;

-- POWER and SQRT - Mathematical operations
SELECT 
    destination_name,
    average_cost_per_day,
    POWER(average_cost_per_day, 2) AS cost_squared,
    SQRT(average_cost_per_day) AS cost_sqrt
FROM destinations;

-- MOD - Modulo operation
SELECT 
    user_id,
    first_name,
    last_name,
    MOD(user_id, 2) AS user_group
FROM users;

-- GREATEST and LEAST - Comparison functions
SELECT 
    trip_name,
    total_budget,
    actual_cost,
    GREATEST(total_budget, COALESCE(actual_cost, 0)) AS max_cost,
    LEAST(total_budget, COALESCE(actual_cost, total_budget)) AS min_cost
FROM trips;
```

### 3.3 Date and Time Functions

Date and time functions are crucial for managing trip schedules and booking dates.

```sql
-- NOW and CURDATE - Current date and time
SELECT 
    trip_name,
    start_date,
    NOW() AS current_datetime,
    CURDATE() AS current_date,
    DATEDIFF(start_date, CURDATE()) AS days_until_trip
FROM trips
WHERE start_date > CURDATE();

-- YEAR, MONTH, DAY - Extract date parts
SELECT 
    booking_reference,
    booking_date,
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month,
    DAY(booking_date) AS booking_day,
    MONTHNAME(booking_date) AS month_name,
    DAYNAME(booking_date) AS day_name
FROM bookings;

-- DATEDIFF - Calculate date differences
SELECT 
    trip_name,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS trip_duration,
    DATEDIFF(start_date, CURDATE()) AS days_until_departure
FROM trips;

-- DATE_ADD and DATE_SUB - Date arithmetic
SELECT 
    trip_name,
    start_date,
    DATE_ADD(start_date, INTERVAL 7 DAY) AS week_after_start,
    DATE_SUB(start_date, INTERVAL 30 DAY) AS booking_deadline,
    DATE_ADD(end_date, INTERVAL 1 MONTH) AS next_possible_trip
FROM trips;

-- DATE_FORMAT - Format dates for display
SELECT 
    trip_name,
    DATE_FORMAT(start_date, '%W, %M %d, %Y') AS formatted_start,
    DATE_FORMAT(end_date, '%m/%d/%Y') AS formatted_end,
    DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS current_timestamp
FROM trips;

-- EXTRACT - Extract specific date parts
SELECT 
    booking_reference,
    booking_date,
    EXTRACT(YEAR FROM booking_date) AS year,
    EXTRACT(QUARTER FROM booking_date) AS quarter,
    EXTRACT(WEEK FROM booking_date) AS week_number
FROM bookings;

-- Age calculation and time-based analysis
SELECT 
    first_name,
    last_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 30 THEN 'Young Adult'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 50 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_group
FROM users
WHERE date_of_birth IS NOT NULL;
```

### 3.4 Aggregate Functions

Aggregate functions perform calculations on groups of rows to produce summary statistics.

```sql
-- COUNT - Count records
SELECT 
    COUNT(*) AS total_users,
    COUNT(phone) AS users_with_phone,
    COUNT(DISTINCT YEAR(registration_date)) AS active_years
FROM users;

-- SUM - Calculate totals
SELECT 
    user_id,
    COUNT(trip_id) AS total_trips,
    SUM(total_budget) AS total_planned_budget,
    SUM(COALESCE(actual_cost, 0)) AS total_actual_cost
FROM trips
GROUP BY user_id;

-- AVG - Calculate averages
SELECT 
    d.destination_name,
    COUNT(r.review_id) AS review_count,
    AVG(r.rating) AS average_rating,
    ROUND(AVG(r.rating), 2) AS rounded_avg_rating
FROM destinations d
LEFT JOIN reviews r ON d.destination_id = r.destination_id
GROUP BY d.destination_id, d.destination_name;

-- MAX and MIN - Find extremes
SELECT 
    booking_type,
    COUNT(*) AS booking_count,
    MAX(total_amount) AS highest_amount,
    MIN(total_amount) AS lowest_amount,
    AVG(total_amount) AS average_amount
FROM bookings
WHERE booking_status = 'confirmed'
GROUP BY booking_type;

-- Complex aggregate analysis
SELECT 
    YEAR(t.start_date) AS trip_year,
    MONTH(t.start_date) AS trip_month,
    COUNT(t.trip_id) AS trips_count,
    SUM(t.total_budget) AS total_budget,
    AVG(t.total_budget) AS avg_budget,
    MAX(t.total_budget) AS max_budget,
    MIN(t.total_budget) AS min_budget,
    STDDEV(t.total_budget) AS budget_stddev
FROM trips t
GROUP BY YEAR(t.start_date), MONTH(t.start_date)
ORDER BY trip_year, trip_month;
```

### 3.5 Window Functions

Window functions perform calculations across related rows without grouping.

```sql
-- ROW_NUMBER - Assign row numbers
SELECT 
    trip_name,
    total_budget,
    start_date,
    ROW_NUMBER() OVER (ORDER BY total_budget DESC) AS budget_rank,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY start_date) AS user_trip_sequence
FROM trips;

-- RANK and DENSE_RANK - Ranking with ties
SELECT 
    d.destination_name,
    COUNT(t.trip_id) AS trip_count,
    RANK() OVER (ORDER BY COUNT(t.trip_id) DESC) AS popularity_rank,
    DENSE_RANK() OVER (ORDER BY COUNT(t.trip_id) DESC) AS dense_rank
FROM destinations d
LEFT JOIN trips t ON d.destination_id = t.destination_id
GROUP BY d.destination_id, d.destination_name;

-- LAG and LEAD - Access previous/next rows
SELECT 
    user_id,
    trip_name,
    start_date,
    total_budget,
    LAG(total_budget, 1) OVER (PARTITION BY user_id ORDER BY start_date) AS previous_budget,
    LEAD(start_date, 1) OVER (PARTITION BY user_id ORDER BY start_date) AS next_trip_date
FROM trips
ORDER BY user_id, start_date;

-- Running totals and moving averages
SELECT 
    booking_date,
    booking_type,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY booking_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    AVG(total_amount) OVER (
        ORDER BY booking_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3_days
FROM bookings
WHERE booking_status = 'confirmed'
ORDER BY booking_date;
```

### 3.6 Conditional Functions

Conditional functions implement logic within SQL queries.

```sql
-- CASE - Complex conditional logic
SELECT 
    u.first_name,
    u.last_name,
    COUNT(t.trip_id) AS trip_count,
    SUM(t.total_budget) AS total_spending,
    CASE 
        WHEN COUNT(t.trip_id) >= 5 THEN 'VIP Customer'
        WHEN COUNT(t.trip_id) >= 3 THEN 'Regular Customer'
        WHEN COUNT(t.trip_id) >= 1 THEN 'Occasional Customer'
        ELSE 'New Customer'
    END AS customer_tier,
    CASE 
        WHEN SUM(t.total_budget) >= 10000 THEN 'High Value'
        WHEN SUM(t.total_budget) >= 5000 THEN 'Medium Value'
        ELSE 'Standard Value'
    END AS value_segment
FROM users u
LEFT JOIN trips t ON u.user_id = t.user_id
GROUP BY u.user_id, u.first_name, u.last_name;

-- IF function (MySQL specific)
SELECT 
    trip_name,
    total_budget,
    actual_cost,
    IF(actual_cost IS NULL, 'Not Available', 
       IF(actual_cost > total_budget, 'Over Budget', 'Within Budget')
    ) AS budget_status
FROM trips;

-- COALESCE - Handle NULL values
SELECT 
    u.first_name,
    u.last_name,
    COALESCE(u.phone, 'No Phone') AS phone_display,
    COALESCE(u.date_of_birth, '1900-01-01') AS birth_date_display
FROM users u;

-- NULLIF - Conditional NULL assignment
SELECT 
    booking_reference,
    booking_type,
    total_amount,
    NULLIF(total_amount, 0) AS non_zero_amount
FROM bookings;
```

---

## 4. Advanced Query Combinations

### 4.1 Complex Business Queries

Combining clauses, operators, and functions for comprehensive business analysis.

```sql
-- Customer lifetime value analysis
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
    u.registration_date,
    TIMESTAMPDIFF(MONTH, u.registration_date, NOW()) AS months_active,
    COUNT(t.trip_id) AS total_trips,
    COALESCE(SUM(t.total_budget), 0) AS total_planned_spending,
    COALESCE(SUM(t.actual_cost), 0) AS total_actual_spending,
    COALESCE(AVG(t.total_budget), 0) AS avg_trip_budget,
    CASE 
        WHEN COUNT(t.trip_id) = 0 THEN 'Inactive'
        WHEN COUNT(t.trip_id) >= 5 AND SUM(t.total_budget) >= 10000 THEN 'Premium'
        WHEN COUNT(t.trip_id) >= 3 THEN 'Regular'
        ELSE 'Occasional'
    END AS customer_segment,
    ROUND(
        COALESCE(SUM(t.total_budget), 0) / 
        GREATEST(TIMESTAMPDIFF(MONTH, u.registration_date, NOW()), 1), 2
    ) AS monthly_value
FROM users u
LEFT JOIN trips t ON u.user_id = t.user_id
WHERE u.is_active = TRUE
GROUP BY u.user_id, u.first_name, u.last_name, u.registration_date
HAVING COUNT(t.trip_id) > 0 OR u.registration_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
ORDER BY total_actual_spending DESC, total_trips DESC;

-- Seasonal travel pattern analysis
SELECT 
    YEAR(t.start_date) AS travel_year,
    CASE 
        WHEN MONTH(t.start_date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(t.start_date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(t.start_date) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(t.start_date) IN (9, 10, 11) THEN 'Fall'
    END AS season,
    COUNT(t.trip_id) AS trip_count,
    AVG(t.total_budget) AS avg_budget,
    SUM(t.total_budget) AS total_budget,
    AVG(DATEDIFF(t.end_date, t.start_date)) AS avg_duration,
    GROUP_CONCAT(DISTINCT d.country ORDER BY d.country) AS countries_visited
FROM trips t
JOIN destinations d ON t.destination_id = d.destination_id
WHERE t.start_date >= '2024-01-01'
  AND t.trip_status IN ('completed', 'ongoing')
GROUP BY YEAR(t.start_date), 
         CASE 
            WHEN MONTH(t.start_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(t.start_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(t.start_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(t.start_date) IN (9, 10, 11) THEN 'Fall'
         END
ORDER BY travel_year, season;
```

### 4.2 Performance Analytics Dashboard

```sql
-- Comprehensive performance metrics
SELECT 
    'Total Users' AS metric_name,
    COUNT(*) AS metric_value,
    DATE_FORMAT(NOW(), '%Y-%m-%d') AS report_date
FROM users
WHERE is_active = TRUE

UNION ALL

SELECT 
    'Active Trips' AS metric_name,
    COUNT(*) AS metric_value,
    DATE_FORMAT(NOW(), '%Y-%m-%d') AS report_date
FROM trips
WHERE trip_status IN ('planned', 'ongoing')

UNION ALL

SELECT 
    'Completed Trips' AS metric_name,
    COUNT(*) AS metric_value,
    DATE_FORMAT(NOW(), '%Y-%m-%d') AS report_date
FROM trips
WHERE trip_status = 'completed'

UNION ALL

SELECT 
    'Total Revenue' AS metric_name,
    ROUND(SUM(total_amount), 2) AS metric_value,
    DATE_FORMAT(NOW(), '%Y-%m-%d') AS report_date
FROM bookings
WHERE booking_status = 'confirmed'

UNION ALL

SELECT 
    'Average Rating' AS metric_name,
    ROUND(AVG(rating), 2) AS metric_value,
    DATE_FORMAT(NOW(), '%Y-%m-%d') AS report_date
FROM reviews
WHERE rating IS NOT NULL;
```

---

## 5. Best Practices and Optimization

### 5.1 Query Optimization Guidelines

**Index Usage**: Create indexes on frequently searched columns to improve performance.

```sql
-- Create indexes for optimized queries
CREATE INDEX idx_trips_start_date ON trips(start_date);
CREATE INDEX idx_bookings_type_status ON bookings(booking_type, booking_status);
CREATE INDEX idx_users_active_email ON users(