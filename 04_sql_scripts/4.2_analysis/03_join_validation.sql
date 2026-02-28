-- 09_model_validation.sql
-- Purpose: Validate star schema integrity and fact table correctness

-- Notes:
--   - Validates joins did not create data loss
--   - Confirms fact table grain (1 row per order_item)
--   - Checks surrogate key integrity
--   - Reconciles revenue totals


/* =========================================================
   1. FACT TABLE ROW COUNT CHECK
   Compare staging vs fact (after status filtering)
========================================================= */

-- Staging row count (all order items)
SELECT 
    COUNT(*) AS staging_order_item_count
FROM `clv-retail-analysis.staging.stg_order_items`;


-- Fact row count (after joins and filtering)
SELECT 
    COUNT(*) AS fact_order_item_count
FROM `clv-retail-analysis.analytics.fact_sales`;



/* =========================================================
   2. NULL SURROGATE KEY CHECK
   Ensures all dimension joins succeeded
========================================================= */

SELECT *
FROM `clv-retail-analysis.analytics.fact_sales`
WHERE user_key IS NULL
   OR product_key IS NULL
   OR date_key IS NULL;



/* =========================================================
   3. FACT GRAIN VALIDATION
   Grain should be: 1 row per order_item_id
========================================================= */

SELECT 
    order_item_id,
    COUNT(*) AS duplicate_count
FROM `clv-retail-analysis.analytics.fact_sales`
GROUP BY order_item_id
HAVING COUNT(*) > 1;



/* =========================================================
   4. DIMENSION UNIQUENESS CHECK
   Business keys should map to exactly one surrogate key
========================================================= */

-- Users
SELECT 
    user_id,
    COUNT(*) AS user_key_count
FROM `clv-retail-analysis.analytics.dim_users`
GROUP BY user_id
HAVING COUNT(*) > 1;


-- Products
SELECT 
    product_id,
    COUNT(*) AS product_key_count
FROM `clv-retail-analysis.analytics.dim_products`
GROUP BY product_id
HAVING COUNT(*) > 1;



/* =========================================================
   5. REVENUE RECONCILIATION
   Ensures revenue is preserved after joins
========================================================= */

-- Revenue from staging (excluding cancelled/returned)
SELECT 
    SUM(oi.sale_price) AS staging_revenue
FROM `clv-retail-analysis.staging.stg_order_items` oi
JOIN `clv-retail-analysis.staging.stg_orders` o
    ON oi.order_id = o.order_id
WHERE o.status NOT IN ('Cancelled', 'Returned');


-- Revenue from fact table
SELECT 
    SUM(sale_price) AS fact_revenue
FROM `clv-retail-analysis.analytics.fact_sales`;



/* =========================================================
   6. REFERENTIAL INTEGRITY CHECK
   Ensure all fact foreign keys exist in dimensions
========================================================= */

-- Users missing from dimension
SELECT DISTINCT oi.user_id
FROM `clv-retail-analysis.staging.stg_order_items` oi
LEFT JOIN `clv-retail-analysis.analytics.dim_users` u
    ON oi.user_id = u.user_id
WHERE u.user_id IS NULL;


-- Products missing from dimension
SELECT DISTINCT oi.product_id
FROM `clv-retail-analysis.staging.stg_order_items` oi
LEFT JOIN `clv-retail-analysis.analytics.dim_products` p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
