-- Создание индексов

create database tut_Index
go

use tut_Index
go

-----------------------------
-- PRIMARY KEY по умолчанию создает "уникальный кластерный индекс"

create table Persons (
	Id int primary key,
	[Name] varchar(20)
);

create table Persons_v2 (
	Id int primary key nonclustered, -- можно указать создание не кластерного индекса
	Name varchar(20)
);

-----------------------------
-- UNIQUE по умолчанию создает "уникальный некластерный индекс"

create table Persons_Unique (
	Id int,
	[Name] varchar(20) unique
);

create table Person_Unique (
	Id int,
	[Name] varchar(20) unique clustered -- можно указать создание кластеризованного индекса
);

------------------------------
-- CREATE INDEX
-- По умолчанию создается не уникальный некластерный индекс

create table SimpleIndex (Id int);

create index IX_SimpleIndex_Id -- не уникальный некластерный индекс
on SimpleIndex(Id);

--
create table UniqueIndex (Id int);

create unique index IX_UniqueIndex_Id  -- уникальный некластерный индекс
on UniqueIndex(Id);

-- 
create table ClucteredIndex (Id int);

create clustered index IX_ClusteredIndex_Id -- не уникальный кластерный индекс
on ClucteredIndex(Id)

-- 
create table UniqueClusteredIndex (Id int);

create unique clustered index IX_UniqueClusteredIndex_Id -- уникальный кластеризованный индекс
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
-- без индекса выполняется простое сканирование таблицы

select * from Persons -- Сканирование

select * from Persons
where [Name] = 'Elliott' -- Так же сканирование

-- добавим кластеризованный индекс на колонку Name

create clustered index IX_CL_Persons_Name
on Persons([Name])

----------------------------------------------
-- теперь выполняется сканирование индекса

select * from Persons

-- и поиск по индексу

select * from Persons
where [Name] = 'Elliott'