/*
===============================================================================================
Quality Checks
===============================================================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy, and 
    standardization across the 'silver_layer' database. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields. 
    - Data standardization and consistency. 
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
	- Run these checks after data loading silver_layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================================
*/

-- ============================================================================================
-- Checking 'silver_layer.erp_px_cat_g1v2'
-- ============================================================================================

-- Check for unwanted spaces

SELECT 
cat,
subcat,
maintenance
FROM silver_layer.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance);

-- Data Normalization & Standardization

select distinct
cat
from silver_layer.erp_px_cat_g1v2;

select distinct
subcat
from silver_layer.erp_px_cat_g1v2;

select distinct
maintenance
from silver_layer.erp_px_cat_g1v2;

-- Final check
select * from silver_layer.erp_px_cat_g1v2;