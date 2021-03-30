create database tut_AggregateFunctions
go

use tut_AggregateFunctions
go

----------------------------------------

create table Orders (
	Id int primary key identity,
	[Date] datetime not null,
	ProductId int not null,
	Qty int not null,
	Price decimal(6, 4) not null,
	City nvarchar(50) 
)

insert into Orders
values
('', 1, 10, 500, 'Владивосток')