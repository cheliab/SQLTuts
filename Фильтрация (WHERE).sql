-- ‘ильтраци€. WHERE

create database tut_Where
go

use tut_Where
go

create table Products
(
	Id int identity primary key,
	ProducName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price decimal(19, 4) not null
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

select * from Products

-------------------------------------------------
-- «нак =

select * from Products
where Manufacturer = 'Samsung'

select * from Products
where Manufacturer = 'samsung' -- регистр не имеет значени€

select * from Products
where Manufacturer = 'SAMSUNG' -- регистр не имеет значени€

-------------------------------------------------
-- «нак >

select * from Products
where Price > 45000

select * from Products
where Price * ProductCount > 200000 -- можно использовать выражени€

-------------------------------------------------
-- Ћогические операторы (AND OR NOT)

-- AND
select * from Products
where Manufacturer = 'samsung' and Price > 50000

-- OR
select * from Products
where Manufacturer = 'samsung' or Price > 50000

-- NOT
select * from Products
where not Manufacturer = 'samsung'

select * from Products
where Manufacturer <> ' samsung' -- вариант подобный not

-- несколько логических операторов
select * from Products
where Manufacturer = 'samsung' or Price > 30000 and ProductCount > 2 -- сначала выполн€етс€ and потом or

-- использование скобок
select * from Products
where (Manufacturer = 'samsung' or Price > 30000) and ProductCount > 2 -- скобки переопредел€ют пор€док

-- IS NULL

alter table Products
drop constraint [DF__Products__Produc__37A5467C];

insert into  Products
values
('iPhone 8', 'Apple', null, 52000)

select * from Products
where ProductCount is null

select * from Products
where ProductCount is not null