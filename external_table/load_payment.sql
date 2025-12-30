
CREATE EXTERNAL TABLE dbo.STAGING_PAYMENT (
    [payment_id] bigint,
    [date] varchar(50),
    [amount] float,
    [rider_id] bigint
)
WITH (
    LOCATION = 'source/public.payment.csv', 
    DATA_SOURCE = [AzureStorage],
    FILE_FORMAT = [CsvFormat] -- Using the new name here
);
GO

-- 4. Check the results
SELECT TOP 10 * FROM dbo.STAGING_PAYMENT;
GO