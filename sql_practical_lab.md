# SQL Practical Lab: Financial Domain

## Lab Setup Instructions

### Step 1: Create the Database Schema

First, create the database and tables for our financial system:

```sql
-- Create Database
CREATE DATABASE FinancialSystem;
USE FinancialSystem;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE
);

-- Create Accounts Table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(15,2),
    opening_date DATE,
    branch_id INT,
    status VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    transaction_date DATETIME,
    description VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Create Branches Table
CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    city VARCHAR(50),
    manager_name VARCHAR(50),
    contact_number VARCHAR(15)
);

-- Create Loans Table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(30),
    loan_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    loan_date DATE,
    repayment_months INT,
    status VARCHAR(15),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

### Step 2: Insert Sample Data

```sql
-- Insert Customers Data
INSERT INTO customers VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '555-0101', 'New York', '2023-01-15'),
(2, 'Jane', 'Doe', 'jane.doe@email.com', '555-0102', 'Los Angeles', '2023-02-20'),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', '555-0103', 'Chicago', '2023-03-10'),
(4, 'Alice', 'Brown', 'alice.brown@email.com', '555-0104', 'Houston', '2023-04-05'),
(5, 'Charlie', 'Davis', 'charlie.davis@email.com', '555-0105', 'Phoenix', '2023-05-12'),
(6, 'Diana', 'Wilson', 'diana.wilson@email.com', '555-0106', 'Philadelphia', '2023-06-18'),
(7, 'Eva', 'Miller', 'eva.miller@email.com', '555-0107', 'San Antonio', '2023-07-22'),
(8, 'Frank', 'Garcia', 'frank.garcia@email.com', '555-0108', 'San Diego', '2023-08-30');

-- Insert Branches Data
INSERT INTO branches VALUES
(101, 'Downtown Branch', 'New York', 'Michael Johnson', '555-1001'),
(102, 'Westside Branch', 'Los Angeles', 'Sarah Williams', '555-1002'),
(103, 'Central Branch', 'Chicago', 'David Brown', '555-1003'),
(104, 'Main Branch', 'Houston', 'Lisa Davis', '555-1004'),
(105, 'North Branch', 'Phoenix', 'Robert Wilson', '555-1005');

-- Insert Accounts Data
INSERT INTO accounts VALUES
(1001, 1, 'Savings', 2500.00, '2023-01-15', 101, 'Active'),
(1002, 1, 'Checking', 1200.00, '2023-01-15', 101, 'Active'),
(1003, 2, 'Savings', 5000.00, '2023-02-20', 102, 'Active'),
(1004, 2, 'Checking', 800.00, '2023-02-20', 102, 'Active'),
(1005, 3, 'Savings', 3200.00, '2023-03-10', 103, 'Active'),
(1006, 4, 'Checking', 950.00, '2023-04-05', 104, 'Active'),
(1007, 4, 'Savings', 7500.00, '2023-04-05', 104, 'Active'),
(1008, 5, 'Checking', 1800.00, '2023-05-12', 105, 'Active'),
(1009, 6, 'Savings', 4200.00, '2023-06-18', 101, 'Active'),
(1010, 7, 'Checking', 600.00, '2023-07-22', 102, 'Frozen'),
(1011, 8, 'Savings', 8900.00, '2023-08-30', 103, 'Active');

-- Insert Transactions Data
INSERT INTO transactions VALUES
(2001, 1001, 'Deposit', 500.00, '2024-01-15 10:30:00', 'Salary deposit'),
(2002, 1001, 'Withdrawal', -200.00, '2024-01-16 14:45:00', 'ATM withdrawal'),
(2003, 1002, 'Deposit', 1000.00, '2024-01-17 09:15:00', 'Check deposit'),
(2004, 1003, 'Withdrawal', -300.00, '2024-01-18 16:20:00', 'Online transfer'),
(2005, 1003, 'Deposit', 750.00, '2024-01-19 11:10:00', 'Investment return'),
(2006, 1004, 'Withdrawal', -150.00, '2024-01-20 13:25:00', 'Bill payment'),
(2007, 1005, 'Deposit', 2000.00, '2024-01-21 08:40:00', 'Bonus payment'),
(2008, 1006, 'Withdrawal', -75.00, '2024-01-22 15:55:00', 'Grocery shopping'),
(2009, 1007, 'Deposit', 1500.00, '2024-01-23 12:30:00', 'Freelance income'),
(2010, 1008, 'Withdrawal', -400.00, '2024-01-24 17:15:00', 'Rent payment'),
(2011, 1009, 'Deposit', 800.00, '2024-01-25 10:20:00', 'Gift money'),
(2012, 1011, 'Withdrawal', -1200.00, '2024-01-26 14:10:00', 'Investment purchase');

-- Insert Loans Data
INSERT INTO loans VALUES
(3001, 1, 'Personal', 15000.00, 8.5, '2023-06-01', 36, 'Active'),
(3002, 2, 'Home', 250000.00, 4.2, '2023-07-15', 360, 'Active'),
(3003, 3, 'Car', 35000.00, 6.8, '2023-08-20', 60, 'Active'),
(3004, 4, 'Personal', 10000.00, 9.2, '2023-09-10', 24, 'Active'),
(3005, 5, 'Home', 180000.00, 4.5, '2023-10-05', 240, 'Active'),
(3006, 6, 'Car', 28000.00, 7.1, '2023-11-12', 48, 'Closed'),
(3007, 7, 'Personal', 5000.00, 10.5, '2023-12-18', 18, 'Active');
```

## Practice Operations

### Basic Operations Practice

#### 1. Simple SELECT Operations
```sql
-- View all customers
SELECT * FROM customers;

