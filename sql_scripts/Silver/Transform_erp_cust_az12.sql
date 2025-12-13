TRUNCATE TABLE silver_layer.erp_cust_az12;

INSERT INTO silver_layer.erp_cust_az12
(
cid,
bdate,
gen
)
select 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END AS cid,
CASE WHEN bdate > now() THEN null
ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
ELSE 'n/a'
END AS gen
from bronze_layer.erp_cust_az12;
