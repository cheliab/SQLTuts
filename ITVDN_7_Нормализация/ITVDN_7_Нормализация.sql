-- 7. ������������

create database ITVDN_7_Normalization
go

use ITVDN_7_Normalization
go

------------------------------------------------------------------------
-- ������ ���������� �����

create table PizzeriaData(
	OrderNo int,
	[Date] date,
	Customer nvarchar(100),
	CustomerData nvarchar(max),
	OrderInfo nvarchar(max),
	Courier nvarchar(100)
)
go

insert PizzeriaData
values
(1, '20170407', '�������� �����', '��. ����������, �. 12, ���. 55-66-77', '����� �������� - 1, ���� ����� - 2 (0.5)', '�������� ��������'),
(2, '20170407', '���������� ����', '��. ������, �. 30, ���. 11-22-33', '����� ������������ - 2, ����� ������ - 2, ��� ������������ - 1', '����'),
(3, '20170407', '���������� ��������', '��. �������, �. 20, ���. 45-67-89, ���. (077)555-11-41', '���� ������� 3 - 6 (1), �������� ��� - 3, ������ ������ - 2', '����� (�����������)')
go

select * from PizzeriaData

---------------------------------------------------------
-- �������� �������
-- ��������� ������ ������ �������� �� ��������� �������

drop table PizzeriaData

create table PizzeriaData(
	OrderNo int,
	[Date] date,
	Customer nvarchar(100),
	CustomerAddress nvarchar(max),
	CustomerPhone varchar(15),
	CustomerMob varchar(15),
	Product1 nvarchar(20),
	Qty1 tinyint,
	Product2 nvarchar(20),
	Qty2 tinyint,
	Product3 nvarchar(20),
	Qty3 tinyint,
	Courier nvarchar(100)
)
go

insert PizzeriaData
values
(1, '20170407', '�������� �����', '��. ����������, �. 12', '���. 55-66-77', null, '����� ��������', 1, '���� ����� (0.5)', 2, null, null, '�������� ��������'),
(2, '20170407', '���������� ����', '��. ������, �. 30', '���. 11-22-33',  null, '����� ������������', 2, '����� ������', 2, '��� ������������', 1, '����'),
(3, '20170407', '���������� ��������', '��. �������, �. 20', '���. 45-67-89', '���. (077)555-11-41', '���� ������� 3 (1)', 6, '�������� ���', 3, '������ ������', 2, '����� (�����������)')
go

----------------------------------------
-- �������� �������
-- ������� ���������� ������� ��� ������������� ��������
-- ����� ��������� ����������� �������

drop table PizzeriaData

create table PizzeriaData (
	OrderNo int,
	OrderItem int,
	[Date] date,
	Customer nvarchar(100),
	CustomerAddress nvarchar(max),
	CustomerPhone varchar(15),
	CustomerMob varchar(15),
	Product nvarchar(20),
	ProductName nvarchar(20),
	Qty tinyint,
	Courier nvarchar(100)
)

insert PizzeriaData
values
(1, 1, '20170407', '�������� �����', '��. ����������, �. 12', '���. 55-66-77', null, '�����', '��������', 1, '�������� ��������'),
(1, 2, '20170407', '�������� �����', '��. ����������, �. 12', '���. 55-66-77', null, '����', '����� (0.5)', 2, '�������� ��������'),
(2, 1, '20170407', '���������� ����', '��. ������, �. 30', '���. 11-22-33',  null, '�����', '������������', 2, '����'),
(2, 2, '20170407', '���������� ����', '��. ������, �. 30', '���. 11-22-33',  null, '�����', '������', 2, '����'),
(2, 3, '20170407', '���������� ����', '��. ������, �. 30', '���. 11-22-33',  null, '��� ������������', 'Rich', 1, '����'),
(3, 1, '20170407', '���������� ��������', '��. �������, �. 20', '45-67-89', '(077)555-11-41', '����', '������� 3 (1)', 6, '����� (�����������)'),
(3, 2, '20170407', '���������� ��������', '��. �������, �. 20', '45-67-89', '(077)555-11-41', '�������', '�������� ���', 3, '����� (�����������)'),
(3, 3, '20170407', '���������� ��������', '��. �������, �. 20', '45-67-89', '(077)555-11-41', '�������', '������ ������', 2, '����� (�����������)')
go

select * from PizzeriaData
where CustomerAddress like '%����������%'

------------------------------------------------------------------------
------------------------------------------------------------------------
-- ������ ���������� �����
--
-- ��� �� �������� ������ ������ �������� �� �����
-- ��������� ��������� ���� ������� �� OrderNo � OrderItem
-- 
-- ��������� ������� �� ���, ����� ��������� ������������ ������

drop table PizzeriaData

create table Orders(
	OrderNo int,
	[Date] date,
	CustomerId int,
	Courier nvarchar(100)
)

create table OrderInfo(
	OrderNo int,
	OrderItem int,
	Product nvarchar(20),
	ProductName nvarchar(20),
	Qty tinyint
)

create table Customers(
	Id int,
	FullName nvarchar(100),
	[Address] nvarchar(max),
	[Phone] varchar(15),
	[MobilePhone] varchar(15)
)

-----------

insert Orders values
(1, '20170407', 1, '�������� ��������'),
(2, '20170407', 2, '����'),
(3, '20170408', 3, '����� (�����������)')
go

insert OrderInfo values
(1, 1, '�����', '��������', 1),
(1, 2, '����', '����� (0.5)', 2),
(2, 1, '�����', '������������', 2),
(2, 2, '�����', '������', 2),
(2, 3, '��� ������������', 'Rich', 1),
(3, 1, '����', '������� 3 (1)', 6),
(3, 2, '�������', '�������� ���', 3),
(3, 3, '�������', '������ ������', 2)
go

insert Customers values
(1, '�������� �����', '��. ����������, �. 12', '���. 55-66-77', null),
(2, '���������� ����', '��. ������, �. 30', '���. 11-22-33', null),
(3, '���������� ��������', '��. �������, �. 20', '45-67-89', '(077)555-11-41')
go

select * from Orders

select * from OrderInfo

select * from Customers

------------------------------------------------
-- ������ ���������� �����
--
-- ���������� ������������ ����������� �� �������� �������
-- �.�. � ������� ��� ������� ������ ���� �������� �������� �� �����, � �� ����� ������ �������

-- ����������
create table Employees(
	Id int,
	FullName nvarchar(200),
	Position nvarchar(20),
	Salary decimal(9,4) -- �������� ����������� ������� �� ���������
)
go

insert Employees values
(1, '����� �������', '������', 1000.00),
(2, '������� �������', '������', 1000.00),
(3, '��������� �����', '��������', 2000.00),
(4, '���� ��������', '���������', 1500.00)
go

select * from Employees

-----------------------------------
-- ����� ������ ������������ ����������� ��������� ������� � ������������ �� 2

drop table Employees
go

create table Employees(
	Id int,
	FullName nvarchar(100),
	PositionId int
);
go

insert Employees values
(1, '����� �������', 1),
(2, '������� �������', 1),
(3, '��������� �����', 2),
(4, '���� ��������', 3)
go

create table Salaries (
	Id int,
	Position nvarchar(100),
	Rate decimal(9,4)
)
go

insert Salaries values
(1, '������', 1000.00),
(2, '��������', 2000.00),
(3, '���������', 1500.00)
go

select * from Employees
go

select * from Salaries
go

select * from Employees
join Salaries on Employees.PositionId = Salaries.Id
go