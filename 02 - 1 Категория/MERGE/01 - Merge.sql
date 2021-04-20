-- https://info-comp.ru/obucheniest/561-merge-in-t-sql.html
-- Пример использования MERGE

create database tut_Merge
go

use tut_Merge
go

------------------------------------------------------
-- Создаем таблицы

-- Целевая таблица
create table TargetTable(
	Id int not null,
	ProductName nvarchar(50),
	Price decimal(19,4),
	constraint PK_TargetTable primary key clustered (Id ASC)
)

-- Таблица источник
create table SourceTable(
	Id int not null,
	ProductName nvarchar(50),
	Price decimal(19,4),
	constraint PK_SourceTable primary key clustered (Id ASC)
)

truncate table SourceTable

------------------------------------------------------
-- Заполняем данными

insert into TargetTable values
(1, 'Системный блок', 0),
(2, 'Монитор', 0),
(3, 'Мышка', 0),
(4, 'Клавиатура', 0)
go

insert into SourceTable values
(1, 'Системный блок', 2000),
(2, 'Монитор', 5000),
(3, 'Мышка', 500),
(5, 'Клавиатура', 800),
(6, 'Коврик для мыши', 300)
go

------------------------------------------------------
-- Проверяем заполнение

select * from TargetTable

select * from SourceTable

------------------------------------------------------
-- Пример 1 - обновление и добавление данных с помощью MERGE

-- очистка
--truncate table TargetTable
--truncate table SourceTable

MERGE TargetTable -- целевая талица
USING SourceTable -- таблица источник
ON (TargetTable.Id = SourceTable.Id)
WHEN MATCHED THEN -- если есть совпадение по условию обновляем запись (UPDATE - выполняем команду для обновления)
	UPDATE SET 
		TargetTable.ProductName = SourceTable.ProductName,
		TargetTable.Price = SourceTable.Price
WHEN NOT MATCHED THEN -- если нет совпадения (т.е. в целевой не хватает записи) добавляем запись (INSERT - выполняем команду для вставки)
	INSERT (Id, ProductName, Price)
	VALUES (SourceTable.Id, SourceTable.ProductName, SourceTable.Price)
output -- вывод результата работы операции
	$action as [Операция],
	Inserted.ProductName as ProductNameNew,
	Inserted.Price as PriceNew,
	Deleted.ProductName as ProductNameOld,
	Deleted.Price as PriceOld;

select * from TargetTable;
select * from SourceTable;

-- в данном примере остается одна лишняя строка, которая должна была удалиться TargetTable (id - 4)

----------------------------------
-- Пример 2 - синхронизация таблиц с помощью MERGE

-- Очищаем таблицы
truncate table TargetTable
truncate table SourceTable

-- перезаполняем данными
insert TargetTable values
(1, 'Системный блок', 0),
(2, 'Монитор', 0),
(3, 'Мышка', 0),
(4, 'Клавиатура', 0)
go

insert SourceTable values
(1, 'Системный блок', 2000),
(2, 'Монитор', 5000),
(3, 'Мышка', 500),
(5, 'Клавиатура', 800),
(6, 'Коврик для мыши', 300)
go

--------------------------------

merge TargetTable T
using (select Id, ProductName, Price from SourceTable) S (Id, ProductName, Price)
on (T.Id = S.Id) 
when matched then
	update set T.ProductName = S.ProductName, T.Price = S.Price
when not matched then
	insert (Id, ProductName, Price)
	values (S.Id, S.ProductName, S.Price)
when not matched by source then -- если строки нет в таблице источнике
	delete -- удалить строку

-- вывод результата операции

output
	$action,
	inserted.*,
	deleted.*;

-- результат

select * from TargetTable
select * from SourceTable

--------------------------------------------
-- Пример 3 - операция MERGE с дополнительным условием

update SourceTable
set Price = NULL
where Id = 2
go

-- Merge

merge TargetTable T
using SourceTable S
on (T.Id = S.Id)
when matched and S.Price is not null then -- дополнительное условие (доп. проверка что цена заполнена)
	update set T.ProductName = S.ProductName, T.Price = S.Price
when not matched then
	insert (Id, ProductName, Price)
	values (S.Id, S.ProductName, S.Price)
output
	$action,
	inserted.*,
	deleted.*;

select * from TargetTable
select * from SourceTable