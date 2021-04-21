-- https://www.youtube.com/watch?v=5dk33HN8BX8

create database tut_Merge_SimpleExample
go

use tut_Merge_SimpleExample
go

-------------------------------------
-- создаем таблицы

create table StudentSource (
	Id int primary key,
	[Name] nvarchar(50)
)
go

insert into StudentSource values
(1, 'Mike'),
(2, 'Sara')
go

create table StudentTarget(
	Id int primary key,
	[Name] nvarchar(50)
)
go

insert into StudentTarget
values
(1, 'Mike M'),
(3, 'John')

-------------------------------------------------
-- операция merge

select * from StudentSource
select * from StudentTarget

merge into StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.[Name] = S.[Name]
when not matched by target then -- by target можно не указывать
	insert (Id, [Name]) values (S.Id, S.[Name])
when not matched by source then -- обычно последнюю часть с удалением не добавляют (выполняется только вставка и обновление)
	delete
; -- обязательно нужна точка с запятой
go

select * from StudentSource
select * from StudentTarget