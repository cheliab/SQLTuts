# Примеры использования оператора MERGE

MERGE - операция в T-SQL, для обновления, вставки или удаления данных в одной таблице на основе результатов соединения с данными другой таблицы.

Пример синтаксиса:
```sql
MERGE <основная_таблица>
USING <таблица_обновления>
ON <условие>
WHEN MATCHED THEN
    UPDATE
WHEN NOT MATCHED THEN
    INSERT
WHEN NOT MATCHED BY SOURCE THEN
    DELETE
```