/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'StatsbombDWH' after checking if it already exists. 
    If the database exists, it is dropped and recreated. 
    It then creates three schemas inside it: 'bronze', 'silver', and 'gold'.
    
WARNING:
    Running this script will DROP the entire 'StatsbombDWH' database if it exists. 
    All existing data will be permanently deleted.
=============================================================
*/

USE master;
GO

-- Drop and recreate the 'StatsbombDWH' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'StatsbombDWH')
BEGIN
    PRINT '⚠️ Database StatsbombDWH already exists. Dropping it...';
    ALTER DATABASE StatsbombDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE StatsbombDWH;
    PRINT '✅ Old database dropped successfully.';
END;
GO

-- Create the 'StatsbombDWH' database
PRINT '🆕 Creating new database: StatsbombDWH...';
CREATE DATABASE StatsbombDWH;
GO

-- Switch to the new database
USE StatsbombDWH;
GO

-- Create Schemas
PRINT '🏗️ Creating schemas (bronze, silver, gold)...';
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

PRINT '✅ Database and schemas created successfully!';
