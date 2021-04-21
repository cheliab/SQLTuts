-- Примеры оптимизаций
https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/

----------------------------------------------------------------------
-- 1. Использование OR (ИЛИ) в соединениях
-- (не удалось повторить, видимо нужно больше данных)

SET STATISTICS IO ON;

select distinct
	P.ProductID,
	P.[Name]
from Product P
	inner join SalesOrderDetail D -- при таком соединении дожно быть в разы больше лишних чтений из таблицы SalesOrderDetail
	on P.ProductID = D.ProductID
	or P.RowGUID = D.RowGUID

--(100 rows affected)
--Table 'SalesOrderDetail'. Scan count 1, logical reads 200, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Product'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

-- Можно переписать с использованием UNION

select
	P.ProductID,
	P.[Name]
from Product P
	inner join SalesOrderDetail D
	on P.ProductID = D.ProductID

union

select
	P.ProductID,
	P.[Name]
from Product P
	inner join SalesOrderDetail D
	on P.RowGUID = D.RowGUID

--(100 rows affected)
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'SalesOrderDetail'. Scan count 101, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Product'. Scan count 1, logical reads 202, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

---------------------------------------------
-- 2. - Использование при поиске по тексту шаблона '%Текст%'

select
	ProductID,
	[Name]
from Product
where
	[Name] like '%iPhone%' -- при таком написании всегда будет сканирование таблицы

-- Нужно использовать варинты 'iPhone%' или '%iPhone'
-- Либо уже использовать другие варианты поиска если варинаты выше не подходят 
-- И нужен поиск тексту который будет выполняться регулярно

--------------------------------------------------------------------
--------------------------------------------------------------------
-- Заполнение данных для примера
create database sqlshack_TipsAndTricks
go

use sqlshack_TipsAndTricks
go

----------------------------------------------------

create table Product (
	ProductID int identity primary key,
	RowGUID int,
	[Name] nvarchar(50)
)

create table SalesOrderDetail (
	RowGUID int,
	ProductID int
	index PK_SalesOrderDetail_SalesOrderID clustered (RowGUID, ProductID)
)

----------------------------------------------------

insert into Product -- 6
values
(1, 'iPhone 1'),
(2, 'iPhone 2'),
(3, 'iPhone 3'),
(4, 'iPhone 4'),
(5, 'iPhone 5'),
(6, 'iPhone 6')

insert into SalesOrderDetail -- 12
values
(1, 1),
(1, 2),
(2, 2),
(2, 5),
(3, 3),
(3, 1),
(4, 4),
(4, 3),
(5, 5),
(5, 1),
(6, 1),
(6, 6)

----------------------------------------------------

truncate table Product
truncate table SalesOrderDetail

----------------------------------------------------

declare @counter int = 1;

while (@counter <= 100)
begin

	insert into Product (RowGUID, [Name]) values (@counter, CONCAT('iPhone ', @counter))
	
	set @counter = @counter + 1;
end
go

declare @counter int = 1

while (@counter <= 100)
begin

	insert into SalesOrderDetail values (@counter, @counter)

	set @counter = @counter + 1
end
go