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

This structure enables efficient aggregation for RFM segmentation and retention analysis.
The fact table was validated through join testing to confirm row counts were preserved and relationships between fact_sales and dim_users were correctly aligned.