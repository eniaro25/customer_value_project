-- 09_rfm_frequency.sql
-- Purpose: Count number of orders per customer (Frequency)

SELECT
    user_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM `clv-retail-analysis.analytics.fact_sales`
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 20;