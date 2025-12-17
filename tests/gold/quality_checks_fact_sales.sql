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

-- Check the data model connectivity between fact and dimensions
-- Foreign Key Integrity (Dimensions)

select * 
from gold_layer.fact_sales f
left join gold_layer.dim_customers c
on c.customer_key = f.customer_key
left join gold_layer.dim_products p
on p.product_key = f.product_key
where p.product_key is null or c.customer_key is null;
