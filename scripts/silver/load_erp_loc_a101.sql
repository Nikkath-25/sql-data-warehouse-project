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
-- Loading CRM Table: erp_loc_a101
-- =====================================================================================

TRUNCATE TABLE silver_layer.erp_loc_a101;

INSERT INTO silver_layer.erp_loc_a101
(
cid,
cntry
)
select 
REPLACE(cid,'-','') as cid,
CASE WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
WHEN UPPER(TRIM(cntry)) IN('US', 'USA') THEN 'United States'
WHEN UPPER(TRIM(cntry)) = '' or cntry IS NULL THEN 'n/a'
ELSE TRIM(cntry)
END AS cntry
FROM bronze_layer.erp_loc_a101;