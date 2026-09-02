/*
SubQuery
--------
1.Single Row SubQuery
	--If Inner Query provides with single row and single colum data 
	-Comparision ->=,!=,<,>,<=,>=

2.Multi Row SubQuery
	- If inner Query provides with multiple row and single column data
	-> In,(Any ,ALL ->Comparision Operator)
select * from table_name where col_name <(select col_name from table_name)
*/
--Find all product details whose price is less than its average list price.
SELECT avg(list_price) AS avg_price
FROM   production.products;

SELECT *
FROM   production.products
WHERE  list_price < 1520.5914401;

SELECT *
FROM   production.products
WHERE  list_price < (SELECT avg(list_price)
                     FROM   production.products);

--Find second highest list price from product details.
SELECT *
FROM   production.products
WHERE  list_price = (SELECT max(list_price) AS second_highest_list_price
                     FROM   production.products
                     WHERE  list_price < (SELECT max(list_price)
                                          FROM   production.products));

