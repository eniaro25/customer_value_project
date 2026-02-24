-- 14_customer_segments.sql
-- Purpose: Create customer segments from RFM scores

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

FROM `clv-retail-analysis.analytics.customer_rfm`;