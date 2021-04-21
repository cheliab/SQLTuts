create database tut_Trigger_InsteadOf
go

use tut_Trigger_InsteadOf
go

----------------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	Price decimal(19, 4) not null,
	IsDeleted bit -- данное поле будет использоваться для "мягкого" удаления
)
go

-------------------------------------------
-- Создаем триггер который выполняется вместо операции удаления

create trigger Products_DELETE
on Products
instead of delete
as
update Products
set IsDeleted = 1 -- теперь вместо удаления будет просто проставляться признак
where id = (select id from deleted)
go

-- проверка работы триггера

-- Добавили
insert into Products
(ProductName, Manufacturer, Price)
values
('iPhone X', 'Apple', 79000),
('Pixel 2', 'Google', 60000)

-- "Удалили" (отработает триггер)
delete from Products
where ProductName = 'Pixel 2'

select * from Products
-- Будет простален IsDeleted