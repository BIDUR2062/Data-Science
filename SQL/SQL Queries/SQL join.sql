/*
  SQL Join
  ========
  1.Inner join
  2.Left join
  3.Right join
  4.Outer join
  5.Self join
  6.Natural join
  7.Cross join

  syntax
  =======
  select t1.col1,t2.col2,t1.col3,
  from table1 t1
  join table2 t2
  on t1.pk= t2.fk

*/
SELECT concat(sc.first_name, ' ', last_name) AS customer_name,
       sc.email,
       sc.street,
       city,
       sc.state,
       sc.zip_code,
       so.order_status,
       so.customer_id,
       so.order_date,
       so.required_date,
       so.shipped_date
FROM   sales.customers AS sc
       INNER JOIN
       sales.orders AS so
       ON sc.customer_id = so.customer_id;

SELECT *
FROM   sales.customers AS sc
       INNER JOIN
       sales.orders AS so
       ON sc.customer_id = so.customer_id
       INNER JOIN
       sales.order_items AS soi
       ON so.order_id = soi.order_id;

SELECT   concat(first_name, ' ', last_name) AS Customer_name,
         sum((soi.quantity * soi.list_price) * (1 - soi.discount)) AS total_price
FROM     sales.customers AS sc
         INNER JOIN
         sales.orders AS so
         ON sc.customer_id = so.customer_id
         INNER JOIN
         sales.order_items AS soi
         ON so.order_id = soi.order_id
GROUP BY sc.first_name, sc.last_name
ORDER BY total_price DESC;

SELECT   first_name,
         count(pp.product_id) AS total_product
FROM     sales.customers AS sc
         INNER JOIN
         sales.orders AS so
         ON sc.customer_id = so.customer_id
         INNER JOIN
         sales.order_items AS soi
         ON so.order_id = soi.order_id
         INNER JOIN
         production.products AS pp
         ON soi.product_id = pp.product_id
GROUP BY first_name;

--CROSS JOIN
SELECT *
FROM   sales.customers CROSS JOIN sales.orders;


