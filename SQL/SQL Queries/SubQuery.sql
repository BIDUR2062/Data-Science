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

--Find Customer Details whose orders has been rejected
SELECT concat(sc.first_name, ' ', sc.last_name),
       sc.email,
       sc.street
FROM   sales.customers AS sc
       INNER JOIN
       sales.orders AS so
       ON sc.customer_id = so.customer_id
WHERE  order_status = 3;

SELECT concat(first_name, ' ', last_name) AS customer_name,
       email,
       street
FROM   sales.customers
WHERE  customer_id IN (SELECT customer_id
                       FROM   sales.orders
                       WHERE  order_status = 3);

--Find customer details whose order status is completed and who has spent more than 8000 in total.
SELECT concat(sc.first_name, ' ', sc.last_name),
       sc.email,
       sc.street,
       ((soi.list_price * soi.quantity) * (1 - soi.discount))
FROM   sales.customers AS sc
       INNER JOIN
       sales.orders AS so
       ON sc.customer_id = so.customer_id
       INNER JOIN
       sales.order_items AS soi
       ON soi.order_id = so.order_id
WHERE  order_status = 4
       AND ((soi.list_price * soi.quantity) * (1 - soi.discount)) > 8000;

--Sub Query Method
SELECT concat(sc.first_name, ' ', sc.last_name) AS Customer_name,
       sc.email,
       sc.street,
       sc.city,
       sc.state,
       sc.zip_code
FROM   sales.customers AS sc
WHERE  customer_id IN (SELECT so.customer_id
                       FROM   sales.order_items AS soi
                              INNER JOIN
                              sales.orders AS so
                              ON soi.order_id = so.order_id
                       WHERE  ((soi.list_price * soi.quantity) * (1 - soi.discount)) > 8000
                              AND order_status = 4);

SELECT concat(sc.first_name, ' ', sc.last_name) AS Customer_name,
       sc.email,
       sc.street,
       sc.city,
       sc.state,
       sc.zip_code
FROM   sales.customers AS sc
WHERE  customer_id IN (SELECT   TOP 5 so.customer_id
                       FROM     sales.order_items AS soi
                                INNER JOIN
                                sales.orders AS so
                                ON soi.order_id = so.order_id
                       WHERE    ((soi.list_price * soi.quantity) * (1 - soi.discount)) > 8000
                                AND order_status = 4
                       ORDER BY (soi.list_price * soi.quantity) * (1 - soi.discount) DESC);

/*
ANY-> OR
ALL ->  AND
*/
SELECT   *
FROM     production.products
ORDER BY list_price ASC;

--Find any product whose list_price is less than 209.99/ 250.99
SELECT *
FROM   production.products
WHERE  list_price < ANY (SELECT list_price
                         FROM   production.products
                         WHERE  list_price IN (209.99, 250.99));

--Find any product whose list_price is less than 209.99/ 250.99
SELECT *
FROM   production.products
WHERE  list_price < ALL (SELECT list_price
                         FROM   production.products
                         WHERE  list_price IN (209.99, 250.99));

--Find Customer details who brought the product whose list_price is less than 209.99 / 250.99
SELECT first_name,
       last_name,
       email,
       zip_code
FROM   sales.customers
WHERE  customer_id IN (SELECT customer_id
                       FROM   sales.orders
                       WHERE  order_id IN (SELECT order_id
                                           FROM   sales.order_items
                                           WHERE  product_id IN (SELECT product_id
                                                                 FROM   production.products
                                                                 WHERE  list_price < ALL (SELECT list_price
                                                                                          FROM   production.products
                                                                                          WHERE  list_price IN (209.99, 250.99)))));

--Find staff details who have managed orders which was rejected and sold products whose price is more than 1000
--whose model year is 2017
SELECT first_name,
       last_name,
       email,
       phone
FROM   sales.staffs
WHERE  staff_id IN (SELECT staff_id
                    FROM   sales.orders
                    WHERE  order_status = 3
                           AND order_id IN (SELECT order_id
                                            FROM   sales.order_items
                                            WHERE  list_price > 1000
                                                   AND product_id IN (SELECT product_id
                                                                      FROM   production.products
                                                                      WHERE  model_year = 2017)));
