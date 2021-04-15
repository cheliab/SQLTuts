create database tut_Procedure_OutputParams
go

use tut_Procedure_OutputParams
go

------------------------

create table Products (
	Id int primary key identity,
	ProductName nvarchar(30) not null,
	Manufacturer nvarchar(30) not null,
	ProductCount int default 0,
	Price decimal(19,4) not null
)
go

insert into Products
values
('iPhone 5', 'Apple', 1, 30000),
('iPhone 6', 'Apple', 2, 40000)
go

--------------------------
-- Создаем процедуру с выходными параметрами (OUTPUT)

create procedure GetPriceStats
	@minPrice decimal(19,4) output, -- выходной параметр
	@maxPrice decimal(19,4) output  -- выходной параметр
as
select @minPrice = min(Price), @maxPrice = max(Price)
from Products

---------------------------------------------
-- Создаем переменные

declare @minPriceVar decimal(19,2), @maxPriceVar decimal(19,2)

--  выполняем процедуру с выходными параметрами
exec GetPriceStats @minPriceVar output, @maxPriceVar output

-- выводим результат
print 'Минимальная цена ' + convert(varchar, @minPriceVar)
print 'Максимальная цена ' + convert(varchar, @maxPriceVar)
go

--------------------------------
-- Процедура с входными и выходными параметрами

-- создаем процедуру
create procedure CreateProduct
	@name nvarchar(20),
	@manufacturer nvarchar(20),
	@count int,
	@price decimal(19,4),
	@id int output
as
	insert into Products(ProductName, Manufacturer, ProductCount, Price)
	values (@name, @manufacturer, @count, @price)
	set @id = @@identity
go

-- Проверка

declare @id int

exec CreateProduct 'iPhone X', 'Apple', 3, 60000, @id output

print 'Идентификатор новой строки: ' + convert(varchar, @id)
go
------------------------------------------------------
-- Возвращение значения из процедуры (RETURN)

create procedure GetAvgPrice as
	declare @avgPrice decimal(19,4)
	
	select @avgPrice = avg(Price)
	from Products
	
	return @avgPrice;

-- Проверка

declare @result decimal(19,2)

exec @result = GetAvgPrice

print 'Средняя цена товара равна: ' + convert(varchar, @result)