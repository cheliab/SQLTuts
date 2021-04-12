-- Correlated Subqueries vs Derived Tables
-- https://www.youtube.com/watch?v=Kx4U5BhRGqM

use [StackOverflow2010]

-----------------------------------------------------------

create database BertWagner_CorrelatedSubqueriesVSDerivedTables
go

use BertWagner_CorrelatedSubqueriesVSDerivedTables
go

create table Badges (
	Id int identity primary key,
	UserId int,
	[Date] date
)

create nonclustered index IX_Badges_UserID_Date
on Badges (UserId ASC) INCLUDE ([Date])

drop table Badges

-----------------------------------------------------------

declare @counter1 int = 1;
declare @counter2 int = 1;
declare @randDate date;
declare @userID int;

while (@counter1 <= 10)
begin
	set @counter2 = 1;

	set @userID = @counter1

	while (@counter2 <= 20)
	begin
		
		set @randdate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 364 ), '2011-01-01');

		insert into Badges (UserId, [Date]) values (@userID, @randDate)

		set @counter2 = @counter2 + 1;

	end

	set @counter1 = @counter1 + 1;

end

select * from Badges

-----------------------------------------------------------
-- Оригинальный запрос

select distinct
	UserId,
	FirstBadgeDate = 
		(select min([Date])
		from Badges i 
		where o.UserId = i.UserId)
from
	Badges o

-- такое написание генерирует план запрос с большим количетсвом лишних чтений данных
-- данные агрегируются только в самом конце, до этого момента манипуляции происходят со всеми строками

-----------------------------------------------------------
-- Новый вариант запроса

select distinct
	o.UserId,
	FirstBadgeDate
from
	Badges o
		inner join (
			select UserId, MIN([Date]) as FirstBadgeDate
			from Badges
			group by UserId
		) i
		on o.UserId = i.UserId



select
	UserId,
	min([Date]) as FirstBadgeDate
from Badges
group by
	UserId