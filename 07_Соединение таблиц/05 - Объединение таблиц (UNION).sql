create database tut_Union
go

use tut_Union
go

------------------------------------------------------------------

create table Customers
(
	Id int identity primary key,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	AccountSum decimal(19,4)
)

create table Employees
(
	Id int identity primary key,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null
)

------------------------------------------------------------------

insert into Customers -- 6
values
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800)

insert into Employees -- 4
values
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson')

------------------------------------------------------------------
-- Простое объединение

select 
FirstName,
LastName
from Customers

union -- результатом будет 8 значений (дубли удалятся)

select
FirstName,
LastName
from Employees

------------------------------------------------------------------
-- Название колонки в итоговое таблице берется из первой таблицы

select
FirstName + ' ' + LastName as FullName -- будет взято в качестве названия итоговой колонки
from Customers

union

select 
FirstName + ' ' + LastName as EmployeeName
from Employees

order by FullName

------------------------------------------------------------------
-- Примеры ошибок

-- Разное количество столбцов
select 
FirstName,
LastName,
AccountSum -- лишняя колонка
from Customers

union

select
FirstName,
LastName
from Employees

-- Разные типы
select
FirstName,
LastName
from Customers

union

select
Id,
LastName
from
Employees

------------------------------------------------------------------
-- Не удалять дубли (UNION ALL)

select
FirstName,
LastName
from Customers

union all

select
FirstName,
LastName
from Employees

------------------------------------------------------------------
-- Использование одной таблицы с разными условиями

select
FirstName,
LastName,
AccountSum + AccountSum * 0.1 as TotalSum
from Customers
where AccountSum < 3000

union

select
FirstName,
LastName,
AccountSum + AccountSum * 0.3 as TotalSum
from Customers
where AccountSum >= 3000