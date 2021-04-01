create database tut_AggregateFunctions
go

use tut_AggregateFunctions
go

----------------------------------------

create table Orders (
	Id int primary key identity,
	[Date] datetime not null,
	Product nvarchar(50) not null,
	Qty int not null,
	Price decimal(6, 2) not null,
	City nvarchar(50) 
)

insert into Orders (
	[Date], 
	[Product],
	[Qty], 
	[Price], 
	[City] 
)
values
(convert(datetime, '2021/03/31', 111), 'iPhone X',    2, 800,    'Артем'),
(convert(datetime, '2021/03/30', 111), 'iPhone X',    5, 800.00, 'Артем'),
(convert(datetime, '2021/03/30', 111), 'iPhone X',    3, 800.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'MacBook Air', 1, 1000.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'iMac',        7, 1200.00, 'Артем'),

(convert(datetime, '2021/03/29', 111), 'iMac',           6, 1200.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    4, 1000.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    1, 1000.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 2, 750.00,  'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 3, 750.00,  'Владивосток')

---------------------------------------------------------------------------------------
-- Агргатные функции

-- 1. SUM()

select Product, SUM(Qty) TotalQty From Orders
group by Product

-- HAVING

select Product, SUM(Qty) TotalQty from Orders
group by Product
having SUM(Qty) > 10 -- -- выборка сгруппированых значений больше 10