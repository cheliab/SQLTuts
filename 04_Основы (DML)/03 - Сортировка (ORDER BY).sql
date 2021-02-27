-- ����������. ORDER BY

--create database tut_OrderBy
--go

--use tut_OrderBy
--go

--create table Products
--(
--	Id int identity primary key,
--	ProductName nvarchar(30) not null,
--	Manufacturer nvarchar(20) not null,
--	ProductCount int default 0,
--	Price money not null
--)

--insert into Products
--values
--('iPhone 6', 'Apple', 3, 36000),
--('iPhone 6S', 'Apple', 2, 41000),
--('iPhone 7', 'Apple', 5, 52000),
--('Galaxy S8', 'Samsung', 2, 46000),
--('Galaxy S8 Plus', 'Samsung', 1, 56000),
--('Mi6', 'Xiaomi', 5, 28000),
--('OnePlus 5', 'OnePlus', 6, 38000)

-------------------------------------------------------
--  ���������� �� ������ �������

select * 
from Products 
order by ProductName

select * 
from Products
order by Price

-------------------------------------------------------
--  ���������� �� ���������� (AS)

select ProductName, ProductCount * Price as TotalSum
from Products
order by TotalSum

-------------------------------------------------------
--  ���������� �� �������� (desc/asc)

select ProductName
from Products
order by ProductName DESC 

select ProductName
from Products
order by ProductName ASC -- ASC ������������ �� ���������

-------------------------------------------------------
--  ���������� �� ���������� ��������

select Manufacturer, ProductName, Price 
from Products
order by Manufacturer, ProductName

-------------------------------------------------------
--  ���������� �� ���������� �������� � ������ �����������

select Manufacturer, ProductName, Price 
from Products
order by Manufacturer asc, ProductName desc

-------------------------------------------------------
--  ���������� �� ���������

select ProductName, ProductCount, ProductCount * Price
from Products
order by ProductCount * Price