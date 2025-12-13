TRUNCATE TABLE silver_layer.erp_px_cat_g1v2;

INSERT INTO silver_layer.erp_px_cat_g1v2
( 
id,
cat,
subcat,
maintenance
)
select
id,
cat,
subcat,
maintenance
from bronze_layer.erp_px_cat_g1v2;
