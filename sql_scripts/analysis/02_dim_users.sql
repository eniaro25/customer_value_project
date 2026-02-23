-- 02_dim_users.sql
-- Purpose: Create user dimension table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.dim_users` AS

SELECT
    id AS user_id,
    first_name,
    last_name,
    gender,
    age,
    country,
    state,
    traffic_source,
    created_at AS user_created_at
FROM `clv-retail-analysis.raw_thelook_ecommerce.users`;