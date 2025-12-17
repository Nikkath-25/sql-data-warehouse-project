/*
===============================================================================
Quality checks
===============================================================================
Script Purpose:
	This script performs quality checks to validate the integrity,consistency,
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relations in the data model for analytical purposes.alter
    
Usage Notes:
	- Run these checks after data loading Gold Layer.
    - Investigate and resolve any discrepancies found during the checks.
================================================================================
*/

-- =================================================================
-- Checking 'gold_layer.dim_customers'
-- =================================================================
-- Check for Uniqueness of Customer Key in gold_layer.dim_customers
-- Expectation: No results

select 
customer_key,
count(*) as duplicate_count
from gold_layer.dim_customers
group by customer_key
having count(*) >1;

-- Data Standardization & Consistency

select distinct
gender
from gold_layer.dim_customers;

