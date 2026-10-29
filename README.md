Project Overview

This project is an Online Bookstore database built in PostgreSQL. It models the core data of a bookstore using three related tables and answers twenty business questions about sales, revenue, stock and customer behaviour using SQL queries. The questions range from simple filtering to more advanced analysis using joins and aggregation.

Database Setup

The project begins by creating a database called OnlineBookstore using CREATE DATABASE, and then switching to it with the psql command \c. Before creating each table, the script uses DROP TABLE IF EXISTS so that it can be re-run without errors.

There are three tables. The Books table stores Book_ID (a SERIAL primary key), Title, Author, Genre, Published_Year, Price (NUMERIC) and Stock. The Customers table stores Customer_ID (a SERIAL primary key), Name, Email, Phone, City and Country. The Orders table stores Order_ID (a SERIAL primary key), Customer_ID and Book_ID (both foreign keys declared with REFERENCES), Order_Date, Quantity and Total_Amount.

Data was loaded into all three tables from CSV files using the COPY command with the CSV HEADER option. Simple SELECT * statements were also used to check the contents of each table.

Basic Queries (Questions 1 to 11)

Question 1 retrieves all books in the Fiction genre using SELECT with a WHERE clause. Question 2 finds books published after 1950 using the greater-than operator in WHERE. Question 3 lists customers from Canada using a text equality filter.

Question 4 shows orders placed in November 2023 using the BETWEEN operator on a date range. Question 5 calculates the total stock of all books using the SUM aggregate function with an alias.

Question 6 looks for the most expensive book using MAX on price, followed by a WHERE price >= 40 query with LIMIT to view the top-priced books. Question 7 finds orders with a quantity above one, and Question 8 finds orders where the total amount exceeds 20 dollars, both using WHERE conditions. Question 9 lists all genres using DISTINCT.

Question 10 looks for the book with the lowest stock using MAX, a stock >= 90 filter, and ORDER BY stock DESC with LIMIT. Question 11 calculates total revenue using SUM on Total_Amount.

Advanced Queries (Questions 12 to 20)

Question 12 finds the total number of books sold per genre by joining Books and Orders, summing the quantity and grouping by genre. Question 13 calculates the average price of Fantasy books using the AVG function with a WHERE filter.

Question 14 tries to list customers with at least two orders by joining Customers and Orders. Question 15 finds the most frequently ordered book using COUNT, GROUP BY on Book_ID, ORDER BY the count in descending order and LIMIT. Question 16 shows the top three most expensive Fantasy books using WHERE, ORDER BY price descending and LIMIT 3.

Question 17 calculates the total quantity sold per author using a join, SUM and GROUP BY on author. Question 18 lists the cities of customers who spent more than 30 dollars, using a join, DISTINCT and a WHERE condition on the order amount.

Question 19 finds the customer who spent the most by joining Orders and Customers, summing the total amount, grouping by customer ID and name, ordering by the total spent in descending order and limiting the result to one row. Question 20 calculates the stock remaining after fulfilling all orders using a LEFT JOIN between Books and Orders, SUM of quantity, COALESCE to convert NULL values to zero, and a subtraction from the original stock, grouped and ordered by Book_ID.

SQL Concepts Covered

The project covers DDL commands (CREATE and DROP), bulk loading with COPY, filtering with WHERE, BETWEEN and DISTINCT, aggregate functions (SUM, AVG, MAX and COUNT), sorting and limiting with ORDER BY and LIMIT, INNER JOIN and LEFT JOIN, GROUP BY, aliases, COALESCE, and primary and foreign key constraints.
