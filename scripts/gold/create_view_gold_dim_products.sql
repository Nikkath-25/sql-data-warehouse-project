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


