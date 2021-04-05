declare @name varchar(10);
print isnull(@name, 'NULL'); -- по умолчанию значение переменной NULL

declare @age smallint = 2;
print @age;

-- SET

set @name = 'Elijah';
print @name;

-- GO

declare @fullname varchar(10) = 'Pavel Berezkin';
go -- переменная существует только в рамках одного пакета (при выхове после GO будет ошибка)

print isnull(@fullname, 'NULL'); -- возникнет ошибка, переменной @fullname уже нет