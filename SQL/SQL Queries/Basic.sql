--Selection
--* (Means All)
USE BikeStores;

SELECT TOP 5 customer_id,
             first_name,
             last_name,
             phone,
             email,
             street,
             city,
             state,
             zip_code
FROM   sales.customers;

--select * from sales.customer;
/*
SQL Execution Flow
--------------------
1.From
2.Join
3.where
4.Group_by
5.Having
6.Select
7.Order by
8.Limit (MySQL / PgSQL) /Top (SQL Server) / Offset Fetch (SQL Server / Oracle)
----------------------------
*/
--offset->number of rows to skip
--fecth->extracr number of rows after skipping
USE BikeStores;

SELECT   customer_id,
         first_name,
         last_name,
         phone,
         email,
         street,
         city,
         state,
         zip_code
FROM     sales.customers
ORDER BY city
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--AND, OR , Between, IN , Like
--Find order details of 2016 january
SELECT *
FROM   sales.orders
WHERE  order_date BETWEEN '2016-01-01' AND '2016-01-31';

--Find Product details whose list price is in range of 200 to 800
SELECT *
FROM   production.products
WHERE  list_price BETWEEN 200 AND 800; -- Slower

SELECT *
FROM   production.products
WHERE  list_price > 200
       AND list_price < 800; --faster

--Find products details of brand 2 and 6.
SELECT *
FROM   production.products
WHERE  brand_id = 6
       OR brand_id = 2; --More Efficient 

SELECT *
FROM   production.products
WHERE  brand_id IN (2, 6); --Less Efficient

--Like (Used For Searching)
--wildcards(%, _)
SELECT *
FROM   production.products;

--Find product details whose name starts from 'T'
SELECT *
FROM   production.products
WHERE  product_name LIKE 'T%';

SELECT *
FROM   production.products
WHERE  product_name LIKE '%2018';

--Find Product details whose name starts with T and ends with 2018.
SELECT *
FROM   production.products
WHERE  product_name LIKE 'T%'
       AND product_name LIKE '%2018';

--Find Product details whose product name has l in fourth place.
SELECT *
FROM   production.products
WHERE  product_name LIKE '___l%';

--Concat Function and Concatenation Operator (+) (Oracle(||))
SELECT CONCAT(first_name, ' ', last_name) AS fullName
FROM   sales.customers; --This function is called as calculated column and it doesn't come with column name so we have to provide alias

SELECT   (first_name + ' ' + last_name) AS full_name
FROM     sales.customers
ORDER BY full_name DESC;

--Find 'Debra Burks' customer details
SELECT *
FROM   sales.customers
WHERE  CONCAT(first_name, ' ', last_name) = 'Debra Burks';

--Substring 
--Substring(Column_name,start_length,number_of_length)
SELECT first_name,
       SUBSTRING(first_name, 2, 3) AS Midletter
FROM   sales.customers;

--left and right(left is used to extract string from left side and right is used to extract string from right side)
SELECT first_name,
       LEFT(first_name, 3) AS first_3
FROM   sales.customers;

SELECT first_name,
       RIGHT(first_name, 3) AS Last_3
FROM   sales.customers;

--find this pattern customer_id-first-name(3,2)-last_name(last 4)- email(5,6) - street(frist 2) - city(2,3) - state - zip_code(2,3)
SELECT CONCAT(customer_id, '-', SUBSTRING(first_name, 3, 2), '-', RIGHT(last_name, 4), '-', SUBSTRING(email, 5, 6), '-', LEFT(street, 2), SUBSTRING(city, 2, 3), '-', state, '-', SUBSTRING(zip_code, 2, 3)) AS cust_id,
       first_name,
       last_name,
       email,
       street,
       city,
       state,
       zip_code
FROM   sales.customers;

--Difference between CONCAT and + Operator Query
SELECT CONCAT(first_name, phone) AS data,
       (first_name + phone) AS data1
FROM   sales.customers;

