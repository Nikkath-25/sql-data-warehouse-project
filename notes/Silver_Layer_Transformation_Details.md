## 🧪 Silver Layer Transformations

### Table: crm_cust_info
1. Removed unwanted spaces by trimming first name and last name.  
2. Standardized values using `CASE WHEN` for marital status and gender.  
3. Replaced `NULL` or blank values with `Not Applicable`.  
4. Removed duplicates by retaining the most relevant row per customer.

### Table: crm_prd_info
1. Derived new columns based on existing ones.  
2. Normalized `product_line` and handled missing data as `N/A`.  
3. Applied data type casting where required.  
4. Performed data enrichment to enhance analysis.

### Table: crm_sales_details
1. Handled invalid or missing data for order date, ship date, and due date.  
2. Derived missing or invalid sales values from quantity × price.  
3. Corrected missing or zero prices using sales ÷ quantity calculations.

### Table: erp_cust_az12
1. Removed invalid characters from `cid` using `SUBSTRING`.  
2. Fixed invalid birth dates in `bdate` column.  
3. Normalized gender values and handled missing data.

### Table: erp_loc_a101
1. Removed minus (`-`) characters using `REPLACE`.  
2. Normalized country codes to user-friendly values.  
3. Replaced empty strings and `NULL` with `Not Applicable`.  
4. Trimmed unwanted spaces for consistency.

### Table: er_px_cat_g1v2
1. Verified all columns.  
2. No transformations required as data quality was already correct.

---