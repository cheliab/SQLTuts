create database tut_OuterJoin
go

use tut_OuterJoin
go

-------------------------------------------------------------------

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
	CreateAt date not null,
	ProductCount int default 1,
	Price decimal(19,4) not null
)

-------------------------------------------------------------------

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

insert into Orders
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

-------------------------------------------------------------------
-- ѕростой пример соединени€

select 
	Customers.FirstName,
	Orders.CreateAt,
	Orders.ProductCount,
	Orders.Price
from Orders
	left join Customers 
	on Orders.CustomerId = Customers.Id

-------------------------------------------------------------------
-- —равнение inner join и left join

-- INNER
select FirstName, CreateAt, ProductCount, Price 
from Customers
inner join Orders on Orders.CustomerId = Customers.Id -- вывод€тс€ только строки которые есть в обеих таблицах

-- LEFT
select FirstName, CreateAt, ProductCount, Price
from Customers
left join Orders on Orders.CustomerId = Customers.Id -- сначала вывод€тс€ строки левой таблицы и к ней цепл€ютс€ строки второй

-------------------------------------------------------------------
-- ѕример right join

select * from Orders
right join Customers on Orders.CustomerId = Customers.Id

-------------------------------------------------------------------
-- ¬ыбрать всех пользователей без заказов

select * from Customers
left join Orders on Customers.Id = Orders.CustomerId
where Orders.CustomerId is null -- выведутс€ строки, которые не смогли присоединитьс€

-------------------------------------------------------------------
--  омбинирование left join и inner join

select * 
from Orders
	inner join Products 
	on Orders.ProductId = Products.Id
	and Products.Price < 45000
	left join Customers
	on Orders.CustomerId = Customers.Id
order by
	Orders.CreateAt