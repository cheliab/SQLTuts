create database tut_Update
go

use tut_Update
go

create table Products
(
	Id int identity primary key,
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

-------------------------------------------------
-- обновление всех строк

update Products
set Price = Price + 5000 -- прибавим ко всем ценам 5000

select * from Products

-------------------------------------------------
-- обновление с условием

update Products
set Manufacturer = 'Samsung Inc.'
where Manufacturer = 'Samsung'

select * from Products

-------------------------------------------------
-- обновление с подзапросом

update Products
set Manufacturer = 'Apple .Inc'
from
(select top 1 * from Products where Manufacturer = 'Apple') as Selected
where Products.Id = Selected.Id

select * from Products

update Products
set Price = Products.Price + 0.5
from 
(select * from Products where Price < 50000) as Selected
where Products.Id = Selected.Id

select * from Products