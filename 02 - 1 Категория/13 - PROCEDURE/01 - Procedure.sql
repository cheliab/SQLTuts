create database tut_Procedure
go

use tut_Procedure
go

--------------------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)
go

insert into Products
values
('iPhone 6', 'Apple', 1, 36000),
('iPhone 7', 'Apple', 2, 52000)
go

-------------------------------------------
-- Первый вариант создания процедуры

create procedure ProductSummary_v1 as
select 
	ProductName as Product,
	Manufacturer,
	Price
from Products
go

------------------------------------------
-- Второй вариант с использованием BEGIN ... END

create procedure ProductSummary_v2 as
begin
	select ProductName as Product, Manufacturer, Price from Products
end

------------------------------------------
--  Выполнение процедуры

exec ProductSummary_v1

exec ProductSummary_v2

-----------------------------------------
-- Удаляем процедуру

drop procedure ProductSummary_v1

drop procedure ProductSummary_v2