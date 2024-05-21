-- Query to view all orders
SELECT * FROM orders;


-- Delete orders with specific order_amount anomalies (since the data was static for this project)
DELETE FROM orders
WHERE order_amount = 704000;


-- CTE for categorizing order sizes and calculating frequencies and percentages
WITH order_category AS (
    SELECT 
        order_id,
        CASE 
            WHEN total_items BETWEEN 1 AND 2 THEN 'Small'
            WHEN total_items BETWEEN 3 AND 5 THEN 'Medium'
            WHEN total_items > 5 THEN 'Large'
        END AS order_size
    FROM orders
),
    
order_counts AS (
    SELECT 
        order_size,
        COUNT(*) AS total_count,
        ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM orders), 2) AS percentage
    FROM order_category
    GROUP BY order_size
)

-- Use the CTE for display
SELECT * FROM order_counts ORDER BY total_count DESC;

------------------------------
-- CTE for finding the distribution of customers by state
WITH customer_distribution AS (
    SELECT 
        c.state,
        COUNT(DISTINCT c.user_id) AS numberofcustomers
    FROM 
        customers AS c
    JOIN 
        orders AS o ON c.user_id = o.user_id
    GROUP BY c.state
)
    
SELECT * 
FROM customer_distribution 
ORDER BY numberofcustomers DESC;

------------------------------
-- CTE for identifying top 10 customers by spending and fetching their demographic info
WITH customerspending AS (
    SELECT 
        o.user_id,
        SUM(o.order_amount) AS total_spent
    FROM 
        orders AS o
    GROUP BY o.user_id
    ORDER BY total_spent DESC
    LIMIT 10
),
top_customers_info AS (
    SELECT 
        cs.user_id,
        cs.total_spent,
        c.age_group,
        c.state
    FROM 
        customerspending AS cs
    JOIN 
        customers AS c ON cs.user_id = c.user_id
)
    
SELECT * 
FROM top_customers_info 
ORDER BY total_spent DESC;

------------------------------
-- CTE for week-over-week sales growth analysis
WITH weekly_sales AS (
    SELECT 
        DATE_TRUNC('week', created_at)::date AS week_start,
        SUM(order_amount) AS total_sales
    FROM 
        orders
    GROUP BY week_start
    ORDER BY week_start
),
    
week_over_week AS (
    SELECT 
        a.week_start,
        a.total_sales AS current_week_sales,
        b.total_sales AS previous_week_sales,
        COALESCE(ROUND(((a.total_sales - b.total_sales) / b.total_sales::numeric) * 100, 2), 0) AS growth_percentage
    FROM 
        weekly_sales AS a
    LEFT JOIN 
        weekly_sales AS b ON a.week_start = b.week_start + INTERVAL '1 week'
)
    
SELECT * 
FROM week_over_week 
ORDER BY week_start;
