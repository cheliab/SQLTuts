-- Извелечение диапазона строк

create database tut_Top
go

use tut_Top
go

create table Products
(
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price money not null
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

--------------------------------------------
-- Оператор TOP

select top 4 ProductName
from Products

--------------------------------------------
-- Оператор PERCENT

select top 50 percent ProductName
from Products

--------------------------------------------
-- Оператор OFFSET

select * from Products
order by Id
offset 2 rows -- выведет все записи с Id 3

--------------------------------------------
-- Оператор FETCH

select * from Products
order by Id
offset 2 rows -- веведет записи с Id 3
fetch next 3 rows only; -- только 3 записи