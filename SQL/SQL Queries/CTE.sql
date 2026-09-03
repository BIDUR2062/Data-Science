/*
Common Table Expression (CTE)
---------------------------
Temporary data tabe

with cte_name as (
			query...........
			)
	select * from cte_name;
*/
WITH   product_price
AS     (SELECT product_id,
               list_price
        FROM   production.products
        WHERE  list_price < ALL (SELECT list_price
                                 FROM   production.products
                                 WHERE  list_price IN (209.99, 250.99)))
SELECT DISTINCT sc.first_name,
                sc.last_name,
                pp.product_id
FROM   product_price AS pp
       INNER JOIN
       sales.order_items AS soi
       ON pp.product_id = soi.product_id
       INNER JOIN
       sales.orders AS so
       ON soi.order_id = so.order_id
       INNER JOIN
       sales.customers AS sc
       ON so.customer_id = sc.customer_id
       WHERE order_status =4;

--Find total amount spent by customers  from each state. Display state and Total Amount.
with customer_spent as(
select concat(first_name,' ',last_name) as customer_name,sc.state,((soi.list_price*soi.quantity)*(1-soi.discount)) as total_spent
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
join sales.order_items as soi
on so.order_id=soi.order_id
where order_status=4
)
select state,SUM(total_spent) as total_price from customer_spent
group by state;
