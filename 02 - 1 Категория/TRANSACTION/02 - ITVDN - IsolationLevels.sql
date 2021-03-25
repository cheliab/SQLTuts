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

begin tran

update TestTable
set [Value] = [Value] + 3
where Id = 1;

waitfor delay '00:00:10'; -- Задержка чтобы успеть выполнить вторую транзакцию

select [Value]
from TestTable
where Id = 1;

commit tran;

-- вторая транзакция, чтобы показать как работают уровни изоляции

begin tran -- set transaction isolation level read uncomitted;

update TestTable
set [Value] = [Value] + 10
where Id = 1;

select [Value]
from TestTable
where Id = 1;

commit tran;

----------------------------------------------------------------------
-- Запросы для поиска проблем с блокировками

DBCC OPENTRAN;

select @@TRANCOUNT

select * from sys.dm_tran_locks

select * from sys.dm_exec_requests er cross apply sys.dm_exec_sql_text (sql_handle)

select * from sys.sysprocesses where blocked = 0

-- Смотрим заблокированные таблицы
select
    object_name(P.object_id) as TableName,  
    resource_type,
    resource_description,
    request_session_id
from
    sys.dm_tran_locks L
		join sys.partitions P on L.resource_associated_entity_id = p.hobt_id
 
-- Отбор по названию таблицы
--where
--  object_name(P.object_id) = 'regin_SelectionListGoodsForIssuance'
 
order by object_name(P.object_id)
 
-- Используем "request_session_id" из таблицы выше, чтобы убить процесс блокирующий таблицу
--kill 54