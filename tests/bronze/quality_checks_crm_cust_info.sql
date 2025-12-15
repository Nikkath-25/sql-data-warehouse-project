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
-- Checking 'bronze_layer.crm_cust_info'
-- ============================================================================================
    
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Result

select
cst_id,
count(*)
from bronze_layer.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null or cst_id=0; 

-- Check for Unwanted Spaces
-- Expectation: No Result

select cst_key
from bronze_layer.crm_cust_info
WHERE cst_key != TRIM(cst_key);

select cst_firstname
from bronze_layer.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

select cst_lastname
from bronze_layer.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname); 

select cst_gndr
from bronze_layer.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Data Standardization & Consistency

select DISTINCT cst_gndr
from bronze_layer.crm_cust_info;

select DISTINCT cst_marital_status
from bronze_layer.crm_cust_info;
