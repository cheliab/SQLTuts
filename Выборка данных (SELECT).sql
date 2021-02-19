-- ¬ыбрка данных.  оманда SELECT

--create database tut_Select;
--go

use tut_Select;
go

--create table Products
--(
--	Id int identity primary key,
--	ProductName nvarchar(30) not null,
--	Manufacturer nvarchar(20) not null,
--	ProductCount int default 0,
--	Price money not null
--)

--insert into Products
--values
--('iPhone 6', 'Apple', 3, 36000),
--('iPhone 6S', 'Apple', 2, 41000),
--('iPhone 7', 'Apple', 5, 52000),
--('Galaxy S8', 'Samsung', 2, 46000),
--('Galaxy S8 Plus', 'Samsung', 1, 56000),
--('Mi6', 'Xiaomi', 5, 28000),
--('OnePlus 5', 'OnePlus', 6, 38000)

-------------------------------------------------
-- получить все строки и столбцы

select * from Products

-------------------------------------------------
-- получить определенные колонки

select ProductName, Price from Products

-------------------------------------------------
-- выполнение операций при выборке

select 
ProductName + ' (' + Manufacturer + ')', -- конкатенаци€ строк
Price,
Price * ProductCount -- умножение
from Products

-------------------------------------------------
-- выполнение операций при выборке

select
ProductName + ' (' + Manufacturer + ')' as ModelName,
Price,
Price * ProductCount as TotalSum
from Products