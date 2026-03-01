-- 13_customer_insights.sql
-- Purpose: Final BI-ready customer mart
-- Grain: 1 row per customer

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_insights`
CLUSTER BY customer_segment AS

SELECT
    s.user_key,
    s.user_id,
    u.age,
    u.age_group,
    u.country,
    s.recency_days,
    s.total_orders,
    s.total_spent,
    s.r_score,
    s.f_score,
    s.m_score,
    s.rfm_segment,
    s.rfm_total_score,
    s.customer_segment

FROM `clv-retail-analysis.analytics.customer_segments` s

JOIN `clv-retail-analysis.analytics.dim_users` u
    ON s.user_key = u.user_key;