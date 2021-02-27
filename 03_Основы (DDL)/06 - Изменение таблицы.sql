-- ��������� �������

create database dbAlterTut;
go

use dbAlterTut;
go

----------------------------

create table Customers
(
	Id int,
	Age int,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Email varchar(30),
	Phone varchar(20)
)

USE [dbAlterTut]
GO

--INSERT INTO [dbo].[Customers]
--           ([Age]
--           ,[FirstName]
--           ,[LastName]
--           ,[Email]
--           ,[Phone]
--           ,[Address])
--     VALUES
--           (20
--           ,'�����'
--           ,'��������'
--           ,'test'
--           ,'test'
--           ,'test')
--GO

----------------------------
-- ���������� ������ �������

alter table Customers
add [Address] nvarchar(50) null;

alter table Customers
drop column [Address];

----------------------------

alter table Customers
add [Address] nvarchar(50) not null; --  �� ���������� ���� � ������� ���� ������

alter table Customers
drop column [Address];

----------------------------

alter table Customers
add [Address] nvarchar(50) not null default '' -- ����������

----------------------------
-- ��������� ���� �������

alter table Customers
alter column FirstName nvarchar(200);

----------------------------
-- ���������� �����������

alter table Customers
add check (Age > 21); -- ���� ���� ������ �� ���������� �� �������, �� �� ����������

alter table Customers with nocheck -- ��������� �������� ��� ��������
add check (Age > 21);

----------------------------
-- �������� �����������

alter table Customers
drop [CK__Customers__Age__37A5467C]

-----------------------------
-- ���������� �������� �����

--drop table Customers;

create table Customers
(
	Id INT PRIMARY KEY IDENTITY,
    Age INT DEFAULT 18, 
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    Email VARCHAR(30) UNIQUE,
    Phone VARCHAR(20) UNIQUE
)

create table Orders
(
	Id INT IDENTITY,
    CustomerId INT,
    CreatedAt Date
)


alter table Orders
add foreign key(CustomerId) references Customers(id);

---------------------------------------
-- ���������� ���������� �����

alter table Orders
add primary key (Id);

alter table Orders
drop [PK__Orders__3214EC07C52E4921], [FK__Orders__Customer__4222D4EF];

--alter table Customers
--drop 

---------------------------------------
-- ����������� � �������

alter table Orders
add constraint PK_Orders_Id primary key (Id),
    constraint FK_Orders_To_Cutomers foreign key(CustomerId) references Customers(Id);

alter table Customers
add constraint CK_Age_Greater_Than_Zero check (Age > 0);