create database tut_InnerJoin
go

use tut_InnerJoin
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

insert into Orders -- 3 заказа
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
-- Добавить к заказам информацию по товарам

select
	Orders.CreatedAt,
	Orders.ProductCount,
	Products.ProductName
from Orders
	join Products on Products.Id = Orders.ProductId

------------------------------------------------------------
-- использование псевдонимов

select
	O.CreatedAt,
	O.ProductCount,
	P.ProductName
from Orders as O
	join Products as P
	on P.Id = O.ProductId

------------------------------------------------------------
-- соединение нескольких таблиц

select
	Orders.CreatedAt,
	Orders.ProductCount,
	Products.ProductName,
	Customers.FirstName
from Orders 
	join Products on Products.Id = Orders.ProductId
	join Customers on Customers.Id = Orders.ProductId

------------------------------------------------------------
-- использование присоединенных таблиц в условиях и сортировке

select
	Orders.CreatedAt,
	Orders.ProductCount,
	Products.ProductName,
	Customers.FirstName
from Orders
	join Products on Products.Id = Orders.ProductId
	join Customers on Customers.Id = Orders.CustomerId
where
	Products.Price < 45000
order by
	Customers.FirstName

------------------------------------------------------------
-- сложные соединения

select 
	Orders.CreatedAt,
	Customers.FirstName,
	Products.ProductName
from Orders
	join Products
		on Products.Id = Orders.ProductId
		and Products.Manufacturer = 'Apple'
	join Customers 
		on Customers.Id = Orders.CustomerId