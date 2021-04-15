-- Примеры оптимизаций
https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/

create database sqlshack_TipsAndTricks
go

use sqlshack_TipsAndTricks
go

---------------------------------------------------
-- 1. Использование OR (ИЛИ) в соединениях

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

----------------------------------------------------------------------
-- 1. Использование OR (ИЛИ) в соединениях

select distinct
	P.ProductID,
	P.[Name]
from Product P
	inner join SalesOrderDetail D -- при таком написани будет много лишних чтений из таблицы SalesOrderDetail
	on P.ProductID = D.ProductID
	or P.RowGUID = D.RowGUID

-- Можно переписать с использованием UNION

