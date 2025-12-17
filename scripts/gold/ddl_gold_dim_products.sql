/*
=====================================================================================
DDL Script: Create Gold Views
=====================================================================================
Script Purpose:
	This script creates views for the Gold Layer in the data warehouse .
    The Gold Layer represents the final dimension and fact tables (Star Schema)
    
    Each view performs transformations and combines data from the Silver Layer
    to produce a clean,enriched, and business-ready dataset.
    
Usage:
	- These views can be queried directly for analytics and reporting.
======================================================================================
*/

-- ===================================================================================
-- Create Dimension: gold_layer.dim_products
-- ===================================================================================

DROP VIEW IF EXISTS gold_layer.dim_products;

create view gold_layer.dim_products as 
select
ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt, pi.prd_key) AS product_key, 
pi.prd_id as product_id,
pi.prd_key as product_number,
pi.prd_nm as product_name,
pi.cat_id as category_id,
pc.cat as category,
pc.subcat as subcategory,
pc.maintenance,
pi.prd_cost as cost,
pi.prd_line as product_line,
pi.prd_start_dt as start_date
from silver_layer.crm_prd_info pi
left join silver_layer.erp_px_cat_g1v2 pc
on pi.cat_id = pc.id
where prd_end_dt is null; -- filter out all historical data


