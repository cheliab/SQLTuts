create database tut_Transaction
go

use tut_Transaction
go

-------------------------------------------

-- Создаем таблицу теннисных кортов
create table Courts (
	[Id] int primary key identity,
	[Name] nvarchar(50) not null,
	[City] nvarchar(30) not null,
	[Capacity] int default 0,
	[Surface] nvarchar(20) not null
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
go

------------------------------------------------------------
-- 1. Откат транзации

begin transaction -- начало транзации

update Courts set Capacity = 10000 where id = 1

select * from Courts where id = 1 -- данные для сравнения (изменнено на новые данные)

rollback transaction -- откатываем транзакцию

select * from Courts where id = 1 -- снова выводим чтобы проверить (вернулись старые данные)

---------------------------------------------------------------
-- 2. Пример с ошибкой (откат закомиченных изменений)

begin transaction 

update Courts set Capacity = 1000 where id = 2

select * from Courts where id = 2

commit

update Courts set Capacity = 5000 where id = 2

rollback -- возникает ошибка так как есть commit который уже завершил начатую транзакцию

select * from Courts where id = 2

---------------------------------------------------------------
-- 3. Объявление нескольких транзакций

begin tran -- первая транзакция (сокращенный вариант написания)

update Courts set City = 'NY' where id = 3

	begin tran -- объявляем вторую транзакцию
	
	update Courts set Capacity = 3000 where id = 3

	commit -- фиксируем данные второй тразации

commit -- фиксируем данные первой транзакции

select * from Courts where id = 3

-------------------------------------------------
-- Откат нескольких транзакций

begin tran

update Courts set City = 'London' where id = 3

	begin tran

	update Courts set Capacity = 1000 where id = 3

	commit

rollback -- откатываются обе транзакции (Capacity не изменится)

select * from Courts where id = 3

-------------------------------------------------
-- Неправильный порядок коммита и отката

begin tran 

update Courts set City = 'Москва' where id = 3

	begin tran

	update Courts set Capacity = 777 where id = 3

	rollback

commit -- возникнет ошибка, так как rollback уже откатил все транзакции

select * from Courts where id = 3 

--------------------------------------------------
-- Просмотр переменной с количеством открытых транзакций (ROLLBACK)

begin tran 
update Courts set City = 'Питер' where id = 3

	begin tran
	update Courts set Capacity = 666 where id = 3

	print @@trancount -- 2

	rollback -- откат 2 транзакций

print @@trancount -- 0

commit -- ошибка

print @@trancount -- 0

--------------------------------------------------
-- Просмотр переменной с количеством открытых транзакций (COMMIT)

begin tran
update Courts set City = 'Маями' where id = 3

	begin tran
	update Courts set Capacity = 333 where id = 3

	print @@trancount -- 2
	commit

print @@trancount -- 1
commit
print @@trancount -- 0

--------------------------------------------------
-- 4. Откат к сохраненной транзакции (SAVE TRAN <NAME> / ROLLBACK TRAN <NAME>)

begin tran 
update Courts set City = 'Владивосток' where id = 1

save tran save1 -- создаем точку сохранения 
	
	begin tran
	update Courts set Capacity = 1000 where id = 1

rollback tran save1 -- откат к точке сохранения (т.е. применится все, что было до точки сохранения, т.е. город изменится, а вместимость нет) 
commit -- нужно сохранить все транзакции, так как в данном варианте rollback не отменяет транзакции
commit 

select * from Courts where id = 1

--------------------------------------------------
-- 5. Пример использования транзакции в процедуре с try catch

-- создаем таблицы для примера
create table Players (
	[Id] int primary key identity,
	[FirstName] nvarchar(50) not null,
	[LastName] nvarchar(100) not null,
	[Rank] int default 0
)
go

create table PlayerInfos (
	[Id] int primary key identity, 
	[PlayerId] int not null, 
	[BirthDate] date, 
	[Weight] smallint, 
	[Height] smallint, 
	[Country] nvarchar(50), 
	[BirthPlace] nvarchar(50), 
	[Residence] nvarchar(50)
)
go

alter table PlayerInfos
add constraint UQ_PlayerInfo_BirthDate unique (BirthDate)
go

create procedure spAddPlayer
	@FirstName nvarchar(50),
	@LastName nvarchar(100),
	@Rank int = null,
	@BirthDate date = null,
	@Weight smallint = null,
	@height smallint = null,
	@country nvarchar(50) = null,
	@BirthPlace nvarchar(50) = null,
	@Residence nvarchar(50) = null
as
begin


	set nocount on;

	declare @PlayerId int;

begin try
	begin tran
		
		insert Players values
		(@FirstName, @LastName, @Rank)

		set @PlayerId = @@identity

		insert PlayerInfos values
		(@PlayerId, @BirthDate, @Weight, @Height, @Country, @BirthPlace, @Residence)
	commit
end try
begin catch

	select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_SEVERITY() as ErrorSeverity,
		ERROR_STATE() as ErrorState,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage
		
	rollback

end catch

end;
go