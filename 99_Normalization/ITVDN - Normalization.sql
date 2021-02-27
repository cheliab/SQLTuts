USE master
GO

CREATE DATABASE pizzeriaDB
GO

USE pizzeriaDB
GO

----------------------------------
-- Создаем не нормальизованную таблицу
-- Которую в дальнейшем будем приводить к нормальному виду

/*
CREATE TABLE pizzariaData(
	OrderNo int
	,[Date] date
	,Customer varchar(100)
	,CustomerData varchar(max)
	,OrderInfo varchar(max)
	,Courier varchar(100)
)

INSERT pizzariaData VALUES
(1, '20170407', 'Tone Wang', 'Sportivnaya srt., 15, ap.4, tel. 3-15-64', 'Pepperoni pizza - 1, beer SA - 2 (0.5)', 'Norma Mortenson')
,(2, '20170407', 'Any Yang', 'Schevchnko av., 2, ap.17, tel. 3-22-81', 'Veggi pizza - 3, Caesar salad - 4', 'Norma Mortenson')
,(3, '20170408', 'Cheng Tsui', 'Gagarin str., 80, ap.26, tel. 3-25-70, mob. (077)444-15-17', 'beer B Premium - 10 (0.5), Meat pizza - 2, Cheese pizza - 3', 'Cassius Clay')
GO

SELECT * FROM pizzariaData
GO
*/
----------------------------------
-- Пересоздаем таблицу чтобы вести данные заказчика в отдельные колонки
-- чтобы согласно первой нормальной форме в таблице на пересечении колонки и столбца было 1 значение
DROP TABLE pizzariaData
GO

CREATE TABLE pizzariaData(
	OrderNo int
	,[Date] date
	,Customer varchar(100)
	,CustomerAddress varchar(max)
	,CustomerPhone varchar(15)
	,CustomerMob varchar(15)
	,Product1 varchar(20)
	,Qty1 tinyint
	,Product2 varchar(20)
	,Qty2 tinyint
	,Product3 varchar(20)
	,Qty3 tinyint
	,Courier varchar(100)
)

INSERT pizzariaData VALUES
(1, '20170407', 'Tone Wang', 'Sportivnaya srt., 15, ap.4', '3-15-64', NULL, 'Pepperoni pizza', 1, 'beer SA', 2, null, null, 'Norma Mortenson')
,(2, '20170407', 'Any Yang', 'Schevchnko av., 2, ap.17', '3-22-81', NULL, 'Veggi pizza', 3, 'Caesar salad', 4, null, null, 'Norma Mortenson')
,(3, '20170408', 'Cheng Tsui', 'Gagarin str., 80, ap.26', '3-25-70', '(077)444-15-17', 'beer B Premium', 10, 'Meat pizza', 2, 'Cheese pizza', 3, 'Cassius Clay')
GO

-------------------------------------------------------
-- Следующая проблема в столбцах с продуктами
-- для новых заказов нужны новые колонки, 
-- нужно переделать так чтобы не нужно было добавлять колонки

DROP TABLE pizzariaData
GO

CREATE TABLE pizzariaData(
	OrderNo int
	,OrderItem int
	,[Date] date
	,Customer varchar(100)
	,CustomerAddress varchar(max)
	,CustomerPhone varchar(15)
	,CustomerMob varchar(15)
	,Product varchar(20)
	,ProductName varchar(20)
	,Qty tinyint
	,Courier varchar(100)
)

INSERT pizzariaData VALUES
(1, 1, '20170407', 'Tone Wang', 'Sportivnaya srt., 15, ap.4', '3-15-64', NULL, 'pizza', 'Pepperoni', 1, 'Norma Mortenson')
,(1, 2, '20170407', 'Tone Wang', 'Sportivnaya srt., 15, ap.4', '3-15-64', NULL, 'beer', ' SA', 2, 'Norma Mortenson')
,(2, 1, '20170407', 'Any Yang', 'Schevchnko av., 2, ap.17', '3-22-81', NULL, 'pizza', 'Veggi', 3, 'Norma Mortenson')
,(2, 2, '20170407', 'Any Yang', 'Schevchnko av., 2, ap.17', '3-22-81', NULL, 'salad', 'Caesar', 4, 'Norma Mortenson')
,(3, 1, '20170408', 'Cheng Tsui', 'Gagarin str., 80, ap.26', '3-25-70', '(077)444-15-17', 'beer', 'B Premium', 10, 'Cassius Clay')
,(3, 2, '20170408', 'Cheng Tsui', 'Gagarin str., 80, ap.26', '3-25-70', '(077)444-15-17', 'pizza', 'Meat', 2, 'Cassius Clay')
,(3, 3, '20170408', 'Cheng Tsui', 'Gagarin str., 80, ap.26', '3-25-70', '(077)444-15-17', 'pizza', 'Cheese', 3, 'Cassius Clay')
GO

