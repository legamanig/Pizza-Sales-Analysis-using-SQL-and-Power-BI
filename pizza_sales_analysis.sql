create database pizzadb;
use pizzadb;

select * from pizza_sales;

select sum(total_price) as total_revenue from pizza_sales;

select sum(total_price) / count(distinct order_id) from pizza_sales;

select sum(total_price) / count(distinct order_id) as Avg_order_value from pizza_sales;

select sum(quantity) as total_pizza_sold from pizza_sales;

select count(distinct order_id) as total_order from pizza_sales;

select sum(quantity) / count(distinct order_id) from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal (10,2)) as decimal(10,2) )as avg_pizzas_per_order from pizza_sales;


SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date);

SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

SELECT order_date
FROM pizza_sales
LIMIT 10;

SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')),
         MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'));



SELECT 
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 /
    (
        SELECT SUM(total_price)
        FROM pizza_sales
        WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
    ) AS PCT
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_category;

SELECT 
    pizza_size,
    SUM(total_price) AS total_sales,
    SUM(total_price) * 100 /
    (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_size;

SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        SUM(total_price) * 100 /
        (
            SELECT SUM(total_price)
            FROM pizza_sales
            WHERE QUARTER(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
        )
        AS DECIMAL(10,2)
    ) AS PCT
FROM pizza_sales
WHERE QUARTER(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

SELECT 
    pizza_name,
    count(distinct order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

SELECT 
    pizza_name,
    count(distinct order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders 
limit 5;
