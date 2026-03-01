# Exploration Notes

Most analysis was performed directly in BigQuery SQL.

## Source Schema Review & Assumptions

- The `distribution_centers`, `events`, and `inventory_items` tables were excluded as they are not required for RFM (Recency, Frequency, Monetary) analysis and do not impact analytical integrity.

- Timestamp and address naming conventions were not fully standardised. It was assumed that these fields are unique to each table and represent entity-specific attributes.

- The `gender` field in the `orders` table is assumed to originate from the `users` table. As it is not relevant to RFM scoring, it was excluded from the analytical model.

## Explore Relevant tables 

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.users`
LIMIT 10;

The `user_id` is imperative to analysis the RFM scores.

The behavioural segmentation can be analysed based on location, gender or age. 

All other user attributes were considered out of scope for the RFM scoring.

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.orders`
LIMIT 10;

SELECT DISTINCT (status)
FROM `clv-retail-analysis.raw_thelook_ecommerce.orders`
LIMIT 10 

Observed order status includes 'Cancelled, Complete. Processing, Returned and Shipped'.

For revenue calculations only orders with status `Complete` and `Shipped` were included. 

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.order_items`
LIMIT 10;

Monetary calculations were performed at the `order_items` grain, as `sale_price` exists at item level. However, order validity was determined using the orders table.

Only orders with status `Complete` or `Shipped` were included, ensuring that revenue reflects finalised transactions before aggregating item-level revenue to the customer level.

Further analysis focused on:
- Validating joins between fact and dimension tables
- Testing window functions for customer ranking
- Understanding recency distribution