-- https://otus.ru/nest/post/814/
-- Еще один пример с остатками товаров (книги)

create database tut_Merge_BooksExample
go

use tut_Merge_BooksExample
go

----------------------------------------------
-- Создаем таблицы с книгами

-- Основная таблица
create table BooksSales (
	Id int primary key,
	BookName nvarchar(100),
	SalesCount int
)
go

-- Таблица с обновлениями
create table BooksSalesUpdate (
	Id int primary key,
	BookName nvarchar(100),
	SalesCount int
)
go

-- drop table BooksSales
-- drop table BooksSalesUpdate

----------------------------------------------
-- Заполняем данные

insert into BooksSales
(Id, BookName, SalesCount)
values
(1, 'Игра престолов', 105),
(2, 'Гарри поттер', 50),
(5, 'Американсие боги', 30)
go

insert into BooksSalesUpdate
(Id, BookName, SalesCount)
values
(1, 'Игра престолов', 200),
(2, 'Гарри поттер', 100),
(3, 'Властелин колец', 30),
(4, 'Я робот', 20)
go

----------------------------------------------
-- Обновляем данные в основной таблице

merge BooksSales as [Target] -- основная таблица 
using BooksSalesUpdate as [Source] -- данные для обновления
on ([Target].Id = [Source].Id) -- связь по идентификатору
when matched then
	update set [Target].SalesCount = [Source].SalesCount -- обновляем (если совпали Id)
when not matched then
	insert values ([Source].Id, [Source].BookName, [Source].SalesCount) -- добавляем строку (если не нашли Id)
when not matched by source then
	delete -- удаляем (если есть лишний Id)
output	$action, inserted.*, deleted.*;