create database tut_Procedure_WithParams
go

use tut_Procedure_WithParams
go

----------------------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)
go

-----------------------------------------------
-- Создаем процедуру по вставке товара

create procedure AddProduct
	@name nvarchar(30),
	@manufacturer varchar(30),
	@count int,
	@price decimal(19,4)
as
insert into Products
(ProductName, Manufacturer, ProductCount, Price)
values
(@name, @manufacturer, @count, @price)
go

----------------------------------------------
-- 1 - Передача параметров через переменные

declare
	@name nvarchar(30) = 'iPhone 6',
	@company nvarchar(20) = 'Apple',
	@price decimal(19,4) = 30000,
	@count int = 5;

exec AddProduct @name, @company, @count, @price
go

select * from Products
go

-------------------------------------------
-- 2 - Передача значений в параметры

exec AddProduct 'Galaxy C7', 'Samsung', 5, 20000
go

-------------------------------------------
-- 3 - Передача параметров по имени

exec AddProduct @name = 'iPhone 5',
				@manufacturer = 'Apple',
				@count = 3,
				@price = 18000
go

