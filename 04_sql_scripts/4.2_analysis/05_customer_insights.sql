-- 12_customer_insights.sql
-- Purpose: Final BI-ready customer mart

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_insights` AS

SELECT
    r.user_key,
    r.user_id,
    u.age,
    u.age_group,
    u.country,
    r.recency_days,
    r.total_orders,
    r.total_spent,
    r.r_score,
    r.f_score,
    r.m_score,
    r.customer_segment

FROM `clv-retail-analysis.analytics.customer_rfm_scored` r

JOIN `clv-retail-analysis.analytics.dim_users` u
    ON r.user_key = u.user_key;