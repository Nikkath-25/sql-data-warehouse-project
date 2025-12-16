select * from gold_layer.dim_customers;

-- Data Standardization & Consistency

select distinct
gender
from gold_layer.dim_customers;

SELECT
cst_id,
count(*)
FROM
(
	SELECT 
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		ci.cst_marital_status,
		ci.cst_gndr,
		ci.cst_create_date,
		ca.bdate,
		ca.gen,
		la.cntry
	FROM silver_layer.crm_cust_info ci
	LEFT JOIN silver_layer.erp_cust_az12 ca
	ON ci.cst_key = ca.cid
	LEFT JOIN silver_layer.erp_loc_a101 la
	ON ci.cst_key = la.cid
)t GROUP BY cst_id
HAVING count(*) > 1;

SELECT DISTINCT
	ci.cst_gndr,
	ca.gen,
    CASE WHEN ci.cst_gndr!= 'n/a'
    THEN ci.cst_gndr
    ELSE COALESCE(ca.gen,'n/a')
    END AS new_gen
FROM silver_layer.crm_cust_info ci
LEFT JOIN silver_layer.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver_layer.erp_loc_a101 la
ON ci.cst_key = la.cid
ORDER BY 1,2;