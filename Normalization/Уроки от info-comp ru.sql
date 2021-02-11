-- Первая номрмальная форма

-----------------------------------
-- Создаем новую БД
USE master
GO

CREATE DATABASE infoCompTutsDB
GO

USE infoCompTutsDB
GO

----------------------------------
-- Создаем не нормализованную таблицу

CREATE TABLE Employees(
	FullName varchar(max)
	,Contacts varchar(max)
)
GO

INSERT Employees VALUES
('Иванов И.И.', '123-456-789, 987-654-321')
,('Сергеев С.С.', 'Рабочий телефон 555-666-777, Домашний телефон 777-888-999')
,('John Smith', '123-456-789')
,('John Smith', '123-456-789')
GO

SELECT * FROM Employees
GO

----------------------------------
-- В таблице следующие проблемы
-- Есть дублирующиеся строки и есть списки значений в контактах

-- Чтобы привести к первой нормальной форм
-- Удаляем дубли
-- Список телефонов разбиваем на несколько строк, чтобы был 1 номер телефона
-- Тип телефона выносим в отдельную колонку

DROP TABLE Employees
GO

CREATE TABLE Employees(
	FullName varchar(max)
	,Phone varchar(20)
	,PhoneType varchar(20)
)
GO

INSERT Employees VALUES
('Иванов И.И.', '123-456-789', NULL)
,('Иванов И.И.', '987-654-321', NULL)
,('Сергеев С.С.', '123-456-789', 'Домашний телефон')
,('Сергеев С.С.', '123-456-789', 'Домашний телефон')
,('John Smith', '123-456-789', NULL)
GO

SELECT * FROM Employees