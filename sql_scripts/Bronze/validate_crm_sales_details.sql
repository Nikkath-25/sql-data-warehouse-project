#Check for Unwanted Spaces
select sls_ord_num
from bronze_layer.crm_sales_details
where sls_ord_num!=TRIM(sls_ord_num);

select sls_prd_key
from bronze_layer.crm_sales_details
where sls_prd_key!=TRIM(sls_prd_key);

#prdouct key & customer id are keys that connect with other tables, 
#so we need to check the integrity of those columns

select sls_prd_key
from bronze_layer.crm_sales_details
where sls_prd_key NOT IN (select prd_key from silver_layer.crm_prd_info);

select sls_cust_id
from bronze_layer.crm_sales_details
where sls_cust_id NOT IN (select cst_id from silver_layer.crm_cust_info);

#Check for Invalid Dates
select 
sls_order_dt
from bronze_layer.crm_sales_details
where sls_order_dt <= 0 
or length(sls_order_dt) != 8 #here 8 is the length of date 20121201=8
or sls_order_dt >20500101 #check for outliers by validating the boundaries of the date range
or sls_order_dt < 19000101; #check for outliers by validating the boundaries of the date range

select 
sls_ship_dt
from bronze_layer.crm_sales_details
where sls_ship_dt <= 0 
or length(sls_ship_dt) != 8
or sls_ship_dt > 20500101
or sls_ship_dt < 19000101; 

select 
sls_due_dt
from bronze_layer.crm_sales_details
where sls_due_dt <= 0 
or length(sls_due_dt) != 8
or sls_due_dt > 20500101
or sls_due_dt < 19000101; 

#Invalid Date Orders
#Order Date should be earlier than Ship Date and Due Date
select 
* 
from bronze_layer.crm_sales_details
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
from bronze_layer.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales <= 0 or sls_quantity <= 0 or sls_price <= 0
or sls_sales IS NULL or sls_quantity IS NULL or sls_price IS NULL
order by sls_sales,sls_quantity,sls_price;
#here we need to talk to source system about the bad data and ask for support and rules.
#Rules:
#1. If Sales is negative,zero, or null derive it using Quantity and Price
#2. If Price is zero or null, calculate it using Sales and Quantity
#3. If Price is negative, convert it to a positive value

select distinct
sls_sales as old_sls_sales ,
sls_quantity,
sls_price as old_sls_price,
CASE WHEN sls_sales IS NULL or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
THEN sls_quantity * abs(sls_price)
ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL or sls_price <= 0 
THEN CAST(sls_sales / NULLIF(sls_quantity,0) AS UNSIGNED)
ELSE sls_price
END AS sls_price
from bronze_layer.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales <= 0 or sls_quantity <= 0 or sls_price <= 0
or sls_sales IS NULL or sls_quantity IS NULL or sls_price IS NULL
order by sls_sales,sls_quantity,sls_price;
