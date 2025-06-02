/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'datawarehouse'. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
*/

-- Create the 'datawarehouse' database
CREATE DATABASE datawarehouse;

-- change database connection to datawarehouse 
-- Postgres doesn't supports "USE database_name;"

-- Create Schemas
CREATE SCHEMA bronze;

CREATE SCHEMA silver;

CREATE SCHEMA gold;
