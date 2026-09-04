SELECT *
FROM   [Fraud Detection Dataset];

/*
Window Function 
---------------
Row Number -> Duplicate Date 
Rank-> Data Ranking->Skip value
Dense Rank-> Data Ranking -> Doesnot skip Value

--Accepts Arguments
NTile -> divides data 
Lead -> Next Value
Lag -> Previous


Synatax
------
select 
	col1,col2,col3, window_function() Over(partition by col_name , order_by col_name)
from table_name;
*/
--Row Number
--Finding duplicate records using row number
SELECT Transaction_ID,
       User_ID,
       Transaction_Amount,
       Time_of_Transaction,
       Device_Used,
       Location,
       Previous_Fraudulent_Transactions,
       Account_Age,
       Number_of_Transactions_Last_24H,
       Payment_Method,
       Fraudulent,
       ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY Transaction_Amount) AS rn
FROM   [Fraud Detection Dataset];

--Remove duplicate records
WITH fraud_duplicate_data
AS   (SELECT Transaction_ID,
             User_ID,
             Transaction_Amount,
             Time_of_Transaction,
             Device_Used,
             Location,
             Previous_Fraudulent_Transactions,
             Account_Age,
             Number_of_Transactions_Last_24H,
             Payment_Method,
             Fraudulent,
             ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY Transaction_Amount) AS rn
      FROM   [Fraud Detection Dataset])
DELETE fraud_duplicate_data
WHERE  rn > 1;

--Rank 
SELECT product_id,
       product_name,
       brand_id,
       category_id,
       model_year,
       list_price,
       rank() OVER (PARTITION BY brand_id ORDER BY list_price)
FROM   production.products;

--Dense Rank
SELECT product_id,
       product_name,
       brand_id,
       category_id,
       model_year,
       list_price,
       dense_rank() OVER (PARTITION BY brand_id ORDER BY list_price)
FROM   production.products;

--Find the third highest price from the table.
SELECT *
FROM   (SELECT product_id,
               product_name,
               brand_id,
               category_id,
               model_year,
               list_price,
               dense_rank() OVER (PARTITION BY brand_id ORDER BY list_price DESC) AS rn
        FROM   production.products) AS data
WHERE  rn = 2;

--NTile
SELECT Transaction_ID,
       User_ID,
       Transaction_Amount,
       Time_of_Transaction,
       Device_Used,
       Location,
       Previous_Fraudulent_Transactions,
       Account_Age,
       Number_of_Transactions_Last_24H,
       Payment_Method,
       Fraudulent,
       NTILE(3) OVER (PARTITION BY time_of_transaction ORDER BY transaction_amount)
FROM   [Fraud Detection Dataset];

--Lead
SELECT Transaction_ID,
       User_ID,
       Transaction_Type,
       Transaction_Amount,
       Time_of_Transaction,
       Device_Used,
       Location,
       Previous_Fraudulent_Transactions,
       Account_Age,
       Number_of_Transactions_Last_24H,
       Payment_Method,
       Fraudulent,
       LEAD(Transaction_Type) OVER (ORDER BY transaction_amount)
FROM   [Fraud Detection Dataset];


--Lag
SELECT Transaction_ID,
       User_ID,
       Transaction_Type,
       Transaction_Amount,
       Time_of_Transaction,
       Device_Used,
       Location,
       Previous_Fraudulent_Transactions,
       Account_Age,
       Number_of_Transactions_Last_24H,
       Payment_Method,
       Fraudulent,
       LAG(Transaction_Type) OVER (ORDER BY transaction_amount)
FROM   [Fraud Detection Dataset];
