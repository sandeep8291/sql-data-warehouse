/*
======================================================================
🟢 BRONZE LAYER DATA LOAD SCRIPT FOR POSTGRESQL (Windows) or if u ini linux then build .sh or bash file

This script is designed to bulk load CSV data into the bronze layer 
of a PostgreSQL Data Warehouse using \COPY commands.

🚨 IMPORTANT:
- This script must be executed using the Windows `.bat`(run_bronze.bat) file provided.
- Do NOT run this directly in pgAdmin Query Tool — it will fail.
- `\COPY` commands only work in the `psql` terminal or via batch automation.

✅ HOW TO RUN:

1. Ensure PostgreSQL is installed and `psql` is added to the system PATH.
2. Make sure your CSV files are present in the correct paths.
3. Double-click the provided `.bat` file (e.g., run_bronze.bat)
   OR run from terminal:
      psql -U postgres -d datawarehouse -h localhost < path\to\copy_load.sql
4. Script will truncate tables, load CSVs, and show row counts.

Author: Sandeep Yadav
Last Updated: June 2025
======================================================================
*/




\echo '=================================================RUNNING=========================================================='
\echo 'Loading CRM Customer Info...'
TRUNCATE TABLE bronze.crm_cust_info;
\COPY bronze.crm_cust_info (cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT count(*) FROM bronze.crm_cust_info;



TRUNCATE TABLE bronze.crm_prd_info;
\COPY bronze.crm_prd_info (prd_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT COUNT(*) FROM bronze.crm_prd_info;


TRUNCATE TABLE bronze.crm_sales_details;
\COPY bronze.crm_sales_details (sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT COUNT(*) FROM bronze.crm_sales_details;

\echo 'Loading ERP Customer Info...'

TRUNCATE TABLE bronze.erp_cust_az12;
\COPY bronze.erp_cust_az12 (cid, bdate, gen) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT count(*) FROM bronze.erp_cust_az12;



TRUNCATE TABLE bronze.erp_loc_a101;
\COPY bronze.erp_loc_a101 (cid, cntry) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT COUNT(*) FROM bronze.erp_loc_a101;



TRUNCATE TABLE bronze.erp_px_cat_g1v2;
\COPY bronze.erp_px_cat_g1v2 (id, cat, subcat, maintenance) FROM 'C:\Users\sande\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
\echo '====================================================DONE==========================================================='

