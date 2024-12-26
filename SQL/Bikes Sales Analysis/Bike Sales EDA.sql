-- Data Cleaning

SELECT *
FROM sales_data;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any columns or rows

-- 1. Removing duplicates

SELECT *
INTO sales_staging
FROM sales_data;

SELECT *
FROM sales_staging;

WITH Duplicate_CTE AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY Date, Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, Country, State, Product_Category, Sub_Category, Product, Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue ORDER BY Date) AS Row_Num
	FROM sales_staging
)
SELECT *
FROM Duplicate_CTE
WHERE Row_Num >= 2;

-- Example of a duplicate row
SELECT *
FROM sales_staging
WHERE Date = '2012-11-27' AND Country = 'Canada' AND State = 'British Columbia' AND Sub_Category = 'Road Bikes' AND Product = 'Road-650 Red, 44';

-- I decided to drop all duplicate rows, as although they may seem plausible in real life, I deemed that any duplicate rows would not be unlikely to occur in a real life scenario and thus irrelevant to the dataset.
-- Creating a second staging table to delete all duplicate rows.
SELECT *, ROW_NUMBER() OVER(PARTITION BY Date, Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, Country, State, Product_Category, Sub_Category, Product, Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue ORDER BY Date) AS Row_Num
INTO sales_staging2
FROM sales_staging;

-- Deleting duplicate rows
DELETE
FROM sales_staging2
WHERE Row_Num > 1;

SELECT *
FROM sales_staging2;

-- Dropping column Row_Num
ALTER TABLE sales_staging2
DROP COLUMN Row_Num;


-- Standardizing data.
UPDATE sales_staging2
SET State = 'Haute-Garonne'
WHERE State LIKE 'Garonne%';


-- Exploratory Data Analysis

SELECT *
FROM sales_staging2;

-- What is the total Profit made?
SELECT SUM(Profit) AS Total_Profit
FROM sales_staging2;

-- How many different countries are our products sold across?
SELECT COUNT(DISTINCT Country) AS Countries
FROM sales_staging2;

-- What countries did we sell to?
SELECT DISTINCT Country
FROM sales_staging2
ORDER BY 1 ASC;

-- How many products are sold?
SELECT COUNT (DISTINCT Product) AS Products
FROM sales_staging2;

-- What different products are sold?
SELECT DISTINCT Product 
FROM sales_staging2;

-- What are the different sub-categories? 
SELECT DISTINCT Sub_Category 
FROM sales_staging2;

-- What are the different product categories?
SELECT DISTINCT Product_Category 
FROM sales_staging2;

-- Profits made by each Product Category
SELECT Product_Category, SUM(Profit) AS Total_Profits
FROM sales_staging2
GROUP BY Product_Category
ORDER BY 2 DESC;

-- Profits made by each Sub_Category
SELECT Sub_Category, SUM(Profit) AS Total_Profits
FROM sales_staging2
GROUP BY Sub_Category
ORDER BY 2 DESC;

-- Profits made by each Product
SELECT Product, SUM(Profit) AS Total_Profits
FROM sales_staging2
GROUP BY Product
ORDER BY 2 DESC;

-- Which country brought in the most profit?
SELECT Country, SUM(Profit) AS Total_Profit
FROM sales_staging2
GROUP BY Country
ORDER BY 2 DESC;

SELECT Country, State, SUM(Profit) AS Total_Profit
FROM sales_staging2
GROUP BY Country, State
ORDER BY 3 DESC;

-- Which age group brought in the most profit
SELECT Age_Group, SUM(Profit) AS Total_Profit
FROM sales_staging2 
GROUP BY Age_Group
ORDER BY 2 DESC;

-- Which gender brought in the most profit
SELECT Customer_Gender, SUM(Profit) AS Total_Profit
FROM sales_staging2 
GROUP BY Customer_Gender
ORDER BY 2 DESC;

