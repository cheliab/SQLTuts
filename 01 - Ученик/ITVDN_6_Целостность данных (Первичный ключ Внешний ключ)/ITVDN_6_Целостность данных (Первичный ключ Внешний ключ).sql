CREATE DATABASE ITVDN_6_DataIntegrity
GO

USE ITVDN_6_DataIntegrity
GO

-----------------------------------------------------------
-- Доменная целостность (domain integrity)
-- Типы данных
-- CHECK
-- NOT NULL
-- FOREIGN KEY
-- DEFAULT

IF OBJECT_ID('Employees') IS NOT NULL
	DROP TABLE Employees
GO

CREATE TABLE Employees(
	Id int IDENTITY NOT NULL
	,FName varchar(50)
	,LName varchar(50)
	,Phone char(15) CONSTRAINT CK_Employees_Phone CHECK (Phone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
	,Salary decimal(10,4)
	,Bonus decimal(10,4)
)

-- CHECK
INSERT Employees
VALUES
--('Alex', 'Po', '(000)100-20-30', 1000, 200) -- строка с ошибкой в номере телефона
('Alex', 'Po', '(000) 100-20-30', 1000, 200) -- правильная строка
GO

-- Вставка ограничения без проверки
ALTER TABLE Employees WITH NOCHECK -- Убираем проверку уже введеных данных
ADD CONSTRAINT CK_Employees_Bonus
CHECK (Bonus <= Salary * 0.1)

-- Вставка колонки с ограничением
ALTER TABLE Employees
ADD Sex varchar(6) CONSTRAINT CK_Employees_Sex CHECK(Sex IN('male', 'female', 'm', 'f')) -- добавляем колонку с ограничением

-- Вставка строки (значение из списка)
INSERT Employees
VALUES
--('Pavel', 'Be', '(000) 111-22-33', 1000, 50, 'asd')
('Pavel', 'Be', '(000) 111-22-33', 1000, 50, 'm')
GO

-- Удаление ограничения
ALTER TABLE Employees
DROP CONSTRAINT CK_Employees_Sex