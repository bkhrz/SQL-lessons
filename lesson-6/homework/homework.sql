-- Drop in reverse dependency order
drop table if exists Projects;
drop table if exists Employees;
drop table if exists Departments;

-- Create Departments first
create table Departments (
    DepartmentID int primary key identity(101, 1),
    DepartmentName varchar(50)
);

-- Insert into Departments
insert into Departments(DepartmentName)
values 
('IT'), ('HR'), ('Finance'), ('Marketing');

create table Employees (
    EmployeeID int primary key identity,
    name varchar(50),
    DepartmentID int foreign key references Departments(DepartmentID),
    salary int
);

-- Insert into Employees
insert into Employees(name, DepartmentID, salary)
values
    ('Alice', 101, 60000),
    ('Bob', 102, 70000),
    ('Charlie', 101, 65000),
    ('David', 103, 72000),
    ('Eva', NULL, 68000); -- OK since FK allows NULL

-- Create Projects
create table Projects (
    ProjectID int primary key identity,
    ProjectName varchar(50),
    EmployeeID int foreign key references Employees(EmployeeID)
);

-- Insert into Projects
insert into Projects(ProjectName, EmployeeID)
values
    ('Alpha', 1),
    ('Beta', 2),
    ('Gamma', 1),
    ('Delta', 4),
    ('Omega', NULL); 

-- Task 1: INNER JOIN
SELECT e.EmployeeID,
       e.name AS EmployeeName,
       e.salary,
       d.DepartmentID,
       d.DepartmentName
FROM Employees AS e
INNER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;

-- Task 2: LEFT JOIN
SELECT e.EmployeeID,
       e.name AS EmployeeName,
       e.salary,
       d.DepartmentID,
       d.DepartmentName
FROM Employees AS e
LEFT JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;

-- Task 3: RIGHT JOIN
SELECT e.EmployeeID,
       e.name AS EmployeeName,
       e.salary,
       d.DepartmentID,
       d.DepartmentName
FROM Employees AS e
RIGHT JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;

-- Task 4: FULL OUTER JOIN
SELECT e.EmployeeID,
       e.name AS EmployeeName,
       e.salary,
       d.DepartmentID,
       d.DepartmentName
FROM Employees AS e
FULL OUTER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;

-- Task 5: Total Salary by Department (Right Join + Group)
WITH all_departments AS (
    SELECT e.EmployeeID,
           e.name AS EmployeeName,
           e.salary,
           d.DepartmentID,
           d.DepartmentName
    FROM Employees AS e
    RIGHT JOIN Departments AS d
    ON e.DepartmentID = d.DepartmentID
)
SELECT DepartmentName, ISNULL(SUM(salary), 0) AS TotalSalaryExp
FROM all_departments
GROUP BY DepartmentName;

-- Task 6: CROSS JOIN
SELECT *
FROM Departments
CROSS JOIN Projects;

-- Task 7: Employees with Departments and Projects
WITH emp_dep AS (
    SELECT e.EmployeeID,
           e.name,
           d.DepartmentName
    FROM Employees AS e
    LEFT JOIN Departments AS d
    ON e.DepartmentID = d.DepartmentID
)
SELECT ed.EmployeeID,
       ed.name,
       ed.DepartmentName,
       p.ProjectName
FROM emp_dep AS ed
LEFT JOIN Projects AS p
ON ed.EmployeeID = p.EmployeeID;