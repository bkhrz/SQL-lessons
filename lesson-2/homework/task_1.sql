DROP DATABASE IF EXISTS PracticeDB;
CREATE DATABASE PracticeDB;
USE PracticeDB;


DROP TABLE IF EXISTS test_identity -- completely deletes the existing table
CREATE TABLE test_identity(
    id INT PRIMARY KEY IDENTITY(1, 1),
    fruits varchar(255)
);

INSERT INTO test_identity VALUES
    ('apple'),
    ('grape'),
    ('lemon'),
    ('berry'),
    ('cherry');


DELETE FROM test_identity WHERE id = 2  --deletes the value where the id is equal to 2; the rest of the values will be still available

TRUNCATE TABLE test_identity --deletes the values in the table; table itself will be still available 

SELECT * FROM test_identity