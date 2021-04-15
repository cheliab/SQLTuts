create database kudvenkat_IsolationLevels;
go

use kudvenkat_IsolationLevels;
go

----------------------------------------------

create table Products (
	Id int identity primary key,
	Product nvarchar(50),
	ItemsInStock int
)
go

insert into Products
values
('iPhone', 10)
go

---------------------------------------------
-- dirty read / грязное чтение

----------------------------------------------
-- Транзакция 1

begin tran

update Products set ItemsInStock = 9 where id = 1;

waitfor delay '00:00:15'

rollback tran

----------------------------------------------
-- Транзакция 2

set transaction isolation level read uncommitted

select * from Products where Id = 1

-- еще один вариант использовать hint "NOLOCK"

select * from Products (NOLOCK) where Id = 1