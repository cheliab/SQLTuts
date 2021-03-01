-- �������� ��������

create database tut_Index
go

use tut_Index
go

-----------------------------
-- PRIMARY KEY �� ��������� ������� "���������� ���������� ������"

create table Persons (
	Id int primary key,
	[Name] varchar(20)
);

create table Persons_v2 (
	Id int primary key nonclustered, -- ����� ������� �������� �� ����������� �������
	Name varchar(20)
);

-----------------------------
-- UNIQUE �� ��������� ������� "���������� ������������ ������"

create table Persons_Unique (
	Id int,
	[Name] varchar(20) unique
);

create table Person_Unique (
	Id int,
	[Name] varchar(20) unique clustered -- ����� ������� �������� ����������������� �������
);

------------------------------
-- CREATE INDEX
-- �� ��������� ��������� �� ���������� ������������ ������

create table SimpleIndex (Id int);

create index IX_SimpleIndex_Id -- �� ���������� ������������ ������
on SimpleIndex(Id);

--
create table UniqueIndex (Id int);

create unique index IX_UniqueIndex_Id  -- ���������� ������������ ������
on UniqueIndex(Id);

-- 
create table ClucteredIndex (Id int);

create clustered index IX_ClusteredIndex_Id -- �� ���������� ���������� ������
on ClucteredIndex(Id)

-- 
create table UniqueClusteredIndex (Id int);

create unique clustered index IX_UniqueClusteredIndex_Id -- ���������� ���������������� ������
on UniqueClusteredIndex(Id);

--------------------------------------------------

IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Persons'))
BEGIN;
    DROP TABLE [Persons];
END;
GO

CREATE TABLE [Persons] (
    [Id] INTEGER NOT NULL IDENTITY(1, 1),
    [ZipCode] VARCHAR(10) NULL,
    [Date] VARCHAR(255),
    [Name] VARCHAR(255) NULL
);
GO

INSERT INTO Persons([ZipCode],[Date],[Name]) VALUES('53397','10/05/90','Yoshio'),('2973','02/06/92','Remedios'),('567800','08/13/91','Tyler'),('659800','04/04/90','Tobias'),('25337','09/14/91','Bryar'),('55161','05/25/90','Charles'),('08004','06/27/90','Ciaran'),('76196','03/16/90','Victoria'),('02000','03/20/90','Mohammad'),('8976 WW','01/03/92','Herman'),('343849','06/30/90','Vladimir'),('Z7368','07/14/91','Jada'),('7910 OJ','04/22/90','Lev'),('6921','01/03/92','Harper'),('1623 LE','02/04/92','Alice'),('Z6431','06/28/90','Leila'),('18840','04/02/91','Galena'),('39996-972','02/08/91','Elliott'),('X7A 1P3','04/30/90','Roanna'),('30687','08/18/91','Chester');

--------------------------------------------------
-- ��� ������� ����������� ������� ������������ �������

select * from Persons -- ������������

select * from Persons
where [Name] = 'Elliott' -- ��� �� ������������

-- ������� ���������������� ������ �� ������� Name

create clustered index IX_CL_Persons_Name
on Persons([Name])

----------------------------------------------
-- ������ ����������� ������������ �������

select * from Persons

-- � ����� �� �������

select * from Persons
where [Name] = 'Elliott'