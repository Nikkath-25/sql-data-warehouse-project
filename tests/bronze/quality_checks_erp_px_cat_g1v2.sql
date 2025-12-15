/*
===============================================================================================
Quality Checks
===============================================================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy, and 
    standardization across the 'bronze_layer' database. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields. 
    - Data standardization and consistency. 
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
	- Run these checks before transforming the data in silver_layer.
    - Use the results to guide the required transformations in the silver_layer.
===============================================================================================
*/

-- ============================================================================================
-- Checking 'bronze_layer.erp_px_cat_g1v2'
-- ============================================================================================

-- Check for unwanted spaces
SELECT 
cat,
subcat,
maintenance
FROM bronze_layer.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance);

-- Data Normalization & Standardization
select distinct
cat
from bronze_layer.erp_px_cat_g1v2;

select distinct
subcat
from bronze_layer.erp_px_cat_g1v2;

select distinct
maintenance
from bronze_layer.erp_px_cat_g1v2;
