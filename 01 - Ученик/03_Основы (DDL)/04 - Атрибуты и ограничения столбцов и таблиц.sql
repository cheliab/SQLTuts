-- �������� � ����������� �������� � ������

--create database newDB;
--GO

--use newDB;
--GO

-----------------------------------------------------------------
-- PRIMARY KEY - ��������� ����

 create table Customers_ColumnPK
 (
	Id int primary key, -- ��������� ���� � �������
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30),
	Phone varchar(20)
 )

create table Customers_TablePK
(
	Id int,
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30),
	Phone varchar(20),
	primary key (Id) -- ��������� ���� �� ������ �������
)

create table OrderLines
(
	OrderId int,
	ProductId int,
	Quantity int,
	Price money,
	primary key(OrderId, ProductId)
)

-----------------------------------------------------------------
-- IDENTITY - �������������

create table Customers_Identity
(
	Id int primary key identity, -- ��� ���������� ������ �������� ������������� �� 1
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30),
	Phone varchar(20)
)

-----------------------------------------------------------------
-- UNIQUE - ���������� ��������

create table Customers_Unique
(
	Id int primary key identity,
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30) unique, -- ���������� ��������
	Phone varchar(20) unique -- ���������� ��������
)

-----------------------------------------------------------------
-- NULL / NOT NULL - ��� ��������

create table Customers_NULL
(
	Id int primary key identity,
	Age int,
	FirstName nvarchar(20) not null, -- ������������ ��������
	LastName nvarchar(20) not null, -- ������������ ��������
	Email varchar(30) unique,
	Phone varchar(20) unique
)

-----------------------------------------------------------------
-- DEFAULT - �������� �� ���������

create table Customers_Default
(
	Id int primary key identity,
	Age int default 18, -- ��� �������� ���������� 18
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(30) unique,
	Phone varchar(20) unique
)

-----------------------------------------------------------------
-- CHECK - ����������� ��������

create table Customers_Check
(
	Id int primary key identity,
	Age int default 18 check(Age > 0 AND Age < 100), -- �������� �� ���������� �������
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(20) unique check(Email != ''), -- �������� �� ������ ������
	Phone varchar(20) unique check(Phone != '') -- �������� �� ������ ������
)

 create table Customers_Check_TblVar
 (
	Id int primary key identity,
	Age int default 18,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(20) unique,
	Phone varchar(20) unique,
	check((Age > 0 and Age < 100) and (Email != '') and (Phone != ''))
 )

-----------------------------------------------------------------
-- CONSTRAINT - ����������� ��������

-- ������������ �������� --
--"PK_" - ��� PRIMARY KEY
--"FK_" - ��� FOREIGN KEY
--"CK_" - ��� CHECK
--"UQ_" - ��� UNIQUE
--"DF_" - ��� DEFAULT

 create table Customers_Constraint_Column
 (
	Id int primary key identity,
	Age int 
		constraint DF_Customer_Age default 18 -- ������ ��� �� ������ �������
		constraint CK_Customer_Age check(Age > 0 and Age < 100), -- ������ ��� �� ������ �������
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(20) unique,
	Phone varchar(20) unique
 )

 create table Customers_Constraint_Table
 (
	Id int identity,
	Age int constraint DF_Csutomer_Age default 18,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(30),
	Phone varchar(20),
	constraint PR_Customer_Id primary key(Id), -- ������ ��� �� ������ �������
	constraint CK_Customer_Age check(Age > 0 and Age < 100),
	constraint UQ_Customer_Email unique(Email),
	constraint UQ_Customer_Phone unique(Phone)
 )