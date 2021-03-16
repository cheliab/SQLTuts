create database tut_Trigger_INSERT_UPDATE_DELETE
go

use tut_Trigger_INSERT_UPDATE_DELETE
go

---------------------------------

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)
go

create table History (
	Id int identity primary key,
	ProductId int not null,
	Operation nvarchar(200) not null,
	CreateAt datetime not null default getdate()
)
go

---------------------------------
-- INSERT - Триггер для добавления записи в историю при добалении нового товара

create trigger Products_INSERT
on Products
after insert
as
insert into History (ProductId, Operation)
select Id, 'Добавлен товар: ' + ProductName + '. Фирма: ' + Manufacturer
from inserted

-- Проверка работы триггера

insert into Products
(ProductName, Manufacturer, ProductCount, Price)
values
('iPhone X', 'Apple', 2, 79900)
go

select * from History
go

-----------------------------------
-- DELETE - Триггер для добавлении записи в историю при удалении из таблицы товаров

create trigger Products_DELETE
on Products
after delete
as
insert into History (ProductId, Operation)
select Id, 'Удален товар: ' + ProductName + ' Фирма: ' + Manufacturer
from deleted
go

-- Проверка работы триггера
delete from Products
where Id = 1
go

select * from History
go

----------------------------------------------------
-- UPDATE - Триггер на обновление данных

create trigger Product_UPDATE
on Products
after update
as
insert into History (ProductId, Operation)
select Id, 'Обновлен товар: ' + ProductName + ' Фирма: ' + Manufacturer
from inserted
go

--insert

--update 
