DROP TABLE IF EXISTS data_types_demo;

CREATE TABLE data_types_demo (
    int_demo INT,
    smallint_demo SMALLINT, 
    bigint_demo BIGINT, 
    decimal_demo DECIMAL(10,2), 
    float_demo FLOAT, 
    varchar_demo VARCHAR(50),
    nvarchar_demo NVARCHAR(50),
    date_demo DATE,
    time_demo TIME, 
    datetime_demo DATETIME,
    guid_demo UNIQUEIDENTIFIER
);

INSERT INTO data_types_demo (
    int_demo, smallint_demo, bigint_demo, decimal_demo, float_demo,
    varchar_demo, nvarchar_demo, date_demo, time_demo, datetime_demo, guid_demo
)
VALUES (
    2, 255, 23893809832832903, 2.389, 2.32323,
    'apple', N'زيسز', '2020-12-30', '12:00', GETDATE(), NEWID()
);

SELECT * FROM data_types_demo;