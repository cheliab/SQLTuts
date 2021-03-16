-- Создаем БД

create database tut_Trigger
go

use tut_Trigger
go

--------------------------------------------
-- Создаем таблицу

create table Products (
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount  int default 0,
	Price decimal(19,4) not null
)
go

---------------------------------------------
-- Создаем триггер для таблицы Products

-- Формальное определение
-- CREATE TRIGGER имя_триггера
-- ON { имя_таблицы | имя_представления }
-- {AFTER | INSTEAD} [INSERT | UPDATE | DELETE]
-- AS выражения_sql

create trigger Products_INSERT_UPDATE
on Products
after insert, update
as
update Products
set Price = Price + Price * 0.38 -- С помощью триггера определяем новую цену, на основе чистой цены
where Id = (select Id from inserted)

insert into Products
(ProductName, ProductCount, Manufacturer, Price)
values
('iPhone X', 2, 'Apple', 68000)

select * from Products

-------------------------------------
-- Удаление триггера

drop trigger Products_INSERT_UPDATE
go

-------------------------------------
-- Отключение / Включение триггера

disable trigger Products_INSERT_UPDATE on Products -- откл.
go

enable trigger Products_INSERT_UPDATE on Products -- вкл.
go

