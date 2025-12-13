# 📊 Bronze–Silver–Gold ETL Data Warehouse Project (MySQL)

## 📌 Project Overview
This project simulates a **real-world data warehousing and ETL process** using a **Bronze–Silver–Gold architecture**. 

Demonstrates data cleaning, transformation, and aggregation from raw CSVs to business-ready tables.

Raw CRM and ERP data is ingested from CSV files, cleaned and standardized in multiple layers, and prepared for analytical reporting.

**Key goals:**
- Data ingestion and validation
- Data cleaning and transformation
- Layered data modeling
- SQL best practices
- Version control using Git

---

## Project Structure

- **data**
  - [crm_cust_info.csv](data/crm_cust_info.csv)
  - [crm_prd_info.csv](data/crm_prd_info.csv)
  - [crm_sales_details.csv](data/crm_sales_details.csv)
  - [erp_cust_az12.csv](data/erp_cust_az12.csv)
  - [erp_loc_a101.csv](data/erp_loc_a101.csv)
  - [er_px_cat_g1v2.csv](data/er_px_cat_g1v2.csv)

- **sql_scripts**
  - **bronze**
    - [create_bronze_tables.sql](sql_scripts/bronze/create_bronze_tables.sql)
    - [load_bronze_data.sql](sql_scripts/bronze/load_bronze_data.sql)
    - ...
  - **silver**
    - [create_silver_tables.sql](sql_scripts/silver/create_silver_tables.sql)
    - ...
  - **gold**
    - (in progress)

- **diagrams**
  - [data_flow_diagram.drawio](diagrams/data_flow_diagram.drawio)
  - [data_flow_diagram.png](diagrams/data_flow_diagram.png)

- [README.md](README.md)

---

## 🧪 Silver Layer Transformations

### Table: crm_cust_info
1. Removed unwanted spaces by trimming first name and last name.  
2. Standardized values using `CASE WHEN` for marital status and gender.  
3. Replaced `NULL` or blank values with `Not Applicable`.  
4. Removed duplicates by retaining the most relevant row per customer.

### Table: crm_prd_info
1. Derived new columns based on existing ones.  
2. Normalized `product_line` and handled missing data as `N/A`.  
3. Applied data type casting where required.  
4. Performed data enrichment to enhance analysis.

### Table: crm_sales_details
1. Handled invalid or missing data for order date, ship date, and due date.  
2. Derived missing or invalid sales values from quantity × price.  
3. Corrected missing or zero prices using sales ÷ quantity calculations.

### Table: erp_cust_az12
1. Removed invalid characters from `cid` using `SUBSTRING`.  
2. Fixed invalid birth dates in `bdate` column.  
3. Normalized gender values and handled missing data.

### Table: erp_loc_a101
1. Removed minus (`-`) characters using `REPLACE`.  
2. Normalized country codes to user-friendly values.  
3. Replaced empty strings and `NULL` with `Not Applicable`.  
4. Trimmed unwanted spaces for consistency.

### Table: er_px_cat_g1v2
1. Verified all columns.  
2. No transformations required as data quality was already correct.

---

## 🛠️ Technologies Used
- MySQL 8.0 (DDL, DML, window functions, transformations)  
- Git & GitHub  
- VS Code (SQL scripts & CSV exploration)  
- Draw.io (Data flow diagram)

---

## 🚧 Current Status
- ✅ Bronze Layer completed  
- ✅ Silver Layer completed  
- 🚧 Gold Layer in progress (fact/dimension tables and joins pending)  

---

## 📈 Next Steps
1. Complete Gold layer with analytical tables.  
2. Implement joins between customer, product, and sales data.  
3. Add additional validations if required.  
4. Update README and diagrams once Gold layer is done.  
