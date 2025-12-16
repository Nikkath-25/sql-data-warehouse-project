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
-- Loading CRM Table: erp_px_cat_g1v2
-- =====================================================================================

TRUNCATE TABLE silver_layer.erp_px_cat_g1v2;

INSERT INTO silver_layer.erp_px_cat_g1v2
( 
id,
cat,
subcat,
maintenance
)
select
id,
cat,
subcat,
maintenance
from bronze_layer.erp_px_cat_g1v2;
