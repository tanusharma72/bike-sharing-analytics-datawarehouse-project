
CREATE EXTERNAL TABLE dbo.STAGING_TRIP (
    [trip_id] NVARCHAR(400),
    [rideable_type] NVARCHAR(400),
    [start_at] NVARCHAR(50),
    [ended_at] NVARCHAR(50),
    [start_station_id] NVARCHAR(400),
    [end_station_id] NVARCHAR(400),
    [rider_id] BIGINT
)
WITH (
    LOCATION = 'source/public.trip.csv', -- Verify this filename in your 'source' folder
    DATA_SOURCE = [AzureStorage],
    FILE_FORMAT = [CsvFormat] -- Crucial to skip the header row
);
GO

-- 3. Verify the data (This may take a few seconds longer due to file size)
SELECT TOP 10 * FROM dbo.STAGING_TRIP;
GO