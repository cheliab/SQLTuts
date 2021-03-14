create database tut_Except
go

use tut_Except
go

--------------------------------------------------

create table Customers
(
	Id int identity primary key,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	AccountSum decimal(19,4) default 0
)

create table Employees
(
	Id int identity primary key,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null
)

--------------------------------------------------

insert into Customers
values
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800)

insert into Employees
values
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson')

----------------------------------------------------
-- ѕоиск клиентов, которые не работают в организации

select
FirstName,
LastName
from Customers

except

select
FirstName,
LastName
from Employees

----------------------------------------------------
-- ѕоиск сотрудников, которые €вл€ютс€ клиентами

select
FirstName,
LastName
from Employees

except

select
FirstName,
LastName
from Customers