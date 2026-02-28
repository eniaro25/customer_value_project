-- 06_join_validation.sql
-- Purpose: Validate relationship between fact_sales and dim_users

SELECT
    f.order_id,
    f.sale_price,
    u.country,
    u.gender
FROM `clv-retail-analysis.analytics.fact_sales` f
JOIN `clv-retail-analysis.analytics.dim_users` u
    ON f.user_id = u.user_id
LIMIT 10;