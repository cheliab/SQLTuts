
-- IF

declare @number int = 18;

if @number >= 18
	print ('number is equal to or greater than 18')

-- ELSE

set @number = 5;

if @number >= 18
	print('number is equal to or greater than 18')
else
	print('number is less than 18')

-- ELSE IF

set @number = 2

if @number = 1
	print('one')
else if @number = 2
	print('two')
else
	print('unknown')

set @number = 2

if @number >= 20
	print('number is equal to or greater than 20')
else
begin
	print(@number)
	print('number is less than 20')
end
go

-----------------------------------
-- CASE

-- SWITCH CASE в T-SQL отсутствует как самостоятельная конструкция
-- можно использовать CASE как часть других конструкций

declare @number int = 3;

print case @number
		when 1 then 'One'
		when 2 then 'Two'
		else 'number is not equal to 1 or 2'
	end

-- IF EXISTS

create database metanit_IfOperator
go

use metanit_IfOperator
go

create table Person (id int);

-- Проверка наличия таблицы в БД

if exists(select 1 from sys.tables where object_id = OBJECT_ID('Person'))
begin 
	print 'Table "Person" already exists';
end

-- Еще один вариант проверки

if OBJECT_ID('Person') is not null
	print 'Table "Person" already exists';

