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
	City nvarchar(50),
	Comment nvarchar(100)
)

insert into Orders (
	[Date], 
	[Product],
	[Qty], 
	[Price], 
	[City]
)
values
(convert(datetime, '2021/03/31', 111), 'iPhone X',    2, 900.00, 'Артем'),
(convert(datetime, '2021/03/30', 111), 'iPhone X',    5, 900.00, 'Артем'),
(convert(datetime, '2021/03/30', 111), 'iPhone X',    3, 900.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'MacBook Air', 1, 1200.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'iMac',        7, 1400.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'iMac',        7, 1400.00, 'Артем'),

(convert(datetime, '2021/03/29', 111), 'iMac',           6, 1200.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    4, 1000.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    1, 1000.00, 'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 2, 750.00,  'Владивосток'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 3, 750.00,  'Владивосток'),

(convert(datetime, '2021/03/31', 111), 'iPhone X',       2, 700.00, 'Артем'),
(convert(datetime, '2021/03/29', 111), 'iMac',           6, 1000.00, 'Москва'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    4, 900.00, 'Москва'),
(convert(datetime, '2021/03/25', 111), 'MacBook Air',    1, 900.00, 'Москва'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 2, 650.00,  'Москва'),
(convert(datetime, '2021/03/25', 111), 'Samsung Galaxy', 3, 650.00,  'Москва')

alter table Orders
add Comment nvarchar(100)

update Orders
set Comment = 'Заказали чехол'
where Id = 1

update Orders
set Comment = 'Скол на экране сделали скидку'
where Id = 2

update Orders
set Comment = 'Подарили наклейки'
where Id = 4

---------------------------------------------------------------------------------------
-- Агргатные функции

-- 1. SUM()

select Product, SUM(Qty) TotalQty From Orders
group by Product

-- HAVING

select Product, SUM(Qty) TotalQty from Orders
group by Product
having SUM(Qty) > 10 -- -- выборка сгруппированых значений больше 10

-- 2. MIN(), MAX()

select
	Product,
	MIN(Price) MIN_Price,
	MAX(Price) MAX_Price
from Orders
group by
	Product

-- 3. AVG()

select
	Product,
	MIN(Price) MIN_Price,
	MAX(Price) MAX_Price,
	AVG(Price) AVG_Price
from Orders
group by
	Product

select
	Product,
	MIN(Price) MIN_Price,
	MAX(Price) MAX_Price,
	SUM(Qty * Price) / SUM(Qty) AVG_Price -- средняя цена
from Orders
group by Product

-- 4. COUNT()

-- количество строк всего
select COUNT(*) from Orders

-- количество комментариев (NULL значения игнорируются)
select COUNT(Comment) from Orders

-- количество городов уникальных городов (можно указать DISTINCT внутри COUNT, это позволяет посчитать уникальные значения в колонке)
select COUNT(DISTINCT City) from Orders

-- количество уникальных товаров и городов
select
	COUNT(DISTINCT Product) Products,
	COUNT(DISTINCT City) Cities
from
	Orders

-- Количество продаж в каждом городе (количеству строк)
select
	City,
	COUNT(*)
from
	Orders
group by
	City

-- Статистика по продажам

select
	Product,
	COUNT(Id) OrderCount,
	SUM(Qty) Total_Qty,
	SUM(Price * Qty) Total_Sum,
	MIN(Price) MIN_Price,
	MAX(Price) MAX_Price,
	SUM(Qty * Price) / SUM(Qty) AVG_Price
from Orders
group by Product

-- средние продажи по городу
select
	City,
	AVG(Qty * Price) AVG_Sale -- Средние продажи по городу
from
	Orders
group by
	City