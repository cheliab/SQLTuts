create database tut_SystemCatalog

use tut_SystemCatalog

-------------------------------------------------

-- Просмотр всех объектов БД
select * from sys.objects

-- Получить все таблицы созданные пользователем
select * from sys.objects
where 
	type = 'U' -- тип таблицы

-- Получить все объекты со схемой dbo
select * from sys.objects
where
	schema_id = SCHEMA_ID('dbo')

--------------------------------------------------
-- просмотр отдельных типов объектов

select * from sys.tables -- таблицы

select * from sys.views -- представления

select * from sys.triggers -- триггеры

select * from sys.procedures -- процедуры

--------------------------------------------------
-- просмотр функций определенного типа

select * from sys.objects
where type in ('FN', 'FS', 'FT', 'IF', 'TF')

---------------------------------------------------------
---------------------------------------------------------
-- System stored procedures
-- Системные процедуры

---------------------------------------------------------
-- Процедура sp_help

-- без параметра выводятся все объекты БД (Можно вызвать по Alt + F1)
exec sp_help

-- с параметром выводятся данные об объекте

create table Products (
	Id int primary key identity,
	[Name] nvarchar(20)
)

-- выводим информацию по таблице Products
exec sp_help 'Products'

-- Так же можно вывести информацию по ключу таблицы
exec sp_help 'PK__Products__3214EC070AA3A13B'

------------------------------------------------------------
-- Процедура sp_tables

-- Если не указывать параметров выводится информация по всем таблицам и представлениям
exec sp_tables 

-- Выведутся таблицы и представления со схемой dbo
exec sp_tables @table_owner = 'dbo'

---------------------------
-- Процедура sp_columns

-- Информация по колонкам
exec sp_columns 'Products'

-- Информация по первичному ключу
exec sp_pkeys 'Products'

-- Информация о зависимостях (объекты в которых есть ссылки на данную таблицу) 
exec sp_depends 'Products'