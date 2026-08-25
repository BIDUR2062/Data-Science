--Selection
--* (Means All)
use BikeStores
select top 5 customer_id,first_name,last_name,phone,email,street,city,state,zip_code from sales.customers;
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

use BikeStores
select  customer_id,first_name,last_name,phone,email,street,city,state,zip_code from sales.customers
order by city
offset 0 rows fetch next 5 rows only;

--AND, OR , Between, IN , Like
--Find order details of 2016 january
select * from sales.orders where order_date between'2016-01-01' and '2016-01-31';

--Find Product details whose list price is in range of 200 to 800
select * from production.products where list_price between 200 and 800; -- Slower
select * from production.products where list_price>200 and list_price < 800; --faster

--Find products details of brand 2 and 6.
select * from production.products where brand_id=6 OR brand_id=2;--More Efficient 

select * from production.products where brand_id in (2,6);--Less Efficient

--Like (Used For Searching)
--wildcards(%, _)

select * from production.products;

--Find product details whose name starts from 'T'
select * from production.products where product_name like 'T%';

select * from production.products where product_name like '%2018';

--Find Product details whose name starts with T and ends with 2018.
select * from production.products where product_name like 'T%' and product_name like '%2018';

--Find Product details whose product name has l in fourth place.
select * from production.products where product_name like '___l%';

--Concat Function and Concatenation Operator (+) (Oracle(||))
select 
CONCAT(first_name,' ',last_name) as fullName
from sales.customers;--This function is called as calculated column and it doesn't come with column name so we have to provide alias

select 
(first_name +' '+last_name) as full_name
from sales.customers
order by full_name desc;