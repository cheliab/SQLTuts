create database tut_Transaction
go

use tut_Transaction
go

-------------------------------------------

-- Создаем таблицу теннисных кортов
create table Courts (
	[Id] int primary key identity,
	[Name] nvarchar not null,
	[City] nvarchar not null,
	[Capacity] int default 0,
	[Surface] nvarchar not null
)
go

-- Варианты покрытий
-- Грунт
-- Трава
-- Твердое

insert into Courts
values
('Центральный корт', 'Лондон', 15916, 'Трава'),
('Стадион Льюиса Армстронга', 'Нью Йорк', 14000, 'Твердое'),
('Стадион Артура Аше', 'Нью Йорк', 23771, 'Твердое'),
('Арена Род Лавер', 'Мельбурн', 14820, 'Твердое'),
('Арена Маргарет Курт', 'Мельбурн', 7500, 'Твердое')