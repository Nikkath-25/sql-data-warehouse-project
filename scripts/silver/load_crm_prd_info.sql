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
-- Loading CRM Table: crm_prd_info
-- =====================================================================================

TRUNCATE TABLE silver_layer.crm_prd_info;

INSERT INTO silver_layer.crm_prd_info
(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
SELECT 
prd_id,
replace(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,length(prd_key)) as prd_key,
prd_nm,
prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - interval 1 DAY AS DATE) AS prd_end_dt
FROM bronze_layer.crm_prd_info;
