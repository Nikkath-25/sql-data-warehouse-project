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
-- Checking 'bronze_layer.crm_prd_info'
-- ============================================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Result

select
prd_id,
count(*)
from bronze_layer.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null or prd_id=0; 

-- Check for Unwanted Spaces
-- Expectation: No Result

select prd_nm
from bronze_layer.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Numbers
-- Expectation:No Result

select 
prd_cost
from bronze_layer.crm_prd_info
where prd_cost < 0 or prd_cost is null;

-- Data Normalization & Standardization

select distinct prd_line
from bronze_layer.crm_prd_info;

-- Check for Invalid Date orders

select 
*
from bronze_layer.crm_prd_info
where prd_end_dt < prd_start_dt;

/*
to get the solution for this type of transformations,select two products and keep it in excel 
and try with different solutions 
1. switch start date and end date - but dates are overlapping and also start date cannot be null!
2. ignore completely the end date and derive the end date from start date 
end date = start date of the 'next' record and make sure its not overlapping with the start date of next record.
so, end date = start date of the 'next' record - 1
last record end date will be 'NULL' as there is no record next.
for this we have an amazing window function  LEAD()
*/

-- selecting 2 products to think of a solution
select 
prd_id,
prd_key,
prd_nm,
prd_start_dt,
prd_end_dt
from bronze_layer.crm_prd_info
where prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509');

-- solution
select 
prd_id,
prd_key,
prd_nm,
prd_start_dt,
LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - interval 1 day AS prd_end_dt
from bronze_layer.crm_prd_info
where prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509');
