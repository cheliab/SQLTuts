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

waitfor delay '00:00:10'; -- Задержка чтобы успеть выполнить вторую транзакцию (2 файл)

select [Value]
from TestTable
where Id = 1;

commit tran;

-------------------------------------------
-- 2. DIRTY READ / ГРЯЗНОЕ ЧТЕНИЕ

begin tran

update TestTable
set [Value] = [Value] + 3
where Id = 1

waitfor delay '00:00:10';

-- Откатываем изменения после задержки, чтобы во второй транзакции получить грязное чтение
-- Вторая транзакция считает данные, которые в итоге будут отменены
rollback;

select [Value]
from TestTable
where Id = 1

--------------------------------------------------
-- 3. NON-REPEATABLE READS / НЕ ПОВТОРЯЕМОЕ ЧТЕНИЕ

begin tran

select [Value]
from TestTable
where Id = 1;

waitfor delay '00:00:10';

-- Если выполнить вторую транзакцию с update, то в этом select будут уже новые данные
select [Value]
from TestTable
where Id = 1;

commit tran;

--
-- повышаем уровень изоляции транзакции
--

begin tran 

-- Повышение уровня изоляции позволяет исключить не повторяемое чтение
-- Вторая транзакция не сможет выполнить update пока не завершится эта транзакция
set transaction isolation level repeatable read;

select [Value]
from TestTable
where Id = 1;

waitfor delay '00:00:10'

-- Теперь данный селект получит те же данные что и первый
select [Value]
from TestTable
where Id = 1;

commit tran;

------------------------------------------------------
-- 4. PHANTOM READS / ФАНТОМНОЕ ЧТЕНИЕ

begin tran 

select * from TestTable

waitfor delay '00:00:10'

select * from TestTable

commit tran;

-- 
-- повышаем уровень изоляции транзакции
-- 

begin tran 

-- При таком уровне изоляции вторая транзакция не сможет вставить в таблицу новую запись
set transaction isolation level serializable;

select * from TestTable

waitfor delay '00:00:10'

select * from TestTable

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