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
-- Checking 'silver_layer.crm_prd_info'
-- ============================================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Result

select
prd_id,
count(*)
from silver_layer.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null or prd_id=0; 

-- Check for Unwanted Spaces
-- Expectation: No Result

select prd_nm
from silver_layer.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Numbers
-- Expectation:No Result

select 
prd_cost
from silver_layer.crm_prd_info
where prd_cost < 0 or prd_cost is null;

-- Data Normalization & Standardization

select distinct prd_line
from silver_layer.crm_prd_info;

-- Check for Invalid Date orders

select 
*
from silver_layer.crm_prd_info
where prd_end_dt < prd_start_dt;

-- Final check 

select * from silver_layer.crm_prd_info;