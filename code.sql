-- CTE to filter out fraudulent transactions by excluding orders with an amount of $704000
WITH cleanedorders AS (
    SELECT 
        order_id,
        user_id,
        order_amount,
        total_items,
        payment_method,
        created_at
    FROM 
        orders
    WHERE 
        order_amount < 700000 -- Excluding the fraudulent order amount of 704000
),

-- CTE to categorize orders based on the total number of items
CategorizedOrders AS (
    SELECT 
        order_id,
        user_id,
        order_amount,
        total_items,
        payment_method,
        created_at,
        CASE
            WHEN total_items BETWEEN 1 AND 2 THEN 'Small'
            WHEN total_items BETWEEN 3 AND 5 THEN 'Medium'
            WHEN total_items > 5 THEN 'Large'
        END AS order_size
    FROM 
        Orders
),

-- CTE to calculate the frequency and percentage of each order size category
ordersizestats AS (
    SELECT 
        order_size,
        COUNT(*) AS count,
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders) AS percentage
    FROM 
        categorizedorders
    GROUP BY 
        order_size
),

-- CTE to join cleaned orders with customers to get demographic information
customerorders AS (
    SELECT 
        c.user_id,
        c.age_group,
        c.state,
        o.order_id,
        o.order_amount,
        o.total_items,
        o.payment_method,
        o.created_at
    FROM 
        customers c
    JOIN 
        cleanedorders o ON c.user_id = o.user_id
),

-- CTE to calculate the distribution of customers by state
customerdistribution AS (
    SELECT 
        state,
        COUNT(DISTINCT user_id) AS customer_count
    FROM 
        customerorders
    GROUP BY 
        state
),

-- CTE to calculate the total spend for each customer
customerspend AS (
    SELECT 
        user_id,
        SUM(order_amount) AS total_spend
    FROM 
        cleanedorders
    GROUP BY 
        user_id
),

-- CTE to identify the top 10 customers based on total spend
topcustomers AS (
    SELECT 
        user_id,
        total_spend
    FROM 
        customerspend
    ORDER BY 
        total_spend DESC
    LIMIT 10
),

-- CTE to join the top 10 customers with customer demographics
topcustomerdemographics AS (
    SELECT 
        t.user_id,
        t.total_spend,
        c.age_group,
        c.state
    FROM 
        topcustomers t
    JOIN 
        customers c ON t.user_id = c.user_id
),

-- CTE to standardize weekly data by truncating dates to the start of the week
standardizedweeks AS (
    SELECT 
        order_id,
        user_id,
        order_amount,
        total_items,
        payment_method,
        DATE_TRUNC('week', created_at::date) AS week_start
    FROM 
        cleanedorders
),

-- CTE to aggregate weekly sales
weeklysales AS (
    SELECT 
        CONCAT(
            EXTRACT(YEAR FROM week_start), '-',
            LPAD(EXTRACT(MONTH FROM week_start)::text, 2, '0'), '-',
            LPAD(EXTRACT(DAY FROM week_start)::text, 2, '0'), 'T00:00:00.000Z'
        ) AS current_week,
        SUM(order_amount) AS current_week_sales
    FROM 
        standardizedweeks
    GROUP BY 
        week_start
    ORDER BY 
        week_start
)

-- Final query to calculate week-over-week growth in order values
SELECT 
    current_week,
    current_week_sales,
    LAG(current_week_sales, 1) OVER (ORDER BY current_week) AS previous_week_sales,
    CASE 
        WHEN LAG(current_week_sales, 1) OVER (ORDER BY current_week) IS NULL THEN 'N/A'
        ELSE ROUND(
            (current_week_sales - LAG(current_week_sales, 1) OVER (ORDER BY current_week)) / NULLIF(LAG(current_week_sales, 1) OVER (ORDER BY current_week), 0) * 100, 2
        ) 
    END AS growth_percentage
FROM 
    weeklysales;

