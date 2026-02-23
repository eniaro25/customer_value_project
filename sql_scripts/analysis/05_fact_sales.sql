-- 05_fact_sales.sql
-- Purpose: Create final fact sales table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.fact_sales` AS

SELECT
    order_id,
    user_id,
    product_id,
    DATE(created_at) AS order_date,
    sale_price
FROM `clv-retail-analysis.analytics.stg_sales`;