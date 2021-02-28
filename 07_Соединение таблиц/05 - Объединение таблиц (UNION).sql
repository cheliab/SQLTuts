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
-- ������� �����������

select 
FirstName,
LastName
from Customers

union -- ����������� ����� 8 �������� (����� ��������)

select
FirstName,
LastName
from Employees

------------------------------------------------------------------
-- �������� ������� � �������� ������� ������� �� ������ �������

select
FirstName + ' ' + LastName as FullName -- ����� ����� � �������� �������� �������� �������
from Customers

union

select 
FirstName + ' ' + LastName as EmployeeName
from Employees

order by FullName

------------------------------------------------------------------
-- ������� ������

-- ������ ���������� ��������
select 
FirstName,
LastName,
AccountSum -- ������ �������
from Customers

union

select
FirstName,
LastName
from Employees

-- ������ ����
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
-- �� ������� ����� (UNION ALL)

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
-- ������������� ����� ������� � ������� ���������

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