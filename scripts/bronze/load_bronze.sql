/*
========================================================================================
Load Bronze Layer (Source System -> Bronze)
========================================================================================
Script Purpose:
	This script performs the EL (Extract, Load) process to populate the 'bronze_layer'
    database tables from the Source System. 
Actions Performed:
	- Truncate bronze_layer tables.
    - Loads data from the Source System(CRM & ERP) CSV files into bronze_layer tables.
========================================================================================
*/

use bronze_layer;

-- =====================================================================================
-- Loading CRM Tables
-- =====================================================================================

truncate table crm_cust_info;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.crm_cust_info.csv'
into table crm_cust_info
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

truncate table crm_prd_info;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.crm_prd_info.csv'
into table crm_prd_info
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

truncate table crm_sales_details;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.crm_sales_details.csv'
into table crm_sales_details
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows; 

#Load numeric columns as NULL when blank, to preserve raw data and handle missing values in transformations
TRUNCATE TABLE crm_sales_details;
LOAD DATA LOCAL INFILE 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.crm_sales_details.csv'
INTO TABLE crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    @sls_sales,
    @sls_quantity,
    @sls_price
)
SET
    sls_sales = NULLIF(@sls_sales,''),
    sls_quantity = NULLIF(@sls_quantity,''),
    sls_price = NULLIF(@sls_price,'');
  
-- =====================================================================================
-- Loading ERP Tables
-- =====================================================================================

truncate table erp_cust_az12;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.erp_cust_az12.csv'
into table erp_cust_az12
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

truncate table erp_loc_a101;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.erp_loc_a101.csv'
into table erp_loc_a101
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

truncate table erp_px_cat_g1v2;
load data local infile 'C:/Data Analyst/Projects/Bronze_Silver_Gold_ETL_Project/data/bronze.erp_px_cat_g1v2.csv'
into table erp_px_cat_g1v2
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows; 