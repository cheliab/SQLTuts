
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