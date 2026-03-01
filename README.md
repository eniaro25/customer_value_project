# Customer Lifetime Value (CLV) Analysis

## Project Goal 
This project analyses customer lifetime value (CLV) using the TheLook E-commerce dataset in BigQuery.

The object is to:
- Design a star schema 
- Transform raw data 
- Calculate RFM (Recency, Frequency, Monetary)
- Build a structured dashboard in Looker Studio

Useful for a E-Commerce business to:
- Identify high value customers 
- Detect customer at risk of churn
- Understand revenue contribution by segment 
- Make retention desicions based on behaviour 

## Tech Stack
- SQL
- [BigQuery](https://cloud.google.com/bigquery)  
- [Looker Studio](https://lookerstudio.google.com/)  
- [VS Code](https://code.visualstudio.com/)  
- [GitHub](https://github.com/)  
- [Lucidchart](https://www.lucidchart.com/)

## Dataset & Environment Setup

# Folder 01_data 

Source: TheLook E-commerce dataset (Kaggle) https://www.kaggle.com/datasets/daichiuchigashima/thelook-ecommerce

Start here to see overview of data structure 

All modelling tables were created within the same dataset location (europe-west2) to avoid cross-region query issues and ensure consistent performance.

## Data Cleaning

# Folder 02_notebook 

Written notes of exploration

## Data Modelling - Star Schema 

# Folder 03_datamodelling 

The model follows a star schema design.

The fact table (fact_sales) 

Dimension tables provide descriptive context:
- dim_users: customer demographics and region
- dim_products: product category and brand
- dim_date: time-based analysis support

## SQL Methodology

# 04_sql_scripts 

The project includes 
- CTES for structured transformations 
- JOINs between fact and dimension tables 
- Aggregations with GROUP BY 
- Window functions including:
-   NTILE () for RFM scoring 
- Customer segmentation logic using CASE statements

## RFM Methodology 

Recency: Days since last purchase (using dataset max date)

Frequency: Total number of completed orders

Monetary: Total revenue per customer

Customers are scored 1 to 5 using NTILE(5) and grouped into segments such as:

High Value, Loyal, At Risk, Churn Risk, New Customer

## Dashboard Overview 

# 05_dashboard

The dashboard structure: 
- Summary KPIs 
- Revenue and Customer trends 
- Location trends 

The customer_insights analytics model serves as the single source of truth for all visualisations.

[CLV Analysis Dashboard](https://lookerstudio.google.com/s/l6p1in5kUrY)

## How to Reproduce This Project

1. Load the TheLook dataset into BigQuery (UK region).

2. Run transformation script:
04_sql_scripts/4.1_transformations/01_staging.sql

3. Create model tables following:
03_data_modelling/star_schema.md

4. Run analytical queries in order:

- 02_analysis.sql

- 03_join_validation.sql

- 04_rfm_analysis.sql

- 05_customer_insights.sql

5. Connect the final output table to Looker Studio to replicate the dashboard.
