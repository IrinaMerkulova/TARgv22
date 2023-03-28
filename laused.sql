-- db loomine
create database Targv22

--db kustutamine
DRop DataBASE Targv22

--tabeli loomine
create table Gender
(
Id int NOT NULL primary key,
Gender nvarchar(10) not null
)
--tabeli loomine
create table Person
(
Id int not null primary key,
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)

--- andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female');
insert into Gender (Id, Gender)
values (2, 'Male')

--- tabeli muutmine piirangu lisamine - foreign key
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- sisestame andmed
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

-- vaatame tabeli andmeid
select * from Person

--- võõrvõtme piirangu maha võtmine
alter table Person
drop constraint tblPerson_GenderId_FK

-- sisestame väärtuse tabelisse
insert into Gender (Id, Gender)
values (3, 'Unknown');
Select * from Gender;
-- lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId
Select * from Gender;

---- 2 tund

select * from Person
select * from Gender
---sisestame uue väärtuse tabelisse
insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')
select * from Person
---lisame uue veeru tabelisse
alter table Person
add Age nvarchar(10)
select * from Person
--uuendame andmeid
update Person
set Age = 149
where Id = 8
select * from Person
---võõrvõtme - piirangu määramine
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)
---tabeli värskendamine( Age--andmete tüüp on muudatud)
Alter table Person Alter COLUMN Age nvarchar(200);
Alter table Person
drop constraint CK_Person_Age;
---sisestame uue väärtuse tabelisse
insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

---kustutamine tabelist üks veerg
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

---andmete lisamine City UPDATE kaudu
UPDATE Person Set City='Gotham';
UPDATE Person Set City='Tartu' Where Id=2 or Id=3;
---lisame paar asju
insert into Person (Id, Name, Email, GenderId, Age)
values (2, 'Test3', 'Test3', 4, 110),
	 (10, 'Test1', 'Test1', 3, 45),
	 (11, 'Test2', 'Test2', 6, 70);

-- tahame tead kõiki, kes elavad Gothami linnas 
select * from Person where City = 'Gotham'
-- kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- näitab teatud vanusega inimesi
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)

--- näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 30 and 50

--- wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'g%'
---wildcard e näitab kõik @-tähega keskel laused
select * from Person where Email like '%@%'

-- näitab, kelle on emailis puudutav @--märki 
select * from Person where Email not like '%@%'

--- näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

--näitab kõik sõnad milles on keskel asuvad järgmised tähed sama järjekorras
select * from Person where Name like '[^WAS]%'
--- näitab tulemus järgmistel tingimustel
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 40

---võtab kolm esimest rida
select top 3 * from Person

--- kolm esimest, aga tabeli järjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

--- näitab esimesed 50% tabelis
select top 50 percent * from Person
---sorteerib Age veeru järgi
select * from Person order by cast(Age as int)
select * from Person order by Age

---Summa ja tulemusi konverteerimine Age nagu integer datatype
select sum(cast(Age as int)) from Person

--- kuvab kõige nooremat isikut
select min(cast(Age as int)) from Person
--- kõige vanem isik
select max(cast(Age as int)) from Person
---näitab ja sorteerib tulemusi peale matemaatilise tehingu City järgi
select City, sum(cast(Age as int)) as TotalAge from Person group by City





--- tund 3

--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)
---loome uued tabelid
create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

---sisestame uue väärtuse tabelisse 
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department
---sisestame uue väärtuse tabelisse
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

---näitab kõik (kustutades dubleeritud andmed)
select distinct Name, DepartmentId from Employees

---Summa ja tulemusi konverteerimine Salary nagu integer datatype
select sum(cast(Salary as int)) from Employees
---Miinimum ja tulemusi konverteerimine Salary nagu integer datatype
select min(cast(Salary as int)) from Employees

---lisame veeru juurde
alter table Employees
add City nvarchar(25)

---lisame veeru juurde
alter table Employees
add FirstName nvarchar(30)
---lisame veeru juurde
alter table Employees
add LastName nvarchar(30)

---andmete lisamine Id UPDATE kaudu
update Employees set FirstName = 'Tom',  LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam',  LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John',  LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam',  LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL,  LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben',  LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara',  LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie',  LastName = NULL
where Id = 8
update Employees set FirstName = 'James',  LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL,  LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, LastName) as Name
from Employees

select * from Employees
select * from Department





--- loome stored procedure, mis kuvab vaate
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

---näitab tingimusi järgi järgmisi tulemusi --> FirstName ja teisel pool Gender
exec spGetEmployees
execute spGetEmployees

---  loome stored procedure, mis otsib ja kuvab tabelisel--> Firstname -->Gender-->DepartmentId
---kasutaja poolt on vaja teha päring , kus on vaja täpsustada niisugusi parameetrid nagu Gender ja DepartmentId
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

exec spGetEmployeesByGenderAndDepartment Male, 2

--- kõik esimeses osakonnas meessoost töötavad isikud
exec spGetEmployeesByGenderAndDepartment 'Male', 1

execute spGetEmployeesByGenderAndDepartment @DepartmentId =  1, @Gender = 'Male'



---loome stored procedure, mis kuvab vaate
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

-- annab teada, palju on meessoost isikuid ning kuvab vastava stringi
declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

-- annab teada, palju on meessoost isikuid
declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

---loome stored procedure
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end
--- käivitame sp
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--- loome stored procedure
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from employees where Id = @Id
end

---käivitame sp
declare @FirstName nvarchar(50)
execute spGetNameById1 6, @FirstName output
print 'Name of the employee = ' + @FirstName

--- loome stored procedure
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

---käivitame sp
declare @EmployeeName nvarchar(50)
exec @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

select * from Employees
