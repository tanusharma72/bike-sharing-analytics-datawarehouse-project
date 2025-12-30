-- DROP DATABASE bikeworkspace
CREATE DATABASE bikeworkspace;
GO

USE bikeworkspace;
GO

-- Create Master Key for encryption
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Tanusha7248';

-- Create Database Scoped Credential for Storage Access
-- Remember to remove the '?' from the beginning of your SAS token
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sv=2024-11-04&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2026-01-04T18:33:44Z&st=2025-12-29T10:18:44Z&spr=https&sig=Q4A9Zqr39L3iqZteNLMRGJwx3MAX0a7IEK75dLN1rs0%3D';

-- Set up User and Permissions
CREATE USER Test FOR LOGIN sqladminuser;
GRANT REFERENCES ON DATABASE SCOPED CREDENTIAL::AzureStorageCredential TO Test;

-- Create External Data Source pointing to your Blob Storage
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'AzureStorage')
    CREATE EXTERNAL DATA SOURCE AzureStorage WITH (
        LOCATION = 'wasbs://bikecontainer@bikeaccount.blob.core.windows.net',
        CREDENTIAL = AzureStorageCredential
    );
GO

-- Create External File Formats
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat')
    CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat]
    WITH ( FORMAT_TYPE = Parquet )
GO

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'TextFileFormat')
    CREATE EXTERNAL FILE FORMAT TextFileFormat
    WITH ( 
        FORMAT_TYPE = DELIMITEDTEXT,
        FORMAT_OPTIONS (
            FIELD_TERMINATOR = ',',
            STRING_DELIMITER = '"',
            USE_TYPE_DEFAULT = FALSE
        )
    );
GO

-- Check External tables row counts
SELECT COUNT(1) as Count, 'STAGING_PAYMENT' as external_table from dbo.STAGING_PAYMENT
UNION
SELECT COUNT(1) as Count, 'STAGING_RIDER' as external_table from dbo.STAGING_RIDER
UNION
SELECT COUNT(1) as Count, 'STAGING_STATION' as external_table from dbo.STAGING_STATION
UNION
SELECT COUNT(1) as Count, 'STAGING_TRIP' as external_table from dbo.STAGING_TRIP
GO