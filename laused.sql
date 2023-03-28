-- db loomine
create database Targv22

--db delete
DRop DataBASE Targv22

--create table
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
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

--- tabeli muutmine piirangu lisamine
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
SELECT * FROM Gender;
-- lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId


---- lisamine tabilisse information 

select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')

---lisame uue veeru tabelisse
alter table Person
add Age nvarchar(10)

--uuendame andmeid
update Person
set Age = 149
where Id = 8

--muttmine tabeli person lisamine piiranguid vanuse järgi
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

--kustutumine tabelist Person kus id=8
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

-- tahame tead kõiki, kes elavad Gothami linna 
select * from Person where City = 'Gotham'
-- kõik, kes ei ela Gothamis
UPDATE Person SET City = 'Gotham';
UPDATE Person SET City = 'Tartu' Where Id=2 or Id=3;

-- näitab teatud vanusega inimesi
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)

--- näitab teatud vanusevahemikus olevaid inimesii
select * from Person where Age between 30 and 50

--- wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

-- n'itab kõiki, kellel ei ole @-märki emailiss
select * from Person where Email not like '%@%'

--- näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

--näitab kus nimi ei alga W,A, või S
select * from Person where Name like '[^WAS]%'
--- linn gotham voi new york and vanus enam voi vordus 40
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 40

---võtab kolm esimest rida
select top 3 * from Person

--- kolm esimest, aga tabeli järjestus on Age ja siis Namee
select * from Person
select top 3 Age, Name from Person

--- näitab esimesed 50% tabeliss
select top 50 percent * from Person

--sortida rekordid vanuse järgi
select * from Person order by cast(Age as int)
select * from Person order by Age

--tagastab tabeli "Isik" veerus "Vanus" olevate väärtuste summa pärast nende teisendamist täisarvudeks.
select sum(cast(Age as int)) from Person

--- kuvab kõige nooremat isikutt
select min(cast(Age as int)) from Person
--- kõige vanem isik
select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City





--- tund 3

--- loome uued tabelidd
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

--liisamine andmed tabilitisse Department ja Employees
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

---tagastab loendi unikaalsete väärtuspaaride loendist "Name" ja "DepartmentId"
select distinct Name, DepartmentId from Employees

---tagastab tabeli "Töötajad" veerus "Palk" olevate väärtuste summa
select sum(cast(Salary as int)) from Employees
---tagastab tabeli "Töötajad" veerus "Palk" olevate minimum väärtuse summa
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


--muutminime tüüpi adnmed ning lisamine veeru 
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

alter table Employees
add FirstName nvarchar(30)

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department





--- loome stored procedure, mis kuvab vaate
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

spGetEmployees
exec spGetEmployees
execute spGetEmployees

--- Protseduur võtab kaks sisendparameetrit: "Gender" tüüpi "nvarchar(20)" ja "DepartureId" tüüpi "int". Neid valikuid kasutatakse tulemuste filtreerimiseks
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--- kõik esimeses osakonnas meessoost töötavad isikud
spGetEmployeesByGenderAndDepartment 'Male', 1

spGetEmployeesByGenderAndDepartment @DepartmentId =  1, @Gender = 'Male'



--Protseduur kasutab kahte sisendparameetrit: "Gender" tüüpi "nvarchar(20)" ja "EmployureCount" tüüpi "int" väljundparameetrina. Väljundparameetrit kasutatakse määratud soost töötajate arvu salvestamiseks
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

---Väljundvalikut kasutatakse töötajate koguarvu salvestamiseks tabelis Töötajad.
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end
--- käivitame sp
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--- Salvestatud protseduur võtab väljundparameetrina kaks sisendparameetrit: "Id" tüüpi "int" ja "FirstName" tüüpi "nvarchar(50)". Väljundparameetrit kasutatakse määratud ID-ga töötaja nime salvestamiseks.
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from employees where Id = @Id
end

--muutuja "FirstName" tüüpi "nvarchar(50)" ja seejärel käivitab salvestatud protseduuri "spGetNameById1" sisendparameetritega "Id=6" ja "FirstName" väljundparameetrina. Seejärel prinditakse salvestatud protseduuri tulemus PRINT-lause abil.
declare @FirstName nvarchar(50)
execute spGetNameById1 6, @FirstName output
print 'Name of the employee = ' + @FirstName

--Запрос в хранимой процедуре использует инструкцию «SELECT» для извлечения столбца «FirstName» из таблицы «Employees», где столбец «Id» соответствует входному параметру « Id». Результат оператора «SELECT» затем возвращается с помощью оператора «RETURN».
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- возвращает имя сотрудника с идентификатором 1 из таблицы «Сотрудники». Возвращаемое значение присваивается переменной « EmployureName» с помощью инструкции EXEC.
declare @EmployeeName nvarchar(50)
exec @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

select * from Employees
