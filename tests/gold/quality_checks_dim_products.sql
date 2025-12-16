select * from gold_layer.dim_products;

select prd_key,
count(*)
from
(
	select 
	pi.prd_id,
	pi.cat_id,
	pi.prd_key,
	pi.prd_nm,
	pi.prd_cost,
	pi.prd_line,
	pi.prd_start_dt,
	pi.prd_end_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
	from silver_layer.crm_prd_info pi
	left join silver_layer.erp_px_cat_g1v2 pc
	on pi.cat_id = pc.id
	where prd_end_dt is null -- filter out all historical data
)t group by prd_key
having count(*) > 1;