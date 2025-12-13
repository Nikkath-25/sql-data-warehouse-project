SELECT 
cid
FROM silver_layer.erp_cust_az12
where cid LIKE '%AW00011002%'; 

#integrity of columns 
select 
cid,
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END AS cid,
bdate,
gen
from silver_layer.erp_cust_az12
where CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,length(cid))
ELSE cid
END NOT IN (select cst_key from silver_layer.crm_cust_info);

# Identify Out-of Range Dates
select distinct
bdate
from silver_layer.erp_cust_az12
where bdate > now();

#Data Standardization & Consistency
select distinct gen
from silver_layer.erp_cust_az12;