-- Вторая нормальная форма
-- Условия:
-- Таблица должна находиться в первой нормальной форме
-- Таблица должна иметь ключ
-- Все неключевые столбцы таблицы должны зависеть от полного ключа (в случае если он составной)

-----------------------------------
-- Создаем новую БД
USE master
GO

CREATE DATABASE infoCompTutsDB
GO

USE infoCompTutsDB
GO

----------------------------------
-- Создаем таблицу в первой нормальной форме

DROP TABLE Employees
GO

CREATE TABLE Employees(
	FullName varchar(max)
	,Position varchar(max)
	,Department varchar(max)
	,DepartmentDescription varchar(max)
)
GO

INSERT Employees VALUES
('Иванов И.И.', 'Программист', 'Отдел разработки', 'Разработка и сопровождение приложений и сайтов')
,('Сергеев С.С.', 'Бухгалтер', 'Бухгалтерия', 'Ведение бухгалтерского и налогового учета финансово-хозяйственной деятельности')
,('John Smith', 'Продавец', 'Отдел реализации', 'Организация сбыта продукции')
GO

SELECT * FROM Employees
GO

-- Таблица в первой нормальной форме
-- Нет дублирующихся строк
-- Значения атомарны
-------------------------------------

-------------------------------------
-- Для перевода во вторую форму нужно 
-- добавить первичный ключ в таблицу

DROP TABLE Employees
GO

CREATE TABLE Employees(
	PersonnelNumber int NOT NULL
	,FullName varchar(max)
	,Position varchar(max)
	,Department varchar(max)
	,DepartmentDescription varchar(max)
	,CONSTRAINT PK_PersonnelNumber PRIMARY KEY CLUSTERED (PersonnelNumber)
)
GO

INSERT Employees VALUES
(1, 'Иванов И.И.', 'Программист', 'Отдел разработки', 'Разработка и сопровождение приложений и сайтов')
,(2, 'Сергеев С.С.', 'Бухгалтер', 'Бухгалтерия', 'Ведение бухгалтерского и налогового учета финансово-хозяйственной деятельности')
,(3, 'John Smith', 'Продавец', 'Отдел реализации', 'Организация сбыта продукции')
GO

SELECT * FROM Employees
GO

-- Так как первичный ключ не составной, 
-- то таблица становится автоматически второй нормальной формы
-- третье условие нужно только для составного ключа
------------------------------------------

------------------------------------------
-- Приведение ко второй нормальной форме таблицы с составным ключом
-- Условие: Все неключевые столбцы таблицы должны зависеть от полного ключа 
--(в случае если он составной)

-- У нас есть таблица в первой нормальной форме
CREATE TABLE Projects(
	ProjectName varchar(max)
	,Participant varchar(max)
	,Position varchar(max)
	,ProjectTermMonth int
)
GO

INSERT Projects VALUES
('Внедрение приложения', 'Иванов И.И.', 'Программист', 8)
,('Внедрение приложения', 'Сергеев С.С.', 'Бухгалтер', 8)
,('Внедрение приложения', 'John Smith', 'Менеджер', 8)
,('Открытие нового магазина', 'Сергеев С.С.', 'Бухгалтер', 12)
,('Открытие нового магазина', 'John Smith', 'Менеджер', 12)
GO

--------------------------------------------------------
-- Для перехода во вторую нормальную форму
-- Добавляем в таблицу первичый ключ 

DROP TABLE Projects
GO

CREATE TABLE Projects(
	ProjectName varchar(max) NOT NULL
	,Participant varchar(max) NOT NULL
	,Position varchar(max)
	,ProjectTermMonth int
	,CONSTRAINT PK_ProjectName_Participant PRIMARY KEY CLUSTERED (ProjectName, Participant)
)
GO

-- Но есть проблема не ключевые поля относятся к разным частям первичногок ключа
-- "Должность" отностися к "сотруднику"
-- "Срок проекта (мес.)" относится к "проекту"
-- чтобы таблица стала 2 формы нужно разбить ее на несколько 
-- Проекты, Участники и их связь

DROP TABLE Projects
GO

DROP TABLE Particiants
GO

DROP TABLE ParticipationInProjects
GO

CREATE TABLE Projects(
	ID int NOT NULL   -- Идентификатор проекта
	,[Name] varchar(max)            -- Название проекта
	,TermMonth int                  -- Срок проекта (мес.)
	,CONSTRAINT PR_Projects_ID PRIMARY KEY CLUSTERED (ID)
)
GO

CREATE TABLE Particiants(
	ID int NOT NULL
	,FullName varchar(max)
	,Position varchar(max)
	,CONSTRAINT PR_Particiants_ID PRIMARY KEY CLUSTERED (ID)
)
GO

CREATE TABLE ParticipationInProjects(
	ProjectID int NOT NULL,
	ParticiantID int NOT NULL
)
GO

INSERT Projects VALUES
(1, 'Внедрение приложения', 8)
,(2, 'Открытие нового магазина', 12)
GO

INSERT Particiants VALUES
(1, 'Иванов И.И.', 'Программист')
,(2, 'Сергеев С.С.', 'Бухгалтер')
,(3, 'John Smith', 'Менеджер')
GO

INSERT ParticipationInProjects VALUES
(1,1)
,(1,2)
,(1,3)
,(2,2)
,(2,3)
GO

SELECT * FROM Projects
GO

SELECT * FROM Particiants
GO

SELECT * FROM ParticipationInProjects
GO