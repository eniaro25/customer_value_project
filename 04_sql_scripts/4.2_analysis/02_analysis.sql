-- 05_dim_users.sql
-- Purpose: Create user dimension with surrogate key

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_users` AS

SELECT
    ROW_NUMBER() OVER() AS user_key,   -- surrogate key
    user_id,                           -- business key
    gender,
    age,
    age_group,
    country
FROM `clv-retail-analysis.staging.stg_user`;

-- 06_dim_products.sql
-- Purpose: Create product dimension with surrogate key

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_products` AS

SELECT
    ROW_NUMBER() OVER() AS product_key,   -- surrogate key
    product_id,                           -- business key
    category,
    retail_price,
    cost
FROM `clv-retail-analysis.staging.stg_products`;

-- 07_dim_date.sql
-- Purpose: Create date dimension

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_date` AS

SELECT DISTINCT
    CAST(FORMAT_TIMESTAMP('%Y%m%d', order_created_at) AS INT64) AS date_key,
    DATE(order_created_at) AS full_date,
    EXTRACT(YEAR FROM order_created_at) AS year,
    EXTRACT(QUARTER FROM order_created_at) AS quarter,
    EXTRACT(MONTH FROM order_created_at) AS month,
    FORMAT_TIMESTAMP('%B', order_created_at) AS month_name
FROM `clv-retail-analysis.staging.stg_orders`;

CREATE OR REPLACE TABLE `analytics.fact_sales` AS

SELECT
    d.date_key,
    u.user_key,
    p.product_key,
    oi.order_id,
    oi.order_item_id,
    oi.sale_price

FROM `staging.stg_order_items` oi

JOIN `staging.stg_orders` o
    ON oi.order_id = o.order_id

JOIN `analytics.dim_users` u
    ON oi.user_id = u.user_id

JOIN `analytics.dim_products` p
    ON oi.product_id = p.product_id

JOIN `analytics.dim_date` d
    ON DATE(o.order_created_at) = d.full_date

WHERE o.status NOT IN ('Cancelled', 'Returned');
