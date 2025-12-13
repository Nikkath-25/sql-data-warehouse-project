📊 Bronze–Silver–Gold ETL Data Warehouse Project (MySQL)

📌 Project Overview

This project simulates a real-world data warehousing and ETL process using a Bronze–Silver–Gold architecture.

Demonstrates data cleaning, transformation, and aggregation from raw CSVs to business-ready tables.

Raw CRM and ERP data is ingested from CSV files, cleaned and standardized in multiple layers, and prepared for analytical reporting.

Key goals:

Data ingestion and validation

Data cleaning and transformation

Layered data modeling

SQL best practices

Version control using Git

📂 Project Structure (with clickable links)

🥉 Bronze Layer (Raw Data)

create_bronze_tables.sql
 → DDL scripts for all 6 tables

load_bronze_data.sql
 → Load CSV data into Bronze tables

Validation scripts for each table:

validate_crm_cust_info.sql

validate_crm_prd_info.sql

validate_crm_sales_details.sql

validate_erp_cust_az12.sql

validate_erp_loc_a101.sql

validate_er_px_cat_g1v2.sql

🥈 Silver Layer (Cleaned & Standardized)

create_silver_tables.sql
 → DDL scripts for Silver tables

Transformations for each table:

silver_transform_crm_cust_info.sql

silver_transform_crm_prd_info.sql

silver_transform_crm_sales_details.sql

silver_transform_erp_cust_az12.sql

silver_transform_erp_loc_a101.sql

silver_transform_er_px_cat_g1v2.sql

Validation scripts for each table:

validate_crm_cust_info.sql

validate_crm_prd_info.sql

validate_crm_sales_details.sql

validate_erp_cust_az12.sql

validate_erp_loc_a101.sql

validate_er_px_cat_g1v2.sql


🧪 Silver Layer Transformations

Table: crm_cust_info

Removed unwanted spaces by trimming first name and last name.

Standardized values using CASE WHEN for marital status and gender.

Replaced NULL or blank values with Not Applicable.

Removed duplicates by retaining the most relevant row per customer.

Table: crm_prd_info

Derived new columns based on existing ones.

Normalized product_line and handled missing data as N/A.

Applied data type casting where required.

Performed data enrichment to enhance analysis.

Table: crm_sales_details

Handled invalid or missing data for order date, ship date, and due date.

Derived missing or invalid sales values from quantity × price.

Corrected missing or zero prices using sales ÷ quantity calculations.

Table: erp_cust_az12

Removed invalid characters from cid using SUBSTRING.

Fixed invalid birth dates in bdate column.

Normalized gender values and handled missing data.

Table: erp_loc_a101

Removed minus (-) characters using REPLACE.

Normalized country codes to user-friendly values.

Replaced empty strings and NULL with Not Applicable.

Trimmed unwanted spaces for consistency.

Table: er_px_cat_g1v2

Verified all columns.

No transformations required as data quality was already correct.

🛠️ Technologies Used

MySQL 8.0 (DDL, DML, window functions, transformations)

Git & GitHub

VS Code (SQL scripts & CSV exploration)

Draw.io (Data flow diagram)

🚧 Current Status

✅ Bronze Layer completed

✅ Silver Layer completed

🚧 Gold Layer in progress (fact/dimension tables and joins pending)

📈 Next Steps

Complete Gold layer with analytical tables.

Implement joins between customer, product, and sales data.

Add additional validations if required.

Update README and diagrams once Gold layer is done.
