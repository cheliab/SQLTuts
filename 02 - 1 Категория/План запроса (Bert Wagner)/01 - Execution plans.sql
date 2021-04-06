-- запрос чтобы посмотреть все закешированные планы

select * from sys.dm_exec_cached_plans
cross apply sys.dm_exec_query_plan(plan_handle)
cross apply sys.dm_exec_sql_text(plan_handle)

-- Просмотр статистики
--DBCC SHOW_STATISTICS('','')