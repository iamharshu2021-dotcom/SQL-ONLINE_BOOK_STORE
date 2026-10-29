-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:\Users\lenovo\OneDrive\Desktop\SQL PROJECT\30 Day - SQL Practice Files\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Orders.csv' 
CSV HEADER;




-- 1) Retrieve all books in the "Fiction" genre:
select * from books 
where Genre = 'Fiction';


-- 2) Find books published after the year 1950:
select * from books 
where published_year > 1950;


-- 3) List all customers from the Canada:
select * from customers
where country= 'Canada';

-- 4) Show orders placed in November 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock from books;

-- 6) Find the details of the most expensive book:
select max(price) as expensive_book from books;

select * from books 
where price >=40 limit 5;


-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where total_amount >20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select max(stock) from books;
select * from books
where stock>=90 limit 5;


select * from books order by stock desc limit 5;


-- 11) Calculate the total revenue generated from all orders:

select sum(total_amount) as revenue
from orders ;
-- Advance Questions : 

-- 12) Retrieve the total number of books sold for each genre:
select * from orders;
select * from books;

select  b.genre, sum(o.quantity) as total_book_sold
from books as b
join orders as o
on b.book_id = o.book_id 
group by b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price
from books
where genre= 'Fantasy';



-- 14) List customers who have placed at least 2 orders:
select * from customers;
select * from orders;

select c.name , o.quantity 
from customers as c 
join orders as o
on c.customer_id = o.customer_id
where o.quantity <=2;

-- 15) Find the most frequently ordered book:
select book_id  ,  count(order_id) as order_count
from orders
group by  book_id
order by order_count desc limit 5;


-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre = 'Fantasy' 
order by price desc limit 3;


-- 17) Retrieve the total quantity of books sold by each author:

select b.author , sum(o.quantity) as total_book_sold
from orders as o
join books as b
on o.book_id = b.book_id
group by b.author;

-- 18) List the cities where customers who spent over $30 are located:
select * from customers;
select * from orders;

select distinct c.city , o.total_amount
from customers as c
join orders as o
on c.customer_id = o.customer_id
where o.total_amount > 30


-- 19) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


--20) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;
