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
-- Checking 'silver_layer.erp_cust_az12'
-- ============================================================================================

SELECT 
cid
FROM silver_layer.erp_cust_az12
where cid LIKE '%AW00011002%'; 

-- Integrity of columns 

select 
cid,
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END AS cid,
bdate,
gen
from silver_layer.erp_cust_az12
where CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END NOT IN (select cst_key from silver_layer.crm_cust_info);

-- Identify Out-of Range Dates

select distinct
bdate
from silver_layer.erp_cust_az12
where bdate > now();

-- Data Standardization & Consistency
select distinct gen
from silver_layer.erp_cust_az12;

-- Final check
select * from silver_layer.erp_cust_az12;