create database tut_Delete
go

use tut_Delete
go

create table Products
(
	id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)

insert into Products
values
('iPhone 6', 'Apple', 3, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi6', 'Xiaomi', 5, 28000),
('OnePlus 5', 'OnePlus', 6, 38000)

---------------------------------------------------

-- простое условие
delete Products
where Id = 3

select * from Products

-- несколько условий
delete Products
where Manufacturer = 'Apple' and Price < 40000

select * from Products

-- использование подзапроса
delete Products from
(select top 1 * from Products 
where Manufacturer = 'Apple') as Selected
where Products.Id = Selected.Id

select * from Products

-- удалить все строки
delete Products