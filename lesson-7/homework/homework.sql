Drop table if exists customers;
drop table if exists Orders
drop table if exists OrderDetails
drop table if exists Products

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

--task 1
select 
c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID

--task 2
select 
c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID
where o.OrderID is null

-- task 3

select 
o.OrderID, od.ProductID, od.Price, od.Quantity
from Orders o
join OrderDetails od
on o.OrderID = od.OrderID

--task 4
select c.CustomerID, c.CustomerName
from Customers c
join orders o
on c.CustomerID=o.CustomerID
group by c.CustomerID, c.CustomerName
having COUNT(o.OrderID)>1

--task 5 
select OrderID, ProductID, Price
from (select o.OrderID, od.ProductID, od.Price, 
dense_rank() over(partition by o.OrderID order by price desc) as price_rank
from Orders o
join OrderDetails od
on o.OrderID=od.OrderID) help_table
where price_rank=1;

--task 6
with Cus_Ord_Table as (select c.CustomerID, c.CustomerName, o.OrderDate, o.OrderID,
ROW_NUMBER() over(partition by c.CustomerID order by o.OrderDate desc) as date_rank
from Customers c
join Orders o
on c.CustomerID=o.CustomerID)
select  CustomerName, OrderDate, OrderID
from Cus_Ord_Table 
where date_rank=1;

--task 7
select c.CustomerName
from (select p.ProductID,
p.Category,
od.OrderID,
case when p.Category='Electronics' then 0 else 1 end as NotElectronics
from Products p
join OrderDetails od
on p.ProductID=od.ProductID) as OD_Prd
join Orders o
on o.OrderID=OD_Prd.OrderID
join Customers c
on c.CustomerID=o.CustomerID
group by c.CustomerName
having sum(OD_Prd.NotElectronics)=0;

--task 8
select c.CustomerName
from (select p.ProductID,
p.Category,
od.OrderID,
case when p.Category='Stationery' then 1 else 0 end as Stationery
from Products p
join OrderDetails od
on p.ProductID=od.ProductID) as OD_Prd
join Orders o
on o.OrderID=OD_Prd.OrderID
join Customers c
on c.CustomerID=o.CustomerID
group by c.CustomerName
having sum(OD_Prd.Stationery)>=1;

-- task 9
select distinct c.customerid, c.customername, 
sum(price) over(partition by c.customername) as TotalSpent
from customers as c
join orders as o on c.customerid=o.customerid
join orderdetails as od on od.orderid=o.orderid