create database metanit_LocalVariables
go

use metanit_LocalVariables
go

---------------------------------------------------------

create table Person (
	Id int identity,
	FirstName nvarchar(30)
)

insert into Person 
values
('Макс'),
('Павел')

insert into Person 
values
('Вика'),
('Дима'),
('Леша')

---------------------------------------------------------

declare @name varchar(10);
print isnull(@name, 'NULL'); -- по умолчанию значение переменной NULL

declare @age smallint = 2;
print @age;

-- SET

set @name = 'Elijah';
print @name;

-- GO

declare @fullname varchar(10) = 'Pavel Berezkin';
go -- переменная существует только в рамках одного пакета (при вызове переменной после GO уже будет ошибка)

print isnull(@fullname, 'NULL'); -- возникнет ошибка, переменной @fullname уже нет

-- SELECT

declare @name nvarchar(30);

select @name = 'Макс' -- Также можно использовать оператор SELECT для присвоения значения переменной 

print @name
go

-- SELECT ... FROM

declare @name nvarchar(30)

select @name = FirstName from Person where Id = 2 -- Можно получить зачение из таблицы

print @name

select @name = FirstName from Person -- Если не указываем условие, то будет присвоено значение из последней строки

print @name