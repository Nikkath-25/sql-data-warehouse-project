SELECT 
cid,
cntry
FROM bronze_layer.erp_loc_a101
where cid NOT IN
(select cst_key from silver_layer.crm_cust_info);

SELECT 
REPLACE(cid,'-','') as cid,
cntry
FROM bronze_layer.erp_loc_a101
where REPLACE(cid,'-','') NOT IN
(select cst_key from silver_layer.crm_cust_info);

#Data Standardization & Consistency
select distinct
cntry from bronze_layer.erp_loc_a101;