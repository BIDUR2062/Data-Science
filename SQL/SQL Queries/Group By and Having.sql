/*
Group by and Having
------------------
Aggregate Function-> avg,sum,min,max,count

types of columns
1.Aggregate Columns
2.Non-Aggregate Columns
*/
SELECT   state,
         city,
         count(Customer_id) AS total_customers
FROM     sales.customers
GROUP BY state, city
HAVING   count(customer_id) > 2;

--Difference between Where and Having(Important)
--Find total orders in order status Pending Processing Rejected and Completed.
SELECT   CASE WHEN order_status = 1 THEN 'Pending' WHEN order_status = 2 THEN 'Processing' WHEN order_status = 3 THEN 'Rejected' WHEN order_status = 4 THEN 'Completed' END AS status_label,
         count(order_id) AS total_orders
FROM     sales.orders
GROUP BY order_status;

---Sum Case
SELECT SUM(CASE WHEN order_status = 1 THEN 1 ELSE 0 END) AS Pending,
       SUM(CASE WHEN order_status = 2 THEN 1 ELSE 0 END) AS Processing,
       SUM(CASE WHEN order_status = 3 THEN 1 ELSE 0 END) AS Rejected,
       SUM(CASE WHEN order_status = 4 THEN 1 ELSE 0 END) AS Completed
FROM   sales.orders;

--Analyze the rules of aggregate and group by
--Count case
SELECT COUNT(CASE WHEN order_status = 1 THEN 1 END) AS Pending,
       COUNT(CASE WHEN order_status = 2 THEN 1 END) AS Processing,
       COUNT(CASE WHEN order_status = 3 THEN 1 END) AS Rejected,
       COUNT(CASE WHEN order_status = 4 THEN 1 END) AS Completed
FROM   sales.orders;

-- Product Category Stock Evaluation
SELECT   category_id,
         count(CASE WHEN list_price > 2000 THEN 1 END) AS expensive_product_count
FROM     production.products
GROUP BY category_id
HAVING   count(CASE WHEN list_price > 2000 THEN 1 END) > 5;

-- Order Volume by Seasonal Quarters
SELECT   CASE WHEN month(order_date) BETWEEN 1 AND 6 THEN 'First Half' WHEN month(order_date) BETWEEN 7 AND 12 THEN 'Second Half' END AS month_label,
         count(order_id) AS total_orders
FROM     sales.orders
WHERE    year(order_date) = 2018
GROUP BY month(order_date)
HAVING   count(order_id) > 30;
--Another Method
SELECT 
    FORMAT(order_date, 'MMMM') AS month_name,
    CASE 
        WHEN MONTH(order_date) BETWEEN 1 AND 6 THEN 'First Half'
        WHEN MONTH(order_date) BETWEEN 7 AND 12 THEN 'Second Half'
    END AS month_label,
    COUNT(order_id) AS total_orders
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY 
    MONTH(order_date),
    FORMAT(order_date, 'MMMM'),
    CASE 
        WHEN MONTH(order_date) BETWEEN 1 AND 6 THEN 'First Half'
        WHEN MONTH(order_date) BETWEEN 7 AND 12 THEN 'Second Half'
    END
HAVING COUNT(order_id) > 30;