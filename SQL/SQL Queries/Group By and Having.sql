/*
Group by and Having
------------------
Aggregate Function-> avg,sum,min,max,count

types of columns
1.Aggregate Columns
2.Non-Aggregate Columns
*/

select state,city ,count(Customer_id) as total_customers
from sales.customers
group by state,city
having count(customer_id) > 2;
--Difference between Where and Having(Important)