create database metanit_UpdatableView
go

use metanit_UpdatableView
go

-------------------------------------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price decimal(16, 2) not null
)
go

---------------------------------------------------------
-- создаем представление

create view ProductView as
select 
	ProductName Product,
	Manufacturer,
	Price
from Products
go

------------------------------------------------------------
-- вставляем данные

insert into ProductView (Product, Manufacturer, Price)
values ('Nokia 8', 'HDC Global', 1000)
go

------------------------------------------------------------
-- проверяем

select * from ProductView

------------------------------------------------------------
-- обновление

update ProductView
set Price = 1200
where Product = 'Nokia 8'

