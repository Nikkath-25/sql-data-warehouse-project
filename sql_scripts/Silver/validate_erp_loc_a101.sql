SELECT 
REPLACE(cid,'-','') as cid,
cntry
FROM silver_layer.erp_loc_a101
where REPLACE(cid,'-','') NOT IN
(select cst_key from silver_layer.crm_cust_info);

#Data Standardization & Consistency
select distinct
cntry from silver_layer.erp_loc_a101;