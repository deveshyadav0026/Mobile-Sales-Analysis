CREATE DATABASE vivo_sales_analysis;

USE vivo_sales_analysis;

CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    day_name VARCHAR(20),
    brand VARCHAR(50),
    mobile_model VARCHAR(100),
    price_per_unit DECIMAL(10,2),
    units_sold INT,
    customer_name VARCHAR(100),
    customer_age INT,
    city VARCHAR(50),
    payment_method VARCHAR(50),
    customer_rating DECIMAL(2,1)
);

LOAD DATA LOCAL INFILE
'C:/projects/mobile sales analysis/5k_Vivo_Transactions.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    transaction_id,
    @sale_date,
    day_name,
    brand,
    mobile_model,
    price_per_unit,
    units_sold,
    customer_name,
    customer_age,
    city,
    payment_method,
    customer_rating
)
SET sale_date = STR_TO_DATE(@sale_date, '%d-%m-%Y');
select * from sales;

-- CHECK NUMBER OF ROWS ----
SELECT COUNT(*) AS total_records
FROM sales;

-- CHECK DUPLICATE TRANSACTION IDs ---
SELECT
    transaction_id,
    COUNT(*) AS count
FROM sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- CHECK NULL VALUES ---
SELECT COUNT(*) AS missing_transaction_id
FROM sales
WHERE transaction_id IS NULL;

SELECT COUNT(*) FROM sales WHERE sale_date IS NULL;
SELECT COUNT(*) FROM sales WHERE mobile_model IS NULL;
SELECT COUNT(*) FROM sales WHERE price_per_unit IS NULL;
SELECT COUNT(*) FROM sales WHERE units_sold IS NULL;
SELECT COUNT(*) FROM sales WHERE city IS NULL;
SELECT COUNT(*) FROM sales WHERE payment_method IS NULL;


--------------    BASIC BUSINESS KPIs      -------------

-- TOTAL REVENUE ---
SELECT
    SUM(price_per_unit * units_sold) AS total_revenue
FROM sales;

-- TOTAL UNIT SOLD ---
SELECT
    SUM(units_sold) AS total_units_sold
FROM sales;

-- AVERAGE TRANSACTION VALUE --
SELECT
    AVG(price_per_unit * units_sold) AS avg_transaction_value
FROM sales;

-- AVERAGE CUSTOMER RATING --
SELECT
    AVG(customer_rating) AS avg_rating
FROM sales;


----- PRODUCT ANALYSIS ------
SELECT
    mobile_model,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY mobile_model
ORDER BY revenue DESC;

-- TOP 5 MOBILE MODEL ---
SELECT
    mobile_model,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY mobile_model
ORDER BY revenue DESC
LIMIT 5;

----- PRICE SEGMENT ANALYSIS -----
SELECT
    mobile_model,
    price_per_unit,
    CASE
        WHEN price_per_unit < 15000 THEN 'Budget'
        WHEN price_per_unit < 30000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_segment
FROM sales
group by mobile_model, price_per_unit;


-- PRICE SEGMENT CONTRIBUTION BY REVENUE ----
SELECT
    CASE
        WHEN price_per_unit < 15000 THEN 'Budget'
        WHEN price_per_unit < 30000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_segment,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY price_segment
ORDER BY revenue DESC;


----- GEOGRAPHICAL ANALYSIS ---------

-- REVENUE BY CITY ---
SELECT
    city,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;


-- ANALYSIS BY PAYMENT METHOD ----
SELECT
    payment_method,
    COUNT(*) AS transactions,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY payment_method
ORDER BY revenue DESC;


-- REVENUE BY AGE GROUP -----
SELECT
    CASE
        WHEN customer_age < 25 THEN '18-24'
        WHEN customer_age < 35 THEN '25-34'
        WHEN customer_age < 45 THEN '35-44'
        WHEN customer_age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS transactions,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY age_group
ORDER BY revenue DESC;


-- REVENUE BY DAY OF WEEK ----
SELECT
    day_name,
    COUNT(*) AS transactions,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY day_name
ORDER BY revenue DESC;


-- ANALYSIS BY MONTH -------
SELECT
    MONTH(sale_date) AS month,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY  MONTH(sale_date)
ORDER BY  month;


WITH monthly_sales AS (
    SELECT
        YEAR(sale_date) AS sales_year,
        MONTH(sale_date) AS sales_month,
        MONTHNAME(sale_date) AS month_name,
        SUM(price_per_unit * units_sold) AS monthly_revenue
    FROM sales
    GROUP BY
        YEAR(sale_date),
        MONTH(sale_date),
        MONTHNAME(sale_date)
),

yoy_analysis AS (
    SELECT
        sales_year,
        sales_month,
        month_name,
        monthly_revenue,
        LAG(monthly_revenue, 1) OVER (
            PARTITION BY sales_month
            ORDER BY sales_year
        ) AS previous_year_revenue
    FROM monthly_sales
)

SELECT
    sales_year,
    month_name,
    monthly_revenue,
    previous_year_revenue,
    ROUND(
        (monthly_revenue - previous_year_revenue)
        / NULLIF(previous_year_revenue, 0) * 100,
        2
    ) AS yoy_growth_percentage
FROM yoy_analysis
ORDER BY sales_year, sales_month;


-- PRODUCTS RANKING BY REVENUE ------
WITH product_sales AS (
    SELECT
        mobile_model,
        SUM(price_per_unit * units_sold) AS revenue
    FROM sales
    GROUP BY mobile_model
)

SELECT
    mobile_model,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM product_sales;


-- BEST PERFORMING MOBILE MODEL IN EACH CITY ---------
WITH city_product_sales AS (
    SELECT
        city,
        mobile_model,
        SUM(price_per_unit * units_sold) AS revenue
    FROM sales
    GROUP BY city, mobile_model
),

ranked AS (
    SELECT
        city,
        mobile_model,
        revenue,
        RANK() OVER (
            PARTITION BY city
            ORDER BY revenue DESC
        ) AS product_rank
    FROM city_product_sales
)

SELECT
    city,
    mobile_model,
    revenue
FROM ranked
WHERE product_rank = 1;


-- CUSTOMER RATING WISE ANALYSIS --------
SELECT
    mobile_model,
    COUNT(*) AS transactions,
    AVG(customer_rating) AS avg_rating,
    SUM(units_sold) AS units_sold,
    SUM(price_per_unit * units_sold) AS revenue
FROM sales
GROUP BY mobile_model
ORDER BY avg_rating DESC;









