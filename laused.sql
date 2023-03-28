--1 db loomine
create database Targv22

--2 db kustutamine 
DRop DataBASE Targv22

--3 lisame tabel nimetatud Gender ja tabel nimetatud Person 
create table Gender
(
Id int NOT NULL primary key,
Gender nvarchar(10) not null
)

create table Person
(
Id int not null primary key,
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)

---4 andmete sisestamine tabelisse 
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

---5 Muutume tabeli Person, et lisame foreign key seotud Id-ga(Gender Tabel) 
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--6 sisestame andmed 
insert into Person (Id, Name, Email, GenderId)
values (1, 'Supermees', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (7, 'Spiderman', 'spider@spiderman.com', 2)

--7 vaatame tabeli andmeid
select * from Person

---8 võõrvõtme piirangu maha võtmine
alter table Person
drop constraint tblPerson_GenderId_FK

--9 sisestame väärtuse tabelisse
insert into Gender (Id, Gender)
values (3, 'Unknown')
--10 lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId


----11 2 tund

select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')

---12 lisame uue veeru tabelisse
alter table Person
add Age nvarchar(10)

--13uuendame andmeid
update Person
set Age = 149
where Id = 8

--14 Liisame piirangud, et Age tuleb piiratud diapasoonil rohkem kui 0 ja vähem kui 150,
siis lisada Test AGEga 160 me juba ei saa.
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

-- 15 Siin me kustutame isiku tabelist Person kelle ID on 8
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- 16 lisame veeru juurde
alter table Person
add City nvarchar(25)


--17andmete lisamine city UPDATE kaudu
UPDATE Person set City = 'Gotham';
UPDATE Person set City = 'Tartu' where Id=2;
UPDATE Person set City = 'Miami' where Id=3;


--18tahame tead kõiki, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--19kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'


--19andmete lisamine city UPDATE kaudu
UPDATE Person set Age = '20';
UPDATE Person set Age = '50' where Id=2;
UPDATE Person set Age = '120' where Id=3;


--20 näitab teatud vanusega inimesi
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)


--- 21näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 30 and 50

---22 wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

--23 n'itab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

--- 24näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

--25 näitab kus nimed ei alaga W, A, S
select * from Person where Name like '[^WAS]%'

--- 26 näitab inimed kes elvada gothamis või newyorkis ja vanus on rohkem kui 40 või 40
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 40

---27võtab kolm esimest rida
select top 3 * from Person

--- 28kolm esimest, aga tabeli järjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

--- 29 näitab esimesed 50% tabelis
select top 50 percent * from Person

--30  Sorteerib inimesi AGE järgi, AGE kasvab
select * from Person order by cast(Age as int)
select * from Person order by Age

--31 summa kõik AGEd
select sum(cast(Age as int)) from Person

---32 kuvab kõige nooremat isikut
select min(cast(Age as int)) from Person
---33 kõige vanem isik
select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City





--- tund 3

--- 34 loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

--35 lisame andmed Department ja Employees tabelistesse
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

---36 võtab nimed ja departmentid alfaviiti järgi
select distinct Name, DepartmentId from Employees

---37 palka summa(kõik read) tablist Employees
select sum(cast(Salary as int)) from Employees
---38 võtab minimaalse palka tabelist Employees
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)

--ei saa käivitada, DepartmentID juba tabelis olemas
alter table Employees
add DepartmentId
int null


--lisab uue veru Middlename Employees tabelisse ja sama LastName-ga
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

--39 siin peame muutuma FirstName. Verb nimetatud Name
update Employees set Name = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set Name = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set Name = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set Name = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set Name = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set Name = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set Name = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set Name = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set Name = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set Name = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


---40 Siin ka peame muutuma Firstname, Name igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department





--- 41 loome stored procedure, mis kuvab vaate AGA "spGetEmployees" parast end on uleliigne
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end


exec spGetEmployees
execute spGetEmployees

--- 42 loome procedure, mis näitab Employees Genderi ja Departmentiga
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--- 43kõik esimeses osakonnas meessoost töötavad isikud
spGetEmployeesByGenderAndDepartment 'Male', 1

spGetEmployeesByGenderAndDepartment @DepartmentId =  1, @Gender = 'Male'



--44 loome procedure, mis loendab(Id järgi) inimeste arvu soo järgi
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end



--45 annab teada, palju on meessoost isikuid ning kuvab vastava stringi
declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

--46 annab teada, palju on meessoost isikuid
declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

---47 loome procedure, mis loendab kõik inimesi Employees tabelist
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end
--- 48käivitame sp
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--- 49 FirstName on vaja muutuda Name, sest tabelis ei ole Firstname, aga procedure otsib
Employees nimi Id järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @Name = Name from employees where Id = @Id
end

--50 otsib inimest kellel on Id 6(töötab varem tehtud procedure) ja annab meile selle inimese nimi
declare @FirstName nvarchar(50)
execute spGetNameById1 6, @FirstName output
print 'Name of the employee = ' + @FirstName

--51 FirstName ka ei ole tabelis, on vaja muutuda Name, aga procedure annab meile tagasi employee nimi sisestatud ID järgi
create proc spGetNameById2
@Id int
as begin
	return (select Name from Employees where Id = @Id)
end
--53 loome lisa procedure, et aitab meile viimases harjutuses
create proc spGetNameById3
@Id int
as begin
	select Name from Employees where Id = @Id
end

-- 52 Siin mitte kasutame spGetNameById2, aga kasutame spGetNameById3 ja kõik töötab OK - nätab meile employee name 1 ID-ga
declare @EmployeeName nvarchar(50)
exec @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

select * from Employees
