# Star Schema Design

Fact Table
- fact_sales: transactional purchase events containing order_id,
  user_id, product_id, order_date, and sale_price.

Dimension Tables
- dim_users: customer attributes (country, state, traffic_source)
- dim_products: product attributes
- dim_dates: calendar attributes

The star schema separates measurable transactions from descriptive
dimensions to support scalable customer lifetime value analysis.