-- View all active accounts
SELECT * FROM accounts WHERE status = 'Active';

-- View transactions for account 1001
SELECT * FROM transactions WHERE account_id = 1001;
```

#### 2. Using WHERE with Different Operators
```sql
-- Find accounts with balance greater than $3000
SELECT * FROM accounts WHERE balance > 3000;

-- Find customers from specific cities
SELECT * FROM customers WHERE city IN ('New York', 'Los Angeles');

-- Find transactions between specific dates
SELECT * FROM transactions 
WHERE transaction_date BETWEEN '2024-01-15' AND '2024-01-20';
```

#### 3. Using ORDER BY and LIMIT
```sql
-- Top 5 accounts by balance
SELECT * FROM accounts ORDER BY balance DESC LIMIT 5;

-- Recent transactions
SELECT * FROM transactions ORDER BY transaction_date DESC LIMIT 10;
```

#### 4. Aggregate Functions Practice
```sql
-- Total balance across all accounts
SELECT SUM(balance) as total_balance FROM accounts;

-- Average loan amount
SELECT AVG(loan_amount) as avg_loan FROM loans;

-- Count of customers by city
SELECT city, COUNT(*) as customer_count FROM customers GROUP BY city;
```

#### 5. JOIN Operations Practice
```sql
-- Customer details with their accounts
SELECT c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

-- Account transactions with customer information
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id;
```

---

## Assignment Questions

### Assignment 1: Basic Queries (25 points)

**Question 1 (5 points):** Write a query to display all customers who registered after March 1, 2023, ordered by registration date.

**Question 2 (5 points):** Find all savings accounts with a balance between $2000 and $5000.

**Question 3 (5 points):** Display the first name, last name, and email of customers from 'New York' and 'Chicago'.

**Question 4 (5 points):** List all transactions of type 'Deposit' with amount greater than $500, ordered by amount in descending order.

**Question 5 (5 points):** Show all active loans with interest rate less than 8%.

### Assignment 2: Aggregate Functions and Grouping (25 points)

**Question 6 (5 points):** Calculate the total balance for each account type (Savings, Checking).

**Question 7 (5 points):** Find the average transaction amount for each account, showing only accounts with more than 2 transactions.

**Question 8 (5 points):** Count the number of customers in each city and display only cities with more than 1 customer.

**Question 9 (5 points):** Calculate the total loan amount for each loan type and the average interest rate.

**Question 10 (5 points):** Find the branch with the highest total account balance.

### Assignment 3: Advanced Queries with JOINs (25 points)

**Question 11 (5 points):** Display customer name, account type, and current balance for all customers who have both Savings and Checking accounts.

**Question 12 (5 points):** Show the total transaction amount (deposits minus withdrawals) for each customer.

**Question 13 (5 points):** List customers who have taken loans, showing their name, loan type, and loan amount, ordered by loan amount.

**Question 14 (5 points):** Find the branch name and manager name for branches that have accounts with total balance greater than $10,000.

**Question 15 (5 points):** Display customer information along with their account details and the branch information for accounts opened in 2023.

### Assignment 4: Complex Queries and Functions (25 points)

**Question 16 (5 points):** Create a query to show customers who have made more than 2 transactions, displaying their name and transaction count.

**Question 17 (5 points):** Find accounts that have had both deposit and withdrawal transactions, showing the account details and net transaction amount.

**Question 18 (5 points):** Calculate the monthly interest that would be earned on each savings account (assume 3% annual interest rate).

**Question 19 (5 points):** Find customers whose total account balance (sum of all their accounts) is greater than $5000.

**Question 20 (5 points):** Create a summary report showing: customer name, total number of accounts, total balance across all accounts, and whether they have any active loans (Yes/No).

---

## Bonus Questions (10 points each)

**Bonus 1:** Create a query to identify potential VIP customers (customers with total balance > $10,000 OR loan amount > $100,000).

**Bonus 2:** Write a query to show the transaction history for the last 30 days, including running balance for each account.

**Bonus 3:** Create a query to find customers who have accounts in multiple branches.

## Submission Guidelines

1. **Format:** Submit your SQL queries in a text file or SQL script file
2. **Naming:** Name your file as "StudentName_SQL_Assignment.sql"
3. **Comments:** Include comments explaining your approach for complex queries
4. **Testing:** Test all queries with the provided sample data
5. **Results:** Include the expected output or result set for each query

## Grading Criteria

- **Correctness (60%):** Query produces the expected results
- **Efficiency (20%):** Query is optimized and uses appropriate indexes/joins
- **Code Quality (15%):** Clean, readable code with proper formatting
- **Comments (5%):** Clear explanations for complex queries

## Additional Practice Tips

1. Start with simple queries and gradually increase complexity
2. Use EXPLAIN to understand query execution plans
3. Practice different JOIN types (INNER, LEFT, RIGHT, FULL OUTER)
4. Experiment with subqueries and CTEs for complex scenarios
5. Always validate your results with the sample data provided

**Good luck with your SQL practical lab!**