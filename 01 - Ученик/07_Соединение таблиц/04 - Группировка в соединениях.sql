create database tut_GroupByWithJoin
go

use tut_GroupByWithJoin
go

------------------------------------------------------------

create table Products
(
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)

create table Customers
(
	Id int identity primary key,
	FirstName nvarchar(30) not null
)

create table Orders
(
	Id int identity primary key,
	ProductId int not null references Products(Id) on delete cascade,
	CustomerId int not null references Customers(Id) on delete cascade,
	CreatedAt date not null,
	ProductCount int default 1,
	Price decimal(19,4) not null
)

------------------------------------------------------------

insert into Products
values
('iPhone 6', 'Apple', 2, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi 5X', 'Xiaomi', 2, 26000),
('OnePlus 5', 'OnePlus', 6, 38000)

insert into Customers
values
('Tom'), ('Bob'), ('Sam')

insert into Orders -- 3 ������
values
-- 1
( 
    (SELECT Id FROM Products WHERE ProductName='Galaxy S8'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-11',  
    2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
-- 2
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-13',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
-- 3
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Bob'),
    '2017-07-11',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
)

------------------------------------------------------------
-- ��������� ������� �������������

select
	Customers.FirstName,
	count(Orders.Id) as OrdersNum
from Customers
	join Orders on Orders.CustomerId = Customers.Id -- ���� ������� 9 ���������� ��� �������
group by
	Customers.Id,
	Customers.FirstName

------------------------------------------------------------
-- ����� �������� ������ ��� �����������

create nonclustered index Orders_CustomerId 
on Orders(CustomerId)
include(Id)

select
	Customers.FirstName,
	count(Orders.Id) as OrdersNum
from Customers
	join Orders on Orders.CustomerId = Customers.Id -- ���� ������� �������� �� ������� ���������� ����������
group by
	Customers.Id,
	Customers.FirstName

------------------------------------------------------------
-- ����� ���� �����������

select 
	Customers.FirstName,
	COUNT(Orders.Id) as OrdersNum
from Customers
	left join Orders on Orders.CustomerId = Customers.Id
group by
	Customers.Id,
	Customers.FirstName


------------------------------------------------------------
-- ����� ������� �������

select
	Products.ProductName,
	Products.Manufacturer,
	SUM(Orders.ProductCount * Orders.Price) as OrdersSum -- � ������ �������� ����� null ��� ��� ��� ��������
from Products
	left join Orders 
	on Orders.ProductId = Products.Id
group by
	Products.ProductName,
	Products.Manufacturer

-- ISNULL()
select
	Products.ProductName,
	Products.Manufacturer,
	ISNULL(SUM(Orders.ProductCount * Orders.Price), 0) as OrdersSum -- ���� �������� isnull �� null ����� �������� ������ ���������
from Products
	left join Orders 
	on Orders.ProductId = Products.Id
group by
	Products.ProductName,
	Products.Manufacturer

------------------------------------------------------------
-- ������ ��� ���������� ���������� ���������� ��� ������ �� ������ �������

create nonclustered index Orders_ProductId
on Orders(ProductId)
include(ProductCount, Price)

select
	Products.ProductName,
	Products.Manufacturer,
	ISNULL(SUM(Orders.ProductCount * Orders.Price), 0) as OrdersSum
from Products
	left join Orders 
	WITH (INDEX(Orders_ProductId)) -- ����� �������� ������������� ������� (�.�. ������ ����� �� ������������)
	on Orders.ProductId = Products.Id
group by
	Products.ProductName,
	Products.Manufacturer