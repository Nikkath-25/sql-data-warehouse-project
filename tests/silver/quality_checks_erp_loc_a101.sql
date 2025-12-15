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
-- Checking 'silver_layer.erp_loc_a101'
-- ============================================================================================

SELECT 
REPLACE(cid,'-','') as cid,
cntry
FROM silver_layer.erp_loc_a101
where REPLACE(cid,'-','') NOT IN
(select cst_key from silver_layer.crm_cust_info);

-- Data Standardization & Consistency

select distinct
cntry from silver_layer.erp_loc_a101;

-- Final check 

select * from silver_layer.erp_loc_a101;