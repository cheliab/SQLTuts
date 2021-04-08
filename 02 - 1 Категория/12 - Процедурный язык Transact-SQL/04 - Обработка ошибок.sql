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

