--create database ForeingKeyTut;
--go;
--use ForeingKeyTut;
--go;

-----------------------------------------------------------------
create table Customers
(
	Id int primary key,
	Age int default 18,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	Email varchar(30) unique,
	Phone varchar(20) unique
)

create table Orders
(
	Id int primary key identity,
	CustomerId int references Customers (Id), -- внешений ключ к таблице Customers к колонке Id
	CreatedAt datetime
)

create table Orders_TableVar
(
	Id int primary key identity,
	CustomerId int,
	CreateAt datetime,
	foreign key (CustomerId) references Customers (Id) -- установка ключа на уровне таблицы
)

create table Orders_ConstraintVar
(
	Id int primary key identity,
	CustomerId int,
	CreateAt datetime,
	constraint FK_Orders_To_Customers foreign key (CustomerId) references Customers (Id) -- задаем имя ограничения (обычно начинаются с "FK_")
)