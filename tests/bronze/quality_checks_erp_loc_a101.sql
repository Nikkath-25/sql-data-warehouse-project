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
-- Checking 'bronze_layer.erp_loc_a101'
-- ============================================================================================

SELECT 
cid,
cntry
FROM bronze_layer.erp_loc_a101
where cid NOT IN
(select cst_key from silver_layer.crm_cust_info);

SELECT 
REPLACE(cid,'-','') as cid,
cntry
FROM bronze_layer.erp_loc_a101
where REPLACE(cid,'-','') NOT IN
(select cst_key from silver_layer.crm_cust_info);

-- Data Standardization & Consistency
select distinct
cntry from bronze_layer.erp_loc_a101;