/*
========================================================================================
Load Silver Layer (Silver -> Bronze)
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
-- Loading CRM Table: crm_cust_info
-- =====================================================================================

TRUNCATE TABLE silver_layer.crm_cust_info;

INSERT INTO silver_layer.crm_cust_info
(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)
select
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,

CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
WHEN UPPER(TRIM(cst_marital_status))= 'S' THEN 'Single'
ELSE 'n/a'
END AS cst_marital_status,

CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
ELSE'n/a'
END AS cst_gndr,

cst_create_date
from(
select 
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
 from bronze_layer.crm_cust_info
 where cst_id is NOT NULL AND cst_id != 0
 )t where flag_last = 1;
 
 
