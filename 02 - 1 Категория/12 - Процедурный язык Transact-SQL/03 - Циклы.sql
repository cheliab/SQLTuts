
-- Цикл WHILE

declare @counter int = 0

while @counter < 10
begin
	set @counter = @counter + 1
	print 'counter: ' + CAST(@counter as varchar)
end
go

-- CONTINUE - Прерывание итерации цикла (пропуск итерации)

declare @counter int = 0

while @counter < 10
begin
	set @counter = @counter + 1

	if @counter % 2 = 0 -- выведутся только не четные
		continue

	print 'counter: ' + cast(@counter as varchar)
end
go

-- BREAK - Прерывание цикла

declare @counter int = 0

while @counter < 10
begin
	set @counter = @counter + 1

	if @counter = 6
		break

	print 'counter: ' + cast(@counter as varchar)
end