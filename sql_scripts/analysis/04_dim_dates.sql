-- 04_dim_date.sql
-- Purpose: Create date dimension table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_date` AS

SELECT DISTINCT
    DATE(created_at) AS date,
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    EXTRACT(QUARTER FROM created_at) AS quarter
FROM `clv-retail-analysis.analytics.stg_sales`;