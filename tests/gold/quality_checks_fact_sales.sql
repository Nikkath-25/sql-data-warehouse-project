select * from gold_layer.fact_sales;

-- Foreign Key Integrity (Dimensions)

select * 
from gold_layer.fact_sales f
left join gold_layer.dim_customers c
on c.customer_key = f.customer_key
left join gold_layer.dim_products p
on p.product_key = f.product_key
-- where c.customer_key is null
where p.product_key is null;
