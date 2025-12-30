
CREATE EXTERNAL TABLE dbo.STAGING_RIDER (
    [RIDER_ID] bigint,
    [FIRSTNAME] NVARCHAR(100),
    [LASTNAME] NVARCHAR(100),
    [ADDRESS] NVARCHAR(500),
    [BIRTHDAY] NVARCHAR(50),
    [ACCOUNT_START_DATE] NVARCHAR(50),
    [ACCOUNT_END_DATE] NVARCHAR(50),
    [IS_MEMBER] BIT -- or NVARCHAR(10) if your CSV has 'True/False' strings
)
WITH (
    -- Check if your folder is 'source' or 'Source' (it is case-sensitive!)
    LOCATION = 'source/public.rider.csv', 
    DATA_SOURCE = [AzureStorage],
    FILE_FORMAT = [CsvFormat] -- Using the format that skips the header
);
GO

-- 3. Verify the data
SELECT TOP 10 * FROM dbo.STAGING_RIDER;
GO