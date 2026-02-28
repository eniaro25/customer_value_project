# Star Schema Design

Fact Table
- fact_sales: transactional purchase events containing order_id,
  user_id, product_id, order_date, and sale_price.

Dimension Tables
- dim_users: customer attributes (country, age, gender)
- dim_products: product attributes (category, retail price)
- dim_dates: calendar attributes

The star schema separates measurable transactions from descriptive
dimensions to support scalable customer lifetime value analysis.