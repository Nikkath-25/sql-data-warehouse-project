/*
========================================================================================
Load Silver Layer (Bronze -> Silver)
========================================================================================
Script Purpose:
	This script performs the ETL (Extract, Transform, Load) process to populate the 'silver_layer'
    database tables from the 'bronze_layer' database. 
Actions Performed:
	- Truncate silver_layer tables.
    - Inserts transformed and cleansed data from bronze into silver tables.
========================================================================================
*/

-- =====================================================================================
-- Loading CRM Table: crm_sales_details
-- =====================================================================================

TRUNCATE TABLE silver_layer.crm_sales_details;

INSERT INTO silver_layer.crm_sales_details
(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR length(sls_order_dt) !=8 THEN NULL
ELSE CAST(CAST(sls_order_dt AS CHAR(8)) AS DATE) 
END AS sls_ship_dt,
CASE WHEN sls_ship_dt = 0 OR length(sls_ship_dt) !=8 THEN NULL
ELSE CAST(CAST(sls_ship_dt AS CHAR(8)) AS DATE) 
END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR length(sls_due_dt) !=8 THEN NULL
ELSE CAST(CAST(sls_due_dt AS CHAR(8)) AS DATE) 
END AS sls_due_dt,
CASE WHEN sls_sales IS NULL or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
THEN sls_quantity * abs(sls_price)
ELSE sls_sales
END AS sls_sales,
sls_quantity, 
CASE WHEN sls_price IS NULL or sls_price <= 0 
THEN CAST(sls_sales / NULLIF(sls_quantity,0) AS UNSIGNED)
ELSE sls_price
END AS sls_price
from bronze_layer.crm_sales_details;
