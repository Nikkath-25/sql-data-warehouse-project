#Check for Unwanted Spaces
select sls_ord_num
from silver_layer.crm_sales_details
where sls_ord_num!=TRIM(sls_ord_num);

select sls_prd_key
from silver_layer.crm_sales_details
where sls_prd_key!=TRIM(sls_prd_key);

#prdouct key & customer id are keys that connect with other tables, 
#so we need to check the integrity of those columns

select sls_prd_key
from silver_layer.crm_sales_details
where sls_prd_key NOT IN (select prd_key from silver_layer.crm_prd_info);

select sls_cust_id
from silver_layer.crm_sales_details
where sls_cust_id NOT IN (select cst_id from silver_layer.crm_cust_info);

#Invalid Date Orders
#Order Date should be earlier than Ship Date and Due Date
select 
* 
from silver_layer.crm_sales_details
where sls_order_dt > sls_ship_dt 
or sls_order_dt > sls_due_dt
or sls_ship_dt > sls_due_dt;

#Check Data Consistency : Between Sales, Quantity & Price 
#Sales = Quantity * Price
#Negatives,Zeros,NULLs are Not Allowed

select distinct
sls_sales,
sls_quantity,
sls_price
from silver_layer.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales <= 0 or sls_quantity <= 0 or sls_price <= 0
or sls_sales IS NULL or sls_quantity IS NULL or sls_price IS NULL
order by sls_sales,sls_quantity,sls_price;

#Final check 
select * from silver_layer.crm_sales_details;

