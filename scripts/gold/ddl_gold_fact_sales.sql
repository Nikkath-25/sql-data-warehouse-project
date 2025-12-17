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
-- Create Dimension: gold_layer.fact_sales
-- ===================================================================================

DROP VIEW IF EXISTS gold_layer.fact_sales;

create view gold_layer.fact_sales as
select 
sd.sls_ord_num as order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver_layer.crm_sales_details sd
left join gold_layer.dim_products pr
on sd.sls_prd_key = pr.product_number
left join gold_layer.dim_customers cu
on sd.sls_cust_id = cu.customer_id;