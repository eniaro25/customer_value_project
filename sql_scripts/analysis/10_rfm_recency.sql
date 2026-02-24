-- 10_rfm_recency.sql
-- Purpose: Calculate recency using dataset max date instead of CURRENT_DATE()

WITH max_date AS (
    SELECT MAX(order_date) AS dataset_max_date
    FROM `clv-retail-analysis.analytics.fact_sales`
)

SELECT
    f.user_id,
    MAX(f.order_date) AS last_order_date,
    DATE_DIFF(m.dataset_max_date, MAX(f.order_date), DAY) AS recency_days
FROM `clv-retail-analysis.analytics.fact_sales` f
CROSS JOIN max_date m
GROUP BY f.user_id, m.dataset_max_date
ORDER BY recency_days ASC
LIMIT 20;