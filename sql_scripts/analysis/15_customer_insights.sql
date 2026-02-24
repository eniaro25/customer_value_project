-- 15_customer_insights.sql
-- Purpose: Create dashboard-ready customer insights table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_insights` AS

WITH segmented AS (

    SELECT
        user_id,
        recency_days,
        total_orders,
        total_spent,
        r_score,
        f_score,
        m_score,

        CASE
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'High Value'
            WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal'
            WHEN r_score = 5 AND f_score <= 2 THEN 'New Customer'
            WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
            ELSE 'Churn Risk'
        END AS customer_segment

    FROM `clv-retail-analysis.analytics.customer_rfm`
)

SELECT
    s.user_id,
    u.country,
    u.state,
    u.traffic_source,
    s.recency_days,
    s.total_orders,
    s.total_spent,
    s.r_score,
    s.f_score,
    s.m_score,
    s.customer_segment

FROM segmented s
JOIN `clv-retail-analysis.analytics.dim_users` u
    ON s.user_id = u.user_id;