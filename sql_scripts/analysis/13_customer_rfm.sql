-- 13_customer_rfm.sql
-- Purpose: Create final customer RFM model table

CREATE OR REPLACE TABLE `clv-retail-analysis.analytics.customer_rfm` AS

WITH monetary AS (
    SELECT
        user_id,
        SUM(sale_price) AS total_spent
    FROM `clv-retail-analysis.analytics.fact_sales`
    GROUP BY user_id
),

frequency AS (
    SELECT
        user_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM `clv-retail-analysis.analytics.fact_sales`
    GROUP BY user_id
),

max_date AS (
    SELECT MAX(order_date) AS dataset_max_date
    FROM `clv-retail-analysis.analytics.fact_sales`
),

recency AS (
    SELECT
        f.user_id,
        DATE_DIFF(m.dataset_max_date, MAX(f.order_date), DAY) AS recency_days
    FROM `clv-retail-analysis.analytics.fact_sales` f
    CROSS JOIN max_date m
    GROUP BY f.user_id, m.dataset_max_date
),

rfm_base AS (
    SELECT
        m.user_id,
        r.recency_days,
        f.total_orders,
        m.total_spent
    FROM monetary m
    JOIN frequency f ON m.user_id = f.user_id
    JOIN recency r ON m.user_id = r.user_id
)

SELECT
    user_id,
    recency_days,
    total_orders,
    total_spent,

    -- RFM Scores
    6 - NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
    NTILE(5) OVER (ORDER BY total_orders DESC) AS f_score,
    NTILE(5) OVER (ORDER BY total_spent DESC) AS m_score

FROM rfm_base;