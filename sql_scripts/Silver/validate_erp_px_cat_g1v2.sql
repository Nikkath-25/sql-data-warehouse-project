#Check for unwanted spaces
SELECT 
cat,
subcat,
maintenance
FROM silver_layer.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance);

#Data Normalization & Standardization
select distinct
cat
from silver_layer.erp_px_cat_g1v2;

select distinct
subcat
from silver_layer.erp_px_cat_g1v2;

select distinct
maintenance
from silver_layer.erp_px_cat_g1v2;

#final check
select * from silver_layer.erp_px_cat_g1v2;