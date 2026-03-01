-- 10a_customer_recency.sql
-- Purpose: Calculate recency (days since last purchase)

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_recency` AS

SELECT
    f.user_key,
    u.user_id,
    MAX(d.full_date) AS last_purchase_date,
    DATE_DIFF(CURRENT_DATE(), MAX(d.full_date), DAY) AS recency_days

FROM `clv-retail-analysis.analytics.fact_sales` f

JOIN `clv-retail-analysis.analytics.dim_date` d
    ON f.date_key = d.date_key

JOIN `clv-retail-analysis.analytics.dim_users` u
    ON f.user_key = u.user_key

GROUP BY f.user_key, u.user_id;

-- 10b_customer_total_orders.sql
-- Purpose: Calculate total distinct orders per customer

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_total_orders` AS

SELECT
    user_key,
    COUNT(DISTINCT order_id) AS total_orders

FROM `clv-retail-analysis.analytics.fact_sales`

GROUP BY user_key;

-- 10c_customer_total_spent.sql
-- Purpose: Calculate total revenue per customer

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_total_spent` AS

SELECT
    user_key,
    SUM(sale_price) AS total_spent

FROM `clv-retail-analysis.analytics.fact_sales`

GROUP BY user_key;

-- 10d_customer_rfm.sql
-- Purpose: Combine recency, total_orders and total_spent

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_rfm` AS

SELECT
    r.user_key,
    r.user_id,
    r.recency_days,
    o.total_orders,
    s.total_spent

FROM `clv-retail-analysis.analytics.customer_recency` r

JOIN `clv-retail-analysis.analytics.customer_total_orders` o
    ON r.user_key = o.user_key

JOIN `clv-retail-analysis.analytics.customer_total_spent` s
    ON r.user_key = s.user_key;

-- 11_customer_rfm_scored.sql
-- Purpose: Apply quintile scoring to RFM metrics
-- Adds both rfm_segment (pattern) and rfm_total_score (strength)

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_rfm_scored`
CLUSTER BY r_score, f_score, m_score AS

WITH scored AS (

    SELECT *,

        -- Recency: lower days = better
        6 - NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,

        NTILE(5) OVER (ORDER BY total_orders ASC) AS f_score,
        NTILE(5) OVER (ORDER BY total_spent ASC) AS m_score

    FROM `clv-retail-analysis.analytics.customer_rfm`
)

SELECT
    *,
    
    -- Behaviour fingerprint
    CONCAT(
        CAST(r_score AS STRING),
        CAST(f_score AS STRING),
        CAST(m_score AS STRING)
    ) AS rfm_segment,

    -- Overall strength score (3–15 scale)
    r_score + f_score + m_score AS rfm_total_score

FROM scored;

-- 12_customer_segments.sql
-- Purpose: Assign business segments

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_segments` AS

SELECT
    user_key,
    user_id,
    recency_days,
    total_orders,
    total_spent,
    r_score,
    f_score,
    m_score,
    rfm_segment,
    rfm_total_score,

    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'High Value'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal'
        WHEN r_score = 5 AND f_score <= 2 THEN 'New Customer'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        ELSE 'Churn Risk'
    END AS customer_segment

FROM `clv-retail-analysis.analytics.customer_rfm_scored`;