-- Примеры оптимизаций
-- https://www.sqlshack.com/query-optimization-techniques-in-sql-server-the-basics/

create database sqlshack_Basic;
go

use sqlshack_Basic;
go

----------------------------------------------

create table Person (
	Id int identity primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	MiddleName nvarchar(50)
	index IX_Person_LastName_FirstName_MiddleName nonclustered (LastName, FirstName, MiddleName)
)

insert into Person
values
('Иван', 'Иванов', 'Иванович'),
('Иван', 'Смирнов', 'Иванович'),
('Иван', 'Петров', 'Иванович'),
('Иван', 'Шевцов', 'Иванович'),
('Иван', 'Орлов', 'Иванович'),
('Иван', 'Скворцов', 'Иванович'),
('Иван', 'Удальцов', 'Иванович'),
('Иван', 'Казанцев', 'Иванович')

-----------------------------------------------
-- 1. Использование функций в условиях

select
	Id,
	FirstName,
	LastName,
	MiddleName
from Person
where
	LEFT(LastName, 3) = 'Орл' -- При использовании функции для колонки будет выполнено полное сканирование таблицы

-- Чтобы выполнялся поиск по индексу нужно переписать запрос без использования функции для колонки

select
	Id,
	FirstName,
	LastName,
	MiddleName
from Person
where
	LastName like 'Орл%' -- при таком написании будет использован поиск по индексу

----------------------------------------------
-- 2. Неявное преобразование типов

create table Employee (
	Id varchar(5) primary key, -- использование строки в колонке где предполагается числовое значение
	LoginId int,
	JobTitle nvarchar(20)
)

insert into Employee
values
('123', 1, 'Программист'),
('234', 2, 'Аналитик'),
('345', 3, 'Руководитель'),
('456', 4, 'Продукт менеджер'),
('567', 5, 'Генеральный директор'),
('678', 6, 'Консультант')

----------------------------------------------

select
	Id,
	LoginId,
	JobTitle
from Employee
where
	Id = 567 -- при таком написании условия будет происходить неявное преобразование типа и будет выполнено сканирование

-- Нужно переписать условие, чтобы не было преобразования типов

select
	Id,
	LoginId,
	JobTitle
from Employee
where
	Id = '567' -- При таком написании не будет преобразований и будет выполнен поиск по индексу

