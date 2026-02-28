-- 07_window_function_preview.sql
-- Purpose: Preview window function by ranking customers by total spend

SELECT
    user_id,
    SUM(sale_price) AS total_spent,

    RANK() OVER (
        ORDER BY SUM(sale_price) DESC
    ) AS spend_rank

FROM `clv-retail-analysis.analytics.fact_sales`

GROUP BY user_id
LIMIT 20;
