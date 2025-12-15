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
-- Checking 'bronze_layer.erp_cust_az12'
-- ============================================================================================

SELECT 
cid
FROM bronze_layer.erp_cust_az12
where cid LIKE '%AW00011002%'; 

select 
cid,
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END AS cid,
bdate,
gen
from bronze_layer.erp_cust_az12
where CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END NOT IN (select cst_key from silver_layer.crm_cust_info);

-- Identify Out-of Range Dates

select distinct
bdate
from bronze_layer.erp_cust_az12
where bdate < '19240101' or bdate > now();

-- Data Standardization & Consistency

select distinct gen
from bronze_layer.erp_cust_az12;