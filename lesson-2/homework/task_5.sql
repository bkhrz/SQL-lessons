DROP TABLE IF EXISTS workers;
CREATE TABLE workers(
    id INT PRIMARY key,
    name NVARCHAR(100)
);

BULK INSERT workers
FROM '/Users/behruz/PycharmProjects/SQL-lessons/lessson-2/homework/workers.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM workers;