--Time Series Analysis / Cohort Analyisis
SELECT order_date,
       year(order_date) AS O_Year,
       month(order_date) AS O_Month,
       day(order_date) AS O_day,
       datename(month, order_date) AS Order_Month,
       datename(weekday, order_date) AS Order_day,
       datepart(weekday, order_date) AS dp_day,
       datepart(week, order_date) AS dp_week,
       datepart(quarter, order_date) AS dp_qt,
       format(order_date, 'MM') AS order_month, --MMMM->Full_name MMM-> Half_name(jan) MM and M
       format(order_date, 'dddd') AS order_day
FROM   sales.orders;

--Date Analysis
SELECT order_date,
       shipped_date,
       datediff(day, order_date, isnull(shipped_date, getdate())) AS Day_Diff,
       datediff(month, order_date, shipped_date) AS Month_diff,
       dateadd(day, 3, order_date) AS add_day
FROM   sales.orders;

--For Temporary Filling 
--ISNull
--Coalesce
SELECT shipped_date,
       IsNull(shipped_date, getdate()),
       COALESCE (shipped_date, getdate())
FROM   sales.orders;

-------------------------------
--Analysis
--SQL CaseCASE means->"If this condition is true, give this result; otherwise check the next condition."
/*
  select 
     case 
        when condition then value
        when condition then value
    end
from table name; 
*/
-- 0-1000 -> Low price Product
--1001-2500 -> Average price product 
-->2500 ->High Price product
SELECT   product_id,
         product_name,
         model_year,
         list_price,
         CASE WHEN list_price <= 1000 THEN 'Low price Product' WHEN list_price BETWEEN 1000 AND 2500 THEN 'Average Price Product' WHEN list_price > 2500 THEN 'Average Price Product' END AS price_label
FROM     production.products
ORDER BY list_price ASC;

--1->Pending , 2-> Processing, 3->Rejected , 4-> Completed 
/*
Find order details and show order status label. After labeling filter data showing orders
which is currently in processing and also show how many exact days required to deliver that order
*/
SELECT order_id,
       order_date,
       order_status,
       required_date,
       shipped_date,
       datediff(day, order_date, required_date) AS day_as_deliver,
       CASE WHEN order_status = 1 THEN 'Pending' WHEN order_status = 2 THEN 'Processing' WHEN order_status = 3 THEN 'Rejected' WHEN order_status = 4 THEN 'Completed' END AS Order_status_name
FROM   sales.orders
WHERE  order_status = 4;

/*
-Find order item details and its total price. For each item purchased by customer 13% of vat must be added in total 
price. After calculating total price show price label as:
i. 0-3000 ->Low Price Purchase 
ii.>3000 to 8000 ->Average Price Purchase
iii. >8000  ->High Price purchase
select * from sales.order_items;
*/
SELECT order_id,
       product_id,
       quantity,
       list_price,
       discount,
       (quantity * list_price) AS total_price,
       (quantity * list_price - (discount * quantity * list_price)) AS price_after_discount,
       ((quantity * list_price - (discount * quantity * list_price)) + (0.13 * (quantity * list_price - (discount * quantity * list_price)))) AS price_with_VAT,
       CASE WHEN ((quantity * list_price - (discount * quantity * list_price)) + (0.13 * (quantity * list_price - (discount * quantity * list_price)))) < 3000 THEN 'Low Price Purchase' WHEN ((quantity * list_price - (discount * quantity * list_price)) + (0.13 * (quantity * list_price - (discount * quantity * list_price)))) BETWEEN 3000 AND 8000 THEN ' High Price Purchase' WHEN ((quantity * list_price - (discount * quantity * list_price)) + (0.13 * (quantity * list_price - (discount * quantity * list_price)))) > 8000 THEN 'High Price Purchase' END AS order_label
FROM   sales.order_items;

--Another Method
SELECT order_id,
       product_id,
       quantity,
       list_price,
       discount,
       (((list_price * quantity) * (1 - discount)) * 1.13) AS total_price,
       CASE WHEN (((list_price * quantity) * (1 - discount)) * 1.13) < 3000 THEN 'Low Price Purchase' WHEN (((list_price * quantity) * (1 - discount)) * 1.13) BETWEEN 3000 AND 8000 THEN ' High Price Purchase' WHEN (((list_price * quantity) * (1 - discount)) * 1.13) > 8000 THEN 'High Price Purchase' END AS order_label
FROM   sales.order_items;

