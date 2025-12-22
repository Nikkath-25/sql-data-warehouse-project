🧪 Silver Layer Transformations

Table: crm_cust_info
Removed unwanted spaces by trimming first name and last name.
Standardized values using CASE WHEN for marital status and gender.
Replaced NULL or blank values with Not Applicable.
Removed duplicates by retaining the most relevant row per customer.

Table: crm_prd_info
Derived new columns based on existing ones.
Normalized product_line and handled missing data as N/A.
Applied data type casting where required.
Performed data enrichment to enhance analysis.

Table: crm_sales_details
Handled invalid or missing data for order date, ship date, and due date.
Derived missing or invalid sales values from quantity × price.
Corrected missing or zero prices using sales ÷ quantity calculations.

Table: erp_cust_az12
Removed invalid characters from cid using SUBSTRING.
Fixed invalid birth dates in bdate column.
Normalized gender values and handled missing data.

Table: erp_loc_a101
Removed minus (-) characters using REPLACE.
Normalized country codes to user-friendly values.
Replaced empty strings and NULL with Not Applicable.
Trimmed unwanted spaces for consistency.

Table: er_px_cat_g1v2
Verified all columns.
No transformations required as data quality was already correct.