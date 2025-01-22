-- creating database for the data 
create database Sales;
-- importing the sales data into mysql workbench
-- making database active
use sales;

--                                  Data Extration 
-- 1. extract all information on the table
select * from sales_data;  
-- 2.	Calculate the average purchase amount,
--  total sales, and number of purchases for each combination of Customer_type  and gender 
SELECT Customer_type, Gender, AVG(Total) AS avg_purchase_amount, SUM(Total) AS total_sales, 
COUNT(*) AS purchase_count FROM sales_data GROUP BY Customer_type, Gender;

-- 3. Calculate the average quantity sold per transaction for each Product_line.
--  Identify high-demand products by setting a threshold on this average quantity.
SELECT Product_line,AVG(Quantity) AS avg_quantity_sold
FROM sales_data  GROUP BY Product_line
HAVING AVG(Quantity) > 5 order by AVG(Quantity) desc;

-- 4. Extract Branch and Rating distribution to get branch with the highest rating 
select Branch, sum(Rating) as Rating from sales_data group by Branch order by Rating desc;

-- 5. Identify Product_line with the highest unit price
select Product_line, sum(Unit_price) from sales_data group by product_line order by sum(Unit_price) desc limit 1;


--                                      Data Transformation
-- 1.	Convert the Date and Time columns into a standard timestamp format for consistency and ease of use in analysis
-- adding new column to transform the date 
alter table sales_data add column New_Date text;

-- updating the new column to insert date values from existing data 
update sales_data set new_date = Date;

-- transforming the date format from month/day/year to normal sql format of year/month/dat 
update sales_data set New_Date = date_format(str_to_date(new_date, '%m/%d/%Y'), '%Y/%m/%d');

-- changing the new date datatype to date
alter table sales_data modify column new_date date; 



--                               DATA CLEANING AND PREPROCESSING
-- 1.Identify any rows with missing values, particularly in critical columns like Quantity,
--  Unit_price, or Total
SELECT *
FROM sales_data
WHERE Quantity IS NULL OR Unit_price IS NULL OR Total IS NULL OR Rating IS NULL OR gross_income IS NULL;

-- 2. Identify and exclude transactions where the Rating column has extreme outliers (e.g., ratings below 2 or above 9.5) 
DELETE FROM sales_data
WHERE Rating < 2 OR Rating > 9.5;
select count(*) from sales_data;
