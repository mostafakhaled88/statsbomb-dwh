/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'StatsBombDWH' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'StatsBombDWH' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'StatsBombDWH')
BEGIN
    ALTER DATABASE StatsBombDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StatsBombDWH;  
END;
GO

-- Create the 'StatsBombDWH' database 
CREATE DATABASE StatsBombDWH;  
GO
USE StatsBombDWH;
GO  
CREATE SCHEMA bronze; -- raw landing
CREATE SCHEMA silver; -- cleaned & normalized
CREATE SCHEMA gold;   -- analytics/star schema
CREATE SCHEMA logs;   -- ETL logs & audits
GO
