SELECT * FROM retail_sales_analysis.`sql - retail sales analysis_utf  (3)`;
USE retail_sales_analysis;

SELECT *
FROM retail_sales_project
WHERE transactions_id IS NULL;

SELECT *
FROM retail_sales_project
WHERE sale_date IS NULL;

---Data Cleaning 

SELECT *
FROM retail_sales_project
WHERE transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    ------Data Exploration
    
    ----How many sales we have? ;
    
SELECT COUNT(*) As total_sale
FROM retail_sales_project;

 ----How many unique cutomers we have?;
 
 SELECT COUNT(DISTINCT customer_id)
 FROM retail_sales_project;
 
 --How many distinct category we have;
 
 SELECT COUNT(DISTINCT category)
 FROM retail_sales_project;
 
 ---Data Analysis and Business key Problems and Answers
 
---Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05;

SELECT *
FROM retail_sales_project
WHERE sale_date = '2022-11-05';

---Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is equal or more than 3 in the month of Nov-2022;


SELECT *
FROM retail_sales_project
WHERE category = 'Clothing' 
      AND
      quantiy >= 3
      AND 
      YEAR(sale_date) = 2022
      AND
      MONTH(sale_date) = 11;  
      
      
Q.3 Write a SQL query to calculate the total sales (total_sale) for each category;

SELECT
 category,
 SUM(total_sale) AS net_sale
FROM retail_sales_project
GROUP BY 1;

Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category;

SELECT
ROUND(AVG(age),2) AS average_age
FROM retail_sales_project
WHERE category = 'Beauty';

Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000;

SELECT *
FROM retail_sales_project
WHERE total_sale > 1000;

Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category;

SELECT 
category,
gender,
COUNT(transactions_id)
FROM retail_sales_project
GROUP BY 1,2
ORDER BY 1 ;

Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year;

SELECT *
FROM (
SELECT 
     year(sale_date),
     month(sale_date),
     avg(total_sale) AS avg_sale,
	 RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY avg(total_sale) DESC) as position
FROM retail_sales_project
GROUP BY 1,2
) as t1
WHERE position = 1 ;



Q.8 *Write a SQL query to find the top 5 customers based on the highest total sales ;

SELECT 
	  customer_id,
      SUM(total_sale) 
FROM retail_sales_project
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 ;

Q.9 Write a SQL query to find the number of unique customers who purchased items from each category ;
       
SELECT 
	  COUNT(DISTINCT customer_id),
      category
FROM retail_sales_project
GROUP BY 2 ;

 Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) WITH hourly_sale ; 


 WITH hourly_sale
 AS
 (
 SELECT *,
	  CASE 
          WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
          WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
          ELSE 'Evening'
	 END as shift
FROM retail_sales_project
)
SELECT 
	shift,
     COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

---End of project


 
    
    
    
    
    
    
    
    
    




























