-- 03_dim_products.sql
-- Purpose: Create product dimension table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_products` AS

SELECT
    id AS product_id,
    category,
    brand,
    department,
    retail_price,
    cost
FROM `clv-retail-analysis.raw_thelook_ecommerce.products`;