use lesson5;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 50000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 72000, '2021-03-29');

--task1

SELECT *, 
	ROW_NUMBER() OVER(ORDER BY Salary) AS Unique_Rank
FROM Employees;

-- task2
WITH RANKED_TABLE AS (SELECT *,
	DENSE_RANK() OVER(ORDER BY Salary) AS Salary_Rank
	FROM Employees)

SELECT *
FROM RANKED_TABLE
WHERE Salary_Rank IN (
	SELECT Salary_Rank
	FROM RANKED_TABLE
	GROUP BY Salary_Rank
	HAVING COUNT(*)>1
)
ORDER BY Salary_Rank;

-- task3

WITH Max_Salary_Rank AS(
	SELECT *, 
		DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY Salary DESC) AS Salary_Rank
	FROM Employees)

SELECT *
FROM Max_Salary_Rank
WHERE Salary_Rank <=2
ORDER BY Department, Salary_Rank;

-- task 4
WITH Ranked_Table AS (SELECT *,
	DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY ASC) AS Salary_Rank 
	FROM Employees)
SELECT *
FROM Ranked_Table
WHERE Salary_Rank=1;

-- task 5
SELECT *, 
	SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary, EmployeeID) AS Cum_Total_Salary
FROM Employees

-- task6
SELECT *, 
	SUM(Salary) OVER(PARTITION BY DEPARTMENT) AS Total_Department_Salary
FROM Employees

--task 7
SELECT *, 
	CAST(AVG(Salary) OVER(PARTITION BY DEPARTMENT) AS INT) AS AVG_Department_Salary
FROM Employees

-- TASK8
WITH AVG_Department_Salary_Table AS (SELECT *, 
	CAST(AVG(Salary) OVER(PARTITION BY DEPARTMENT) AS INT) AS AVG_Department_Salary
FROM Employees)

SELECT *, Salary-AVG_Department_Salary AS Salary_Difference
FROM AVG_Department_Salary_Table

-- TASK9
SELECT *, 
	CAST(AVG(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS INT) AS AVG3_Department_Salary
FROM Employees

-- TASK10
WITH Ranked_Date_Table AS (SELECT *, 
	DENSE_RANK() OVER(ORDER BY HireDate DESC) AS Date_Rank
	FROM Employees)

SELECT *
FROM Ranked_Date_Table
WHERE Date_Rank<=3

-- TASK 11
SELECT *,
	AVG(Salary) OVER(ORDER BY Salary) AS AVG_Cum_Salary
FROM Employees

--TASK12
SELECT *, 
	MAX(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS Max_Salary
FROM Employees

-- TASK13
WITH Total_Salary_Dep_Table AS (SELECT *,
	SUM(Salary) OVER(PARTITION BY DEPARTMENT) AS Total_Salary_Dep
	FROM Employees
)
SELECT *, 
	CAST(ROUND((Salary/Total_Salary_Dep)*100, 2) AS decimal(5,2)) AS Salary_Percentage
FROM Total_Salary_Dep_Table