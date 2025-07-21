CREATE DATABASE sql_project_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);


-- DATA CLEANING 

SELECT COUNT(*) FROM retail_sales;

SELECT COUNT( DISTINCT customer_id ) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
	WHERE transactionS_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
		  gender IS NULL OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR 
		  total_sale IS NULL;

DELETE FROM retail_sales
	WHERE transactionS_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
		  gender IS NULL OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR 
		  total_sale IS NULL;


-- DATA EXPLORATION 
	--how many sales count we have
SELECT COUNT(*) FROM retail_sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS
--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2.	Write a SQL query to retrieve all transactions where the 
--      category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'  AND quantiy >=4 AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
ORDER BY sale_date;

-- 3.	Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale) AS net_sale, count(*) AS total_orders FROM retail_sales
GROUP BY  category;

--4.	Write a SQL query to find the average age of customers 
--		who purchased items from the 'Beauty' category.:
SELECT category,AVG(age) FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;


--5.	Write a SQL query to find all transactions where the total_sale is greater than 1000 :
SELECT * FROM retail_sales
WHERE total_sale > 1000;

--6.	Write a SQL query to find the total number of transactions (transaction_id) 
--		made by each gender in each category.:
SELECT gender, category ,count(*) FROM retail_sales
GROUP BY gender, category;

--7.	Write a SQL query to calculate the average sale for each month.
--		Find out best selling month in each year:
SELECT 
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG (total_sale) AS total_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY 1,2;



--8.Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT customer_id,sum(total_sale) AS total_sale
FROM retail_saleS
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

--9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
		category,
		COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY 1;


--10.Write a SQL query to create each shift and number of orders (Example Morning <12,
--		Afternoon Between 12 & 17, Evening >17):

SELECT 
	CASE 
		WHEN EXTRACT (HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT ( HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS shift,
		count(*)
FROM retail_sales
GROUP BY shift
ORDER BY 2;


