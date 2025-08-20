-- ============================================================================
-- PARKING APPLICATION - SQL JOINS COMPLETE STUDENT NOTES
-- ============================================================================

-- ============================================================================
-- TABLE CREATION
-- ============================================================================

-- Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    year_level VARCHAR(20),
    created_date DATE
);

-- Create Parking_Permits Table
CREATE TABLE parking_permits (
    permit_id INT PRIMARY KEY,
    student_id INT,
    vehicle_number VARCHAR(20) NOT NULL,
    permit_type VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    fee_amount DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ============================================================================
-- SAMPLE DATA INSERTION (20 Records Each)
-- ============================================================================

-- Insert 20 Students
INSERT INTO students (student_id, student_name, email, phone, year_level, created_date) VALUES
(1, 'John Smith', 'john.smith@university.edu', '123-456-7890', 'Freshman', '2024-01-15'),
(2, 'Emily Johnson', 'emily.johnson@university.edu', '123-456-7891', 'Sophomore', '2024-01-16'),
(3, 'Michael Brown', 'michael.brown@university.edu', '123-456-7892', 'Junior', '2024-01-17'),
(4, 'Sarah Davis', 'sarah.davis@university.edu', '123-456-7893', 'Senior', '2024-01-18'),
(5, 'David Wilson', 'david.wilson@university.edu', '123-456-7894', 'Graduate', '2024-01-19'),
(6, 'Lisa Anderson', 'lisa.anderson@university.edu', '123-456-7895', 'Freshman', '2024-01-20'),
(7, 'James Taylor', 'james.taylor@university.edu', '123-456-7896', 'Sophomore', '2024-01-21'),
(8, 'Maria Garcia', 'maria.garcia@university.edu', '123-456-7897', 'Junior', '2024-01-22'),
(9, 'Robert Martinez', 'robert.martinez@university.edu', '123-456-7898', 'Senior', '2024-01-23'),
(10, 'Jennifer Lee', 'jennifer.lee@university.edu', '123-456-7899', 'Graduate', '2024-01-24'),
(11, 'Christopher White', 'chris.white@university.edu', '123-456-7800', 'Freshman', '2024-01-25'),
(12, 'Amanda Harris', 'amanda.harris@university.edu', '123-456-7801', 'Sophomore', '2024-01-26'),
(13, 'Daniel Clark', 'daniel.clark@university.edu', '123-456-7802', 'Junior', '2024-01-27'),
(14, 'Jessica Lewis', 'jessica.lewis@university.edu', '123-456-7803', 'Senior', '2024-01-28'),
(15, 'Matthew Robinson', 'matt.robinson@university.edu', '123-456-7804', 'Graduate', '2024-01-29'),
(16, 'Ashley Walker', 'ashley.walker@university.edu', '123-456-7805', 'Freshman', '2024-01-30'),
(17, 'Joshua Hall', 'joshua.hall@university.edu', '123-456-7806', 'Sophomore', '2024-01-31'),
(18, 'Nicole Young', 'nicole.young@university.edu', '123-456-7807', 'Junior', '2024-02-01'),
(19, 'Andrew King', 'andrew.king@university.edu', '123-456-7808', 'Senior', '2024-02-02'),
(20, 'Samantha Wright', 'sam.wright@university.edu', '123-456-7809', 'Graduate', '2024-02-03');

-- Insert 20 Parking Permits (some students have multiple permits, some have none)
INSERT INTO parking_permits (permit_id, student_id, vehicle_number, permit_type, start_date, end_date, fee_amount, status) VALUES
(101, 1, 'ABC123', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(102, 2, 'XYZ789', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Active'),
(103, 3, 'DEF456', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(104, 4, 'GHI789', 'Economy', '2024-02-01', '2024-05-31', 75.00, 'Active'),
(105, 5, 'JKL012', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Active'),
(106, 6, 'MNO345', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Expired'),
(107, 7, 'PQR678', 'Economy', '2024-02-01', '2024-05-31', 75.00, 'Active'),
(108, 8, 'STU901', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Active'),
(109, 9, 'VWX234', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(110, 10, 'YZA567', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Suspended'),
(111, 1, 'ABC124', 'Economy', '2024-03-01', '2024-05-31', 75.00, 'Active'),
(112, 2, 'XYZ790', 'Standard', '2024-03-01', '2024-05-31', 150.00, 'Active'),
(113, 11, 'BCD890', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(114, 12, 'EFG123', 'Economy', '2024-02-01', '2024-05-31', 75.00, 'Active'),
(115, 13, 'HIJ456', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Active'),
(116, 1, 'KLM789', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(117, 2, 'NOP012', 'Economy', '2024-02-01', '2024-05-31', 75.00, 'Active'),
(118, 3, 'QRS345', 'Premium', '2024-02-01', '2024-05-31', 300.00, 'Expired'),
(119, 4, 'TUV678', 'Standard', '2024-02-01', '2024-05-31', 150.00, 'Active'),
(120,5, 'WXY901', 'Economy', '2024-02-01', '2024-05-31', 75.00, 'Active');

-- ============================================================================
-- STUDENT NOTES: UNDERSTANDING SQL JOINS
-- ============================================================================

/*
WHAT ARE SQL JOINS?
- Joins are used to combine rows from two or more tables based on a related column
- They help us retrieve data that is spread across multiple tables
- The relationship is typically established using foreign keys

TYPES OF JOINS:
1. INNER JOIN - Returns only matching records from both tables
2. LEFT JOIN (LEFT OUTER JOIN) - Returns all records from left table + matching from right
3. RIGHT JOIN (RIGHT OUTER JOIN) - Returns all records from right table + matching from left  
4. FULL OUTER JOIN - Returns all records from both tables
5. CROSS JOIN - Returns Cartesian product of both tables
6. SELF JOIN - Joins a table with itself
*/

-- ============================================================================
-- 1. INNER JOIN - Most Common Join Type
-- ============================================================================

-- STUDENT NOTE: INNER JOIN only returns rows where there's a match in BOTH tables
-- Use INNER JOIN when you only want students who HAVE parking permits

SELECT 
    s.student_id,
    s.student_name,
    s.email,
    s.year_level,
    p.permit_id,
    p.vehicle_number,
    p.permit_type,
    p.fee_amount,
    p.status
FROM students s
INNER JOIN parking_permits p ON s.student_id = p.student_id;

-- EXPLANATION: This query returns only students who have at least one parking permit
-- Students without permits will NOT appear in results

-- ============================================================================
-- 2. LEFT JOIN - Get All Students (With or Without Permits)
-- ============================================================================

-- STUDENT NOTE: LEFT JOIN returns ALL rows from the left table (students)
-- Even if there's no matching permit, the student will still appear with NULL values

SELECT 
    s.student_id,
    s.student_name,
    s.email,
    s.year_level,
    p.permit_id,
    p.vehicle_number,
    p.permit_type,
    p.fee_amount,
    p.status
FROM students s
LEFT JOIN parking_permits p ON s.student_id = p.student_id
ORDER BY s.student_id;

-- EXPLANATION: Shows ALL students. Students without permits show NULL for permit columns
-- This is useful for finding students who DON'T have parking permits

-- Find students WITHOUT parking permits
SELECT 
    s.student_id,
    s.student_name,
    s.email,
    s.year_level
FROM students s
LEFT JOIN parking_permits p ON s.student_id = p.student_id
WHERE p.student_id IS NULL;

-- ============================================================================
-- 3. RIGHT JOIN - Get All Permits (With or Without Valid Students)
-- ============================================================================

-- STUDENT NOTE: RIGHT JOIN returns ALL rows from the right table (parking_permits)
-- Less commonly used, but useful when you want all permits even if student doesn't exist

SELECT 
    s.student_id,
    s.student_name,
    s.email,
    p.permit_id,
    p.vehicle_number,
    p.permit_type,
    p.fee_amount,
    p.status
FROM students s
RIGHT JOIN parking_permits p ON s.student_id = p.student_id
ORDER BY p.permit_id;

-- EXPLANATION: Shows ALL permits. Permits with invalid student_ids show NULL for student columns
-- This helps identify orphaned permits (permits without valid students)

-- Find permits with invalid student references
SELECT 
    p.permit_id,
    p.student_id,
    p.vehicle_number,
    p.permit_type
FROM students s
RIGHT JOIN parking_permits p ON s.student_id = p.student_id
WHERE s.student_id IS NULL;

-- ============================================================================
-- 4. FULL OUTER JOIN - Get Everything
-- ============================================================================

-- STUDENT NOTE: FULL OUTER JOIN returns ALL rows from BOTH tables
-- Shows all students (with/without permits) AND all permits (with/without valid students)

SELECT 
    s.student_id,
    s.student_name,
    s.email,
    p.permit_id,
    p.vehicle_number,
    p.permit_type,
    p.fee_amount,
    p.status
FROM students s
FULL OUTER JOIN parking_permits p ON s.student_id = p.student_id
ORDER BY s.student_id, p.permit_id;

-- EXPLANATION: Complete picture - every student and every permit
-- Useful for data auditing and finding mismatched records

-- ============================================================================
-- 5. CROSS JOIN - Cartesian Product (Use with Caution!)
-- ============================================================================

-- STUDENT NOTE: CROSS JOIN creates every possible combination
-- Each student paired with each permit type (usually not what you want!)

-- Example: Show all possible student-permit type combinations
SELECT 
    s.student_name,
    permit_types.type_name,
    permit_types.fee
FROM students s
CROSS JOIN (
    SELECT 'Standard' as type_name, 150.00 as fee
    UNION ALL SELECT 'Premium', 300.00
    UNION ALL SELECT 'Economy', 75.00
) permit_types
WHERE s.student_id <= 3  -- Limiting to first 3 students for demo
ORDER BY s.student_name, permit_types.type_name;

-- ============================================================================
-- 6. SELF JOIN - Join Table with Itself
-- ============================================================================

-- STUDENT NOTE: SELF JOIN compares rows within the same table
-- Example: Find students who have the same phone area code

SELECT 
    s1.student_name as student1,
    s2.student_name as student2,
    s1.phone as phone1,
    s2.phone as phone2
FROM students s1
JOIN students s2 ON SUBSTRING(s1.phone, 1, 3) = SUBSTRING(s2.phone, 1, 3)
    AND s1.student_id < s2.student_id  -- Avoid duplicate pairs
ORDER BY s1.phone;

-- ============================================================================
-- ADVANCED JOIN EXAMPLES FOR PARKING APPLICATION
-- ============================================================================

-- Example 1: Students with multiple permits
SELECT 
    s.student_name,
    s.email,
    COUNT(p.permit_id) as permit_count,
    SUM(p.fee_amount) as total_fees
FROM students s
INNER JOIN parking_permits p ON s.student_id = p.student_id
GROUP BY s.student_id, s.student_name, s.email
HAVING COUNT(p.permit_id) > 1
ORDER BY permit_count DESC;

-- Example 2: Revenue by permit type and student year
SELECT 
    s.year_level,
    p.permit_type,
    COUNT(p.permit_id) as permit_count,
    SUM(p.fee_amount) as total_revenue,
    AVG(p.fee_amount) as avg_fee
FROM students s
INNER JOIN parking_permits p ON s.student_id = p.student_id
WHERE p.status = 'Active'
GROUP BY s.year_level, p.permit_type
ORDER BY s.year_level, total_revenue DESC;

-- Example 3: Students by registration month and permit status
SELECT 
    EXTRACT(MONTH FROM s.created_date) as registration_month,
    p.status,
    COUNT(*) as count
FROM students s
LEFT JOIN parking_permits p ON s.student_id = p.student_id
GROUP BY EXTRACT(MONTH FROM s.created_date), p.status
ORDER BY registration_month, p.status;

-- ============================================================================
-- PERFORMANCE TIPS FOR JOINS
-- ============================================================================

-- 1. Always use indexes on join columns
CREATE INDEX idx_permits_student_id ON parking_permits(student_id);
CREATE INDEX idx_students_id ON students(student_id);

-- 2. Filter early with WHERE clauses
SELECT s.student_name, p.vehicle_number
FROM students s
INNER JOIN parking_permits p ON s.student_id = p.student_id
WHERE s.year_level = 'Senior' 
  AND p.status = 'Active'
  AND p.permit_type = 'Premium';

-- 3. Use specific column names instead of SELECT *
-- 4. Consider the size of tables when choosing join types

-- ============================================================================
-- COMMON JOIN MISTAKES TO AVOID
-- ============================================================================

/*
1. Forgetting ON clause - Results in Cartesian product
2. Using wrong join type - INNER when you need LEFT JOIN
3. Not handling NULL values properly
4. Joining on non-indexed columns (performance issue)
5. Using SELECT * in large tables
6. Not considering duplicate rows in results
*/

-- ============================================================================
-- PRACTICE QUERIES FOR STUDENTS
-- ============================================================================

-- Query 1: Find all active permits for Graduate students
SELECT 
    s.student_name,
    s.email,
    p.vehicle_number,
    p.permit_type,
    p.fee_amount
FROM students s
INNER JOIN parking_permits p ON s.student_id = p.student_id
WHERE s.year_level = 'Graduate' 
  AND p.status = 'Active';

-- Query 2: Calculate total parking revenue
SELECT 
    SUM(fee_amount) as total_revenue,
    COUNT(*) as total_permits,
    AVG(fee_amount) as average_fee
FROM parking_permits
WHERE status = 'Active';

-- Query 3: Find students who registered in January but don't have permits
SELECT 
    s.student_name,
    s.email,
    s.created_date
FROM students s
LEFT JOIN parking_permits p ON s.student_id = p.student_id
WHERE EXTRACT(MONTH FROM s.created_date) = 1
  AND p.student_id IS NULL;

-- ============================================================================
-- SUMMARY FOR STUDENTS
-- ============================================================================

/*
KEY TAKEAWAYS:
1. INNER JOIN: Use when you need matching records from both tables
2. LEFT JOIN: Use when you need all records from the left table
3. RIGHT JOIN: Less common, but useful for specific scenarios  
4. FULL OUTER JOIN: Use when you need everything from both tables
5. Always consider what data you actually need
6. Test your joins with small datasets first
7. Use proper indexing for better performance
8. Handle NULL values appropriately in your application logic

REMEMBER: The choice of join type dramatically affects your results!
*/