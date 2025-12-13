INSERT INTO silver_layer.erp_loc_a101
(
cid,
cntry
)
select 
REPLACE(cid,'-','') as cid,
CASE WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
WHEN UPPER(TRIM(cntry)) IN('US', 'USA') THEN 'United States of America'
WHEN UPPER(TRIM(cntry)) = '' or cntry IS NULL THEN 'n/a'
ELSE TRIM(cntry)
END AS cntry
FROM bronze_layer.erp_loc_a101;