drop database  OnlineBookstore;

CREATE DATABASE OnlineBookstore

use OnlineBookstore;

CREATE TABLE Books (
    Book_ID serial PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

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

-- 1) Retrieve all books in the "Fiction" genre:
select * from Books
where Genre= "Fiction";

-- 2) Find books published after the year 1950:
select * from Books
where Published_year>1950;

-- 3) List all customers from the Canada:
select * from Customers
where Country="Canada";

-- 4) Show orders placed in November 2023:
select * from Orders
where order_date between '2023-09-1' and '2023-09-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_stock
from Books;


-- 6) Find the details of the most expensive book:
select * from Books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity>1;


-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;

-- 10) Find the book with lowest stock
select * from books
order by stock asc
limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as Total_revenue
from orders;

-- 12) Retrieve the total number of books sold for each genre:
select b.Genre,sum(o.quantity)
from orders o
join books b on o.book_id = b.book_id
group by b.Genre;


-- 13) Find the average price of books in the "Fantasy" genre:
select avg(price) as Average_Price
from Books
where Genre = 'Fantasy';

-- 14) List customers who have placed at least 2 orders:
select c.name,o.customer_id,count(o.order_id ) as Order_count
from orders o 
join customers c on o.customer_id = c.customer_id
group by c.name,o.customer_id
having count(order_id)>=2;


-- 15) Find the most frequently ordered book:
select b.title,o.book_id, count(o.order_id) as Order_count
from orders o
join books b on o.book_id = b.book_id
group by o.book_id,b.title
order by order_count desc limit 1;


-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 17) Retrieve the total quantity of books sold by each author:
select b.author , sum(o.quantity) as Total_books_sold
from orders o
join books b on o.book_id = b.book_id
group by b.author;

-- 18) List the cities where customers who spent over $30 are located:
select Distinct(c.city),o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id
where o.total_amount >30;

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

-- 19) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


