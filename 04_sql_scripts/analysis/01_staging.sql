-- O1_staging_users.sql 
-- Purpose: Create clean staging user table and created age group column

CREATE OR REPLACE TABLE clv-retail-analysis.staging.stg_user AS

SELECT 
CAST(id AS INT64) AS user_id,
INITCAP (TRIM(gender)) AS gender,
CAST(age AS INT64) AS age,

CASE
  WHEN age <25 THEN '18-24'
  WHEN age BETWEEN 25 AND 34 THEN '25-34'
  WHEN age BETWEEN 35 AND 44 THEN '35-44'
  ELSE '45+'
END AS age_group,

TRIM(country) AS country

FROM `clv-retail-analysis.raw_thelook_ecommerce.users`
WHERE id IS NOT NULL 

-- 02_staging_orders.sql
-- Purpose: Create clean staging order table, with only required and no NULLs

CREATE OR REPLACE TABLE clv-retail-analysis.staging.stg_orders AS
SELECT
  CAST(order_id AS INT64) AS order_id,
  CAST(user_id AS INT64) AS user_id,
  TIMESTAMP(created_at) AS order_created_at,
  TRIM(status) AS status
FROM `clv-retail-analysis.raw_thelook_ecommerce.orders`
WHERE order_id IS NOT NULL
  AND user_id IS NOT NULL;

  -- 03_staging_order_items.sql
  -- Purpose: Create clean order items table 

  CREATE OR REPLACE TABLE clv-retail-analysis.staging.stg_order_items AS
SELECT
  CAST(id AS INT64) AS order_item_id,
  CAST(order_id AS INT64) AS order_id,
  CAST(user_id AS INT64) AS user_id,
  CAST(product_id AS INT64) AS product_id,  
  SAFE_CAST(sale_price AS NUMERIC) AS sale_price
FROM `clv-retail-analysis.raw_thelook_ecommerce.order_items`
WHERE id IS NOT NULL
  AND order_id IS NOT NULL
  AND user_id IS NOT NULL;

  -- 04_staging_products.sql
  -- Purpose: Create clean product table

  CREATE OR REPLACE TABLE clv-retail-analysis.staging.stg_products AS
SELECT
  CAST(id AS INT64)AS product_id,
  TRIM (category) AS category,

  SAFE_CAST(retail_price AS NUMERIC) AS retail_price,
  SAFE_CAST(cost AS NUMERIC) AS cost

  FROM `clv-retail-analysis.raw_thelook_ecommerce.products`
  WHERE id IS NOT NULL

