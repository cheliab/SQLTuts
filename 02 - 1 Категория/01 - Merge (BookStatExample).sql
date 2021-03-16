-- Еще один пример с остатками товаров (книги)

create database tut_Merge_BooksExample
go

use tut_Merge_BooksExample
go

----------------------------------------------

create table BooksSales (
	Id int primary key,
	BookName nvarchar(100),
	SalesCount int
)
go

create table BooksSalesUpdate (
	Id int primary key,
	BookName nvarchar(100),
	SalesCount int
)
go

drop table BooksSales
drop table BooksSalesUpdate

----------------------------------------------

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

merge BooksSales as [Target]
using BooksSalesUpdate as [Source]
on ([Target].Id = [Source].Id)
when matched then
	update set [Target].SalesCount = [Source].SalesCount
when not matched then
	insert values ([Source].Id, [Source].BookName, [Source].SalesCount)
when not matched by source then
	delete
output	$action, inserted.*, deleted.*;