SELECT * FROM pizzariaData
WHERE CustomerAddress LIKE '%Schevchnko%'

----------------------------------------------------------
-- Приводим таблицу ко второй нормальной форме
-- Для этого разбивает ее на 3
-- В каждой из таблиц будет первичный ключ и только те данные, которые его описывают

DROP TABLE pizzariaData
GO

CREATE TABLE Orders(
	OrderNo int
	,[Date] date
	,CustumerId int
	,Courier varchar(100)
)
GO

CREATE TABLE OrderInfo(
	OrderNo int
	,OrderItem int
	,Product varchar(20)
	,ProductName varchar(20)
	,Qty tinyint
)
GO

CREATE TABLE Custumers(
	Id int
	,FullName varchar(100)
	,CustomerAddress varchar(max)
	,CustomerPhone varchar(15)
	,CustomerMob varchar(15)
)
GO

INSERT Orders VALUES 
(1, '20170407', 1, 'Norma Mortenson')
,(2, '20170407', 1, 'Norma Mortenson')
,(3, '20170408', 1, 'Cassius Clay')
GO

INSERT OrderInfo VALUES 
(1, 1, 'pizza', 'Pepperoni', 1)
,(1, 2, 'beer', ' SA', 2)
,(2, 1, 'pizza', 'Veggi', 3)
,(2, 2, 'salad', 'Caesar', 4)
,(3, 1, 'beer', 'B Premium', 10)
,(3, 2, 'pizza', 'Meat', 2)
,(3, 3, 'pizza', 'Cheese', 3)
GO

INSERT Custumers VALUES
(1, 'Tone Wang', 'Sportivnaya srt., 15, ap.4', '3-15-64', NULL)
,(2, 'Any Yang', 'Schevchnko av., 2, ap.17', '3-22-81', NULL)
,(3, 'Cheng Tsui', 'Gagarin str., 80, ap.26', '3-25-70', '(077)444-15-17')
GO

SELECT * FROM Orders
GO

SELECT * FROM OrderInfo
GO

SELECT * FROM Custumers
GO

---------------------------------------------
-- Нормализация к 3 форме
-- Создаем 2 доп. таблицы

CREATE TABLE Employees(
	Id int
	,FullName varchar(100)
	,Position varchar(20)
	,Salary decimal(9,4)
)
GO

INSERT Employees VALUES
(1, 'Norma Mortenson', 'courier', 1000.00)
,(2, 'Cassius Clay', 'courier', 1000.00)
,(3, 'Samuel Clemens', 'chief manager', 2000.00)
,(4, 'Anna Gorenko', 'accountant', 1500.00)
GO

----------------------------------------------
-- Проблема в таблице, что зарплата(Salary) зависит от должности(Position)
-- Если нужно будет изменить зарплату у курьера(courier), 
-- то нужно будет обновить все строки с данной должностью
-- Для решения этой проблемы нужно разделить таблицу на две
-- Одна с сотрудниками(Employess) и вторая с должностями и зарплатами(Salaries)

DROP TABLE Employees
GO

CREATE TABLE Employees(
	Id int
	,FullName varchar(100)
	,Posotion int
)
GO

INSERT Employees VALUES
(1, 'Norma Mortenson', 1)
,(2, 'Cassius Clay', 1)
,(3, 'Samuel Clemens', 2)
,(4, 'Anna Gorenko', 3)
GO

CREATE TABLE Salaries(
	Id int
	,Position varchar(100)
	,Rate decimal(9,4)
)
GO

INSERT Salaries VALUES
(1, 'courier', 1000.00)
,(2, 'chief manager', 2000.00)
,(3, 'acoountant', 1500.00)
GO

SELECT * FROM Employees
GO

SELECT * FROM Salaries
GO