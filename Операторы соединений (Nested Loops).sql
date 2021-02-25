-- Пример для статейки
-- https://bertwagner.com/posts/visualizing-nested-loops-joins-and-understanding-their-implications/

create database tut_NestedLoops
go

use tut_NestedLoops
go

create table OuterTable
(
	[column] char(1)
)

create table InnerTable
(
	[column] char(1)
)

insert into OuterTable
values
('B'),
('A'),
('E'),
('F'),
('D')

insert into InnerTable
values
('A'),
('B'),
('E'),
('B'),
('C')

select 
	OuterTable.[column],
	InnerTable.[column]
from OuterTable
	left join InnerTable on InnerTable.[column] = OuterTable.[column]

---------------------------------------------------------------------
-- вариант с индексом

create table OuterTableIndex
(
	col char(1) primary key
)

create table InnerTableIndex
(
	col char(1) primary key
)

insert into OuterTableIndex
values
('B'),
('A'),
('E'),
('F'),
('D')

insert into InnerTableIndex
values
('A'),
('B'),
('E'),
('F'),
('C')

select 
	OuterTableIndex.col,
	InnerTableIndex.col
from OuterTableIndex
	left join InnerTableIndex on InnerTableIndex.col = OuterTableIndex.col