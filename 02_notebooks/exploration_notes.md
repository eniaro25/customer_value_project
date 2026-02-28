# Exploration Notes

Most analysis was performed directly in BigQuery SQL.

# Explore Available tables 

After reviweing the source schema it was noted that:
    the distribution_centers, events and inventory_items tables were not required for the RFM scores analysis and would not interfere with any other tables. 
    the naming convetions regarding the timestamp events and addresses are unclear. The assumtion was made that the addresses and timestamp events are unique to each table. 
    gender is included in the order table, the assumption is that this is taken from the user table, however this not relevant for the purposes of RFM score analysis.

## Explore Relevant tables 

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.users`
LIMIT 10;

The user_id is imperative to analysis the RFM scores, the behavioural segmentation can be analysed based on location, gender or age. 
For this project, location has been used at country level. The remaining fields are not required. 

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.orders`
LIMIT 10;

Noted order status includes 'Cancelled'

SELECT DISTINCT (status)
FROM `clv-retail-analysis.raw_thelook_ecommerce.orders`
LIMIT 10 

Noted order status includes 'Cancelled, Complete. Processing, Returned and Shipped'.
To calculate revenue only statuses "Complete and Shipped" will be used. 

SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.order_items`
LIMIT 10;

******COME BACK TO


SELECT *
FROM `clv-retail-analysis.raw_thelook_ecommerce.products`
LIMIT 10;

****** COME BACK TO 

Initial analysis focused on:
- Validating joins between fact and dimension tables
- Testing window functions for customer ranking
- Understanding recency distribution