-- Yearly Profits
WITH Yearly_Profit AS
(
	SELECT Year, SUM(Profit) AS Total_Profit
	FROM sales_staging2
	GROUP BY Year
)
SELECT Year, Total_Profit, SUM(Total_Profit) OVER (ORDER BY Year) AS Rolling_Sum
FROM Yearly_Profit;

SELECT Product, SUM(Order_Quantity) AS Total_Orders
FROM sales_staging2
GROUP BY Product
ORDER BY 2 DESC;


-- Monthly Profits
SELECT SUBSTRING(CONVERT(varchar, Date, 120), 1, 7) AS Months, SUM(Profit) AS Total_Profit
FROM sales_staging2
GROUP BY SUBSTRING(CONVERT(varchar, Date, 120), 1, 7);

WITH Monthly(Months, Profits) AS
(
	SELECT SUBSTRING(CONVERT(varchar, Date, 120), 1, 7) AS Months, SUM(Profit) AS Total_Profit
	FROM sales_staging2
	GROUP BY SUBSTRING(CONVERT(varchar, Date, 120), 1, 7)
)
SELECT Months, Profits, SUM(Profits) OVER (ORDER BY Months) AS Monthly_Profits
FROM Monthly;

-- Monthly Revenue
WITH Monthly(Months, Revenue) AS
(
	SELECT SUBSTRING(CONVERT(varchar, Date, 120), 1, 7) AS Months, SUM(Revenue) AS Total_Revenue
	FROM sales_staging2
	GROUP BY SUBSTRING(CONVERT(varchar, Date, 120), 1, 7)
)
SELECT Months, Revenue, SUM(Revenue) OVER (ORDER BY Months) AS Monthly_Revenue
FROM Monthly;

--Which day had the highest and lowest profits

SELECT Date, Day, Month, Year, MAX(Profit) AS Max_Profit, MIN(Profit) AS Min_Profit
FROM sales_staging2
GROUP BY Date, Day, Month, Year
ORDER BY Min_Profit ASC;


WITH Profit_Table(Date, Day, Month, Year, Total_Profit) AS
(
	SELECT Date, Day, Month, Year, SUM(Profit) AS Total_Profit
	FROM sales_staging2
	GROUP BY Date, Day, Month, Year
)
SELECT *
FROM Profit_Table
WHERE Total_Profit IN (SELECT MAX(Total_Profit) FROM Profit_Table)
UNION ALL
SELECT *
FROM Profit_Table
WHERE Total_Profit IN (SELECT MIN(Total_Profit) FROM Profit_Table);

-- Which days did we make a loss?

SELECT Day, Month, Year, SUM(Profit) as Total_Profit
FROM sales_staging2
WHERE Profit < 0
GROUP BY Day, Month, Year
ORDER BY Total_Profit ASC;

SELECT *
FROM sales_staging2;

-- Which product did each state buy the most of?
SELECT State, Country, Product, SUM(Order_Quantity) AS Total_Quantity
FROM sales_staging2
GROUP BY State, Country, Product
ORDER BY State, Total_Quantity DESC;


--What was the most bought bike product by both adult males and females
WITH Male_Products(Customer_Gender, Product, Male_Orders) AS
(
	SELECT Customer_Gender, Product, SUM(Order_Quantity) AS Total_Quantity
	FROM sales_staging2
	WHERE Product_Category = 'Bikes' AND Customer_Gender = 'M' AND Age_Group LIKE 'Adults%'
	GROUP BY Customer_Gender, Product
), Female_Products(Customer_Gender, Product, Female_Orders) AS
(
	SELECT Customer_Gender, Product, SUM(Order_Quantity) AS Total_Quantity
	FROM sales_staging2
	WHERE Product_Category = 'Bikes' AND Customer_Gender = 'F' AND Age_Group LIKE 'Adults%'
	GROUP BY Customer_Gender, Product
)
SELECT *
FROM Male_Products
WHERE Male_Orders = (SELECT MAX(Male_Orders) FROM Male_Products)
UNION ALL
SELECT *
FROM Female_Products
WHERE Female_Orders = (SELECT MAX(Female_Orders) FROM Female_Products);

