/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
DROP VIEW IF EXISTS gold.dim_customers;

CREATE VIEW gold.dim_customers as
SELECT
 ROW_NUMBER() OVER(ORDER BY cst_id) as customer_key,
 ci.cst_id as customer_id,
 ci.cst_key as customer_number,
 ci.cst_firstname as first_name,
 ci.cst_lastname as last_name,
 ca.bdate as birth_date,
 ci.cst_marital_status as marital_status,
 case when ci.cst_gndr != 'n/a' then ci.cst_gndr
      else coalesce(ca.gen, 'n/a')
 end as gender,
 la.cntry as country,
 ci.cst_create_date as create_date
 
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
     ON ci.cst_key=ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
     ON ci.cst_key=la.cid

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
DROP VIEW IF EXISTS gold.dim_product;   

CREATE VIEW gold.dim_product as
SELECT
 ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt, pi.prd_key) as product_key,
 pi.prd_id as product_id,
 pi.prd_key as product_number,
 pi.prd_nm as pproduct_name,
 pi.prd_cost as cost,
 pi.prd_line as product_line,
 pi.cat_id as category_id,
 pc.cat as category,
 pc.subcat as sub_category,
 pc.maintenance ,
 pi.prd_start_dt as start_date,
 pi.prd_end_dt as end_date
FROM silver.crm_prd_info AS pi
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pi.cat_id=pc.id
WHERE pi.prd_end_dt IS NULL

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
DROP VIEW IF EXISTS gold.fact_sales;
    
CREATE VIEW gold.fact_sales as
SELECT 
 sd.sls_ord_num as order_number,
 pr.product_key,
 cu.customer_key,
 sd.sls_order_dt as order_date,
 sd.sls_ship_dt as shipping_date,
 sd.sls_due_dt as due_date,
 sd.sls_sales as sales ,
 sd.sls_quantity as quantity,
 sd.sls_price as price
FROM  silver.crm_sales_details AS sd
LEFT JOIN gold.dim_product AS pr
 on sd.sls_prd_key=pr.product_number
LEFT JOIN gold.dim_customers AS cu
 on sd.sls_cust_id=cu.customer_id
