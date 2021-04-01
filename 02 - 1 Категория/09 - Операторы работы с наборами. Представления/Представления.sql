create database metanit_View
go

use metanit_View
go
-----------------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(50) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount int default 0,
	Price decimal(16, 4)
)
go

create table Customers (
	Id int identity primary key,
	FirstName nvarchar(50) not null
)
go

create table Orders (
	Id int identity primary key,
	ProductId int not null references Products(Id) on delete cascade,
	CustomerId int not null references Customers(Id) on delete cascade,
	CreateAt date not null,
	ProductCount int default 1,
	Price decimal(15, 4)
)
go

-------------------------------------------

insert into Products
values
('iPhone 6', 'Apple', 100, 500),
('iPhone 7', 'Apple', 200, 700),
('iPhone X', 'Apple', 150, 800),
('Galaxy 10', 'Samsung', 50, 650),
('Galaxy 9', 'Samsung', 60, 550)
go

insert into Customers
values
('Алексей'),
('Дмитрий'),
('Павел'),
('Максим'),
('Виктория')
go

insert into Orders
values
(1, 1, '2021-04-02', 2, 500 * 2),
(2, 2, '2021-04-02', 1, 700 * 1),
(3, 3, '2021-04-02', 3, 800 * 3),
(4, 4, '2021-04-02', 1, 650 * 1),
(5, 5, '2021-04-02', 2, 550 * 2)
go

--------------------------------------------
-- добавим представление

create view OrdersProductsCustomers as
	select
		Orders.CreateAt OrderDate,
		Customers.FirstName Customer,
		Products.ProductName Product
	from Orders
		inner join Products on Orders.ProductId = Products.Id
		inner join Customers on Orders.CustomerId = Customers.Id
go

-- выводим данные представления

select * from OrdersProductsCustomers
go

-- Второй вариант создания (определение списка колонок после названия)

create view OrdersProductsCustomersV2 (OrderDate, Customer, Product) as
select
	Orders.CreateAt,
	Customers.FirstName,
	Products.ProductName
from Orders
	inner join Products on Orders.ProductId = Products.Id
	inner join Customers on Orders.CustomerId = Customers.Id