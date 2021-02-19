-- ���������� �����

create database tut_Insert
go

use tut_Insert
go

create table Products
(
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price money not null
)

----------------------------------------
-- ���������� ������ (��� ��������� ���������)

insert Products values
('iPhone 7', 'Apple', 5, 5200) -- ����� ������������ ������� �������� �� create table

select * from Products

----------------------------------------
-- ���������� ������ (c ���������� ���������)

insert Products (ProductName, Price, Manufacturer)
values
('iPhone 6S', 41000, 'Apple') -- ��� �� ��������� �������� ������������ null ��� default ��������

select * from Products

----------------------------------------
-- ���������� ���������� �����

insert Products
values
('iPhone 6', 'Apple', 3, 36000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000)

select * from Products

----------------------------------------
-- ���������� ���������� �����