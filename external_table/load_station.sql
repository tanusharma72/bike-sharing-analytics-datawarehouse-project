
CREATE EXTERNAL TABLE dbo.STAGING_STATION (
    [station_id] NVARCHAR(400),
    [name] NVARCHAR(400),
    [latitude] FLOAT,
    [longitude] FLOAT
)
WITH (
    LOCATION = 'source/public.station.csv', -- Double check if it is 'publicstation.csv' or 'station.csv'
    DATA_SOURCE = [AzureStorage],
    FILE_FORMAT = [CsvFormat] -- Using the format that skips the first row
);
GO

-- 3. Verify the data
SELECT TOP 10 * FROM dbo.STAGING_STATION;
GO