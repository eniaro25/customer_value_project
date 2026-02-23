-- 01_staging_sales.sql
-- Purpose: Create cleaned staging sales table excluding cancelled orders

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.stg_sales` AS

SELECT
    order_id,
    user_id,
    product_id,
    created_at,
    sale_price,
    status
FROM `clv-retail-analysis.raw_thelook_ecommerce.order_items`
WHERE status IN ('Complete', 'Shipped');