create database tut_ITVDN_IsolationLevels
go

use tut_ITVDN_IsolationLevels
go

----------------------------------------------
-- Подготовка таблицы для примеров с уровнями изоляции

if exists(select 1 from sys.tables where object_id = OBJECT_ID('TestTable'))
	drop table TestTable
	

create table TestTable (
	[Id] int identity,
	[Value] int
)
go

insert into TestTable values
(1)
go

---------------------------------------------
-- 1. LOST UPDATE / ПОТЕРЯННОЕ ОБНОВЛЕНИЕ

begin tran -- set transaction isolation level read uncomitted;

update TestTable
set [Value] = [Value] + 10
where Id = 1;

select [Value]
from TestTable
where Id = 1;

commit tran;