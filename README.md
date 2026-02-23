# Retail & E-commerce Customer Lifetime Value (CLV) Analysis

## Project Overview
This project analyses customer lifetime value (CLV) using the TheLook E-commerce dataset in BigQuery.

## Tech Stack
- BigQuery
- Looker Studio
- VSCode
- GitHub

## Data Cleaning
Cancelled orders were excluded from revenue calculations to ensure accurate monetary metrics.

## Star Schema Design
Fact table: fact_sales (based on order_items)
Dimension tables: dim_users, dim_products, dim_date