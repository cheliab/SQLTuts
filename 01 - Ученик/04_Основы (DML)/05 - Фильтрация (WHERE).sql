-- ����������. WHERE

create database tut_Where
go

use tut_Where
go

create table Products
(
	Id int identity primary key,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(20) not null,
	ProductCount int default 0,
	Price decimal(19, 4) not null
)

insert into Products
values
('iPhone 6', 'Apple', 3, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi6', 'Xiaomi', 5, 28000),
('OnePlus 5', 'OnePlus', 6, 38000)



select * from Products

-------------------------------------------------
-- ���� =

select * from Products
where Manufacturer = 'Samsung'

select * from Products
where Manufacturer = 'samsung' -- ������� �� ����� ��������

select * from Products
where Manufacturer = 'SAMSUNG' -- ������� �� ����� ��������

-------------------------------------------------
-- ���� >

select * from Products
where Price > 45000

select * from Products
where Price * ProductCount > 200000 -- ����� ������������ ���������

-------------------------------------------------
-- ���������� ��������� (AND OR NOT)

-- AND
select * from Products
where Manufacturer = 'samsung' and Price > 50000

-- OR
select * from Products
where Manufacturer = 'samsung' or Price > 50000

-- NOT
select * from Products
where not Manufacturer = 'samsung'

select * from Products
where Manufacturer <> ' samsung' -- ������� �������� not

-- ��������� ���������� ����������
select * from Products
where Manufacturer = 'samsung' or Price > 30000 and ProductCount > 2 -- ������� ����������� and ����� or

-- ������������� ������
select * from Products
where (Manufacturer = 'samsung' or Price > 30000) and ProductCount > 2 -- ������ �������������� �������

-- IS NULL

alter table Products
drop constraint [DF__Products__Produc__37A5467C];

insert into  Products
values
('iPhone 8', 'Apple', null, 52000)

select * from Products
where ProductCount is null

select * from Products
where ProductCount is not null

-------------------------------------------------
-- ��������� ����������

-- �������� IN

select * from Products
where Manufacturer in ('samsung', 'xiaomi', 'huawei') -- ���������� ������������� ���������� or

select * from Products
where Manufacturer = 'samsung' or manufacturer = 'xiaomi' or manufacturer = 'huawei' -- ����� �������� �� in

-- NOT IN
select * from Products
where Manufacturer not in ('samsung', 'xiaomi', 'huawei')

-- �������� BETWEEN

select * from Products
where Price between 20000 and 40000

select * from Products
where Price not between 20000 and 40000

select * from Products
where Price * ProductCount between 100000 and 200000 -- ���������

-- �������� LIKE

-- "%" - ����� ���������� �������� (����� � �� ���� ��������)
-- "_" - ��������� ������
-- "[ ]" - ���� ������ ��������� � �������
-- "[ - ]" - ���� ������ �� ���������
-- "[ ^ ]" - ��������� ������ �� ������

--insert into Products
--values
--('Galaxy Ace 2', 'Samsung', 3, 40000),
--('Galaxy S7', 'Samsung', 8, 45000)

--insert into Products
--values
--('Galaxy S6', 'Samsung', 2, 47000)

select * from Products
where ProductName like 'Galaxy%' -- ����� �������� ��� ������� ���� "Galaxy"

select * from Products
where ProductName like 'Galaxy S_' -- ������ ����� "S" ����� ���� �����

select * from Products
where ProductName like 'iPhone [78]' -- � ����� �������� ����� ���� 7 � 8 

select * from Products
where ProductName like 'iPhone [5-8]' -- � ����� ����� ���� 5, 6, 7, 8

select * from Products
where ProductName like 'iPhone [^7]%' -- ��� ������ ����� 7 � 7S

select * from Products
where ProductName like 'iPhone [^1-6]%' -- ��������� �������� ������� �� 1 �� 6

select * from Products
where ProductName like 'iPhone [6-8]%' -- ������� ��� ������ � 6 �� 8