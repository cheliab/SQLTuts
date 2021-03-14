-- Атрибуты и ограничения столбцов и таблиц

--create database newDB;
--GO

--use newDB;
--GO

-----------------------------------------------------------------
-- PRIMARY KEY - первичный ключ

 create table Customers_ColumnPK
 (
	Id int primary key, -- первичный ключ в колонке
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
	primary key (Id) -- первичный ключ на уровне таблицы
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
-- IDENTITY - идентификатор

create table Customers_Identity
(
	Id int primary key identity, -- при добавлении строки значение увеличивается на 1
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30),
	Phone varchar(20)
)

-----------------------------------------------------------------
-- UNIQUE - уникальное значение

create table Customers_Unique
(
	Id int primary key identity,
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30) unique, -- уникальное значение
	Phone varchar(20) unique -- уникальное значение
)

-----------------------------------------------------------------
-- NULL / NOT NULL - нет значения

create table Customers_NULL
(
	Id int primary key identity,
	Age int,
	FirstName nvarchar(20) not null, -- обязательное значение
	LastName nvarchar(20) not null, -- обязательное значение
	Email varchar(30) unique,
	Phone varchar(20) unique
)

-----------------------------------------------------------------
-- DEFAULT - значение по умолчанию

create table Customers_Default
(
	Id int primary key identity,
	Age int default 18, -- без значения заполнится 18
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(30) unique,
	Phone varchar(20) unique
)

-----------------------------------------------------------------
-- CHECK - ограничение значений

create table Customers_Check
(
	Id int primary key identity,
	Age int default 18 check(Age > 0 AND Age < 100), -- проверка на корректный возраст
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(20) unique check(Email != ''), -- проверка на пустую строку
	Phone varchar(20) unique check(Phone != '') -- проверка на пустую строку
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
-- CONSTRAINT - ограничение значений

-- Рекомендуемы префиксы --
--"PK_" - для PRIMARY KEY
--"FK_" - для FOREIGN KEY
--"CK_" - для CHECK
--"UQ_" - для UNIQUE
--"DF_" - для DEFAULT

 create table Customers_Constraint_Column
 (
	Id int primary key identity,
	Age int 
		constraint DF_Customer_Age default 18 -- задаем имя на уровне колонки
		constraint CK_Customer_Age check(Age > 0 and Age < 100), -- задаем имя на уровне колонки
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
	constraint PR_Customer_Id primary key(Id), -- задаем имя на уровне таблицы
	constraint CK_Customer_Age check(Age > 0 and Age < 100),
	constraint UQ_Customer_Email unique(Email),
	constraint UQ_Customer_Phone unique(Phone)
 )