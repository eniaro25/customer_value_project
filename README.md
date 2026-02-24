# Retail & E-commerce Customer Lifetime Value (CLV) Analysis

## Project Overview
This project analyses customer lifetime value (CLV) using the TheLook E-commerce dataset in BigQuery.

## Tech Stack
- BigQuery
- Looker Studio
- VSCode
- GitHub

## Dataset & Environment Setup

The analysis was conducted using Google BigQuery.

The dataset was stored and queried within a dedicated BigQuery project to ensure proper environment separation between raw and analytics layers.

All modelling tables were created within the same dataset location to avoid cross-region query issues and ensure consistent performance.

Project structure follows a layered approach:
- raw layer: original source tables
- analytics layer: cleaned staging and modelled tables

## Data Cleaning
Cancelled orders were excluded from revenue calculations to ensure accurate monetary metrics. Only transactions with status 'Complete' or 'Shipped' were included in the staging sales table. This ensures Customer Lifetime Value calculations are based on realised revenue rather than failed transactions.
Recency was calculated using the dataset’s maximum order date rather than the system date to avoid negative values caused by simulated future transactions.

## Star Schema Design
The model follows a star schema design.

The fact table (fact_sales) is built at the product-order level using the order_items table.

Dimension tables provide descriptive context:
- dim_users: customer demographics and region
- dim_products: product category and brand
- dim_date: time-based analysis support

This structure enables efficient aggregation for RFM segmentation and retention analysis.
The fact table was validated through join testing to confirm row counts were preserved and relationships between fact_sales and dim_users were correctly aligned.

## SQL Methodology

The project follows a layered SQL approach:

- Staging layer for cleaned transactional data
- Dimension tables for descriptive attributes
- Fact table for transactional metrics
- Analytical queries for RFM calculations

Window functions and CTEs are introduced progressively to support customer ranking and lifecycle analysis.