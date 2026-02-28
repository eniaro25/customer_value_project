-- 08_rfm_monetary.sql
-- Purpose: Calculate total customer spend (Monetary)

SELECT
    user_id,
    SUM(sale_price) AS total_spent
FROM `clv-retail-analysis.analytics.fact_sales`
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 20;