# 1)What are total sales, profit, and order volume?

SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_performance;

# 2)Which regions generate highest sales and profit?

SELECT
region,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit
FROM sales_performance
group by region
order by total_sales desc;

# 3)Which categories and sub-categories perform best?

SELECT 
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_performance
GROUP BY category, sub_category
ORDER BY category, total_profit DESC;

# 4)What are monthly sales and profit trends?

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(sales), 2) AS monthly_sales,
    ROUND(SUM(profit), 2) AS monthly_profit
FROM sales_performance
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

# 5)Which products generate high sales but low profit?

SELECT 
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_performance
GROUP BY product_name
HAVING total_profit < 0  -- Look for products making a loss despite high sales
ORDER BY total_sales DESC
LIMIT 10;

# 6)How do discounts impact profitability?

SELECT 
    discount,
    ROUND(AVG(profit), 2) AS avg_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_performance
GROUP BY discount
ORDER BY discount;

# 7)Which states or regions are loss-making?

SELECT 
    state,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_performance
GROUP BY state
HAVING total_profit < 0
ORDER BY total_profit ASC;

# 8)Which customer segments are most profitable?

SELECT 
    segment,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_performance
GROUP BY segment
ORDER BY total_profit DESC;

# 9)Who are the top customers by revenue?

SELECT 
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_revenue
FROM sales_performance
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC
LIMIT 10;

# 10)Which customers place repeat orders frequently?

SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS order_frequency
FROM sales_performance
GROUP BY customer_id, customer_name
ORDER BY order_frequency DESC
LIMIT 10;

# 11)Which products should potentially be discontinued?

SELECT 
    product_id,
    product_name,
    ROUND(SUM(profit), 2) AS total_loss,
    COUNT(order_id) AS total_orders_placed
FROM sales_performance
GROUP BY product_id, product_name
HAVING total_loss < -1000 -- Products that have lost over $1,000 overall
ORDER BY total_loss ASC;

# 12)Which products rely too heavily on discounts?

SELECT 
    product_name,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_performance
GROUP BY product_name
ORDER BY avg_discount_percentage DESC
LIMIT 10;

# 13) Rank top-selling products within each category.

WITH ranked_products AS (
    SELECT 
        category,
        product_name,
        ROUND(SUM(sales), 2) AS total_sales,
        DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS sales_rank
    FROM sales_performance
    GROUP BY category, product_name
)
SELECT * FROM ranked_products
WHERE sales_rank <= 3; 

# 14) Compare product sales against category averages.

SELECT 
    product_name,
    category,
    sales,
    ROUND(AVG(sales) OVER(PARTITION BY category), 2) AS category_avg_sales,
    ROUND(sales - AVG(sales) OVER(PARTITION BY category), 2) AS diff_from_avg
FROM sales_performance;

# 15)Create monthly running total sales.

WITH monthly_totals AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS monthly_sales
    FROM sales_performance
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    month,
    ROUND(monthly_sales, 2) AS sales_this_month,
    ROUND(SUM(monthly_sales) OVER(ORDER BY month), 2) AS cumulative_running_total
FROM monthly_totals;
