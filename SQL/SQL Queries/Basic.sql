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
SELECT CONCAT(customer_id, '-', SUBSTRING(first_name, 3, 2), '-', RIGHT(last_name, 4), '-', SUBSTRING(email, 5, 6), '-', LEFT(street, 2), SUBSTRING(city, 2, 3), '-', state, '-', SUBSTRING(zip_code, 2, 3)) AS pin
FROM   sales.customers;

