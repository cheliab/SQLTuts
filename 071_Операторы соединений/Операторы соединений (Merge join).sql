-- ������ �� ������������ ���������� (MERGE JOIN)

create database tut_MergeJoin
go

use tut_MergeJoin
go

DROP TABLE IF EXISTS T1;
GO
CREATE TABLE T1 (Id int identity PRIMARY KEY, Col1 CHAR(1000));
GO

INSERT INTO T1 VALUES('');
GO

DROP TABLE IF EXISTS T2;
GO
CREATE TABLE T2 (Id int identity PRIMARY KEY, Col1 CHAR(1000));
GO

INSERT INTO T2 VALUES('');
GO 100

-- Turn on execution plans and check actual rows for T2

-- � ������ ������� ����� ����������� 1 ������ �� T1 � 1 ������� �� T2  
SELECT *
FROM T1 INNER LOOP JOIN T2 ON T1.Id = T2.Id;

-- � ������ ������� ����� ����������� 1 ������ �� T1 � 100 �������� �� T2  
SELECT *
FROM T1 INNER MERGE JOIN T2 ON T1.Id = T2.Id;