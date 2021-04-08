-- Обработка ошибок

-- TRY ... CATCH

begin try
	
	select 1 / 0; -- деление на ноль
	print 'какое-то сообщение';

	drop table NonexistentTable; -- удаление не существующей таблицы
	print 'какое-то сообщение';

end try
begin catch
	
	select 
		ERROR_NUMBER() as ErrorNumber,
		ERROR_SEVERITY() as ErrorSeverity,
		ERROR_STATE() as ErrorState,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage;

end catch;
go

-- RAISERROR - Позволяет пробросить ошибку, указать сообщение, указать ее уровень серьезности и тд.

begin try
	select 1/0
end try
begin catch
	raiserror('Деление на ноль', 11, 2); -- raiserror(message, severity, state) / severity - уровень серьезности ошибки / state - место ошибки (если они есть в нескольких местах)
end catch
go

-- доп. аргументы

begin try
	select 1/0;
end try
begin catch
	raiserror('Ошибка %s %d', 11, 2, 'номер', 10); -- в конце можно указывать дополнительные аргуметны, которые можно подставить в основное сообщение
end catch