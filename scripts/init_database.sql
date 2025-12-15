/*
==================================
Create Databases
==================================
Script Purpose:
   This script creates three new databases named 'bronze_layer','silver_layer' and 'gold_layer'.
   If the database exists, it is dropped and recreated.

WARNING:
   Running this script will drop the entire Database if it exists.
   All data in the database will be permanently deleted. 
   Proceed with caution and ensure you have proper backups before running this script. 
*/
   
-- ===============================
-- Bronze Layer
-- ===============================
DROP DATABASE IF EXISTS bronze_layer;
CREATE DATABASE bronze_layer;
USE bronze_layer;

-- ===============================
-- Silver Layer
-- ===============================
DROP DATABASE IF EXISTS silver_layer;
CREATE DATABASE silver_layer;
USE silver_layer;

-- ===============================
-- Gold Layer
-- ===============================
DROP DATABASE IF EXISTS gold_layer;
CREATE DATABASE gold_layer;
USE gold_layer;