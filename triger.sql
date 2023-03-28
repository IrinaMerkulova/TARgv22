----------------------------------
--tund 4 --- trigger

-- triggereid on kolme tüüpi
--1. DML trigger
--2. DDL trigger
--3. LOGON trigger


--- DML - data manipulation manipulation
--- DML-i peamised käsud: Insert, Update ja Delete

-- after trigger:  käivitub peale mingit tegevust
-- instead trigger: käivitub enne triggeri tegevuse toimumist

create table EmployeeTrigger 
(
Id int primary key,
Name varchar(30),
Salary int,
Gender nvarchar(10),
DepartmentId int
)
Select * from EmployeeTrigger
-- andmed EmployeeTrigger tabelisse lisatud
insert into EmployeeTrigger values(1, 'John', 5000, 'Male', 3)
insert into EmployeeTrigger values(2, 'Mike', 3400, 'Male', 2)
insert into EmployeeTrigger values(3, 'Pam', 6000, 'Female', 1)
insert into EmployeeTrigger values(4, 'Todd', 4800, 'Male', 4)
insert into EmployeeTrigger values(5, 'Sara', 3200, 'Female', 1)
insert into EmployeeTrigger values(6, 'Ben', 4800, 'Male', 3) 

Select * from EmployeeTrigger
--tehtud
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)



--?
create trigger tr_Employee_ForInsert
on EmployeeTrigger
for insert
as begin
	declare @Id int
	select @Id = Id from inserted

	insert into EmployeeAudit
	values('New employee with Id = ' + cast(@Id as nvarchar(5)) 
	+ ' is added at ' + cast(Getdate() as nvarchar(20)))
end

insert into EmployeeTrigger values(7, 'Jimmy', 1800, 'Male', 3)

select * from EmployeeAudit

--- ?
create trigger EmployeeForDelete
on EmployeeTrigger
for delete
as begin
	declare @Id int
	select @Id = Id from deleted
	
	insert into EmployeeAudit
	values('An existing employee with Id = ' + CAST(@Id as nvarchar(5))
	+ ' is deleted at ' + cast(GETDATE()as nvarchar(20)))
end

delete from EmployeeTrigger where Id = 7

select * from EmployeeAudit

--- after trigger
-- kasutavad kahte tabelit, milleks on INSERTED ja DELETED

-- after trigger näide / tehtud
create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	select * from deleted
	select * from inserted
end

update EmployeeTrigger set Name = 'Todd', Salary = 2345,
Gender = 'Male' where Id = 4


--- ?
create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	-- deklareerisime muutujad, mida hakkame kasutama
	Declare @Id int
	declare @OldName nvarchar(30), @NewName nvarchar(30)
	declare @OldSalary int, @NewSalary int
	declare @OldGender nvarchar(10), @NewGender nvarchar(10)
	declare @OldDeptId int, @NewDeptId int
	-- muutuja, millega hakkame ehitama audit build-i
	declare @AuditString nvarchar(1000)
	-- sisestab andmed temp table-sse
	select * into #TempTable
	from inserted

	while(exists(select Id from #TempTable))
	begin
		-- tühja stringi initsialiserimine
		Set @AuditString = ''

		-- selekteerime esimese rea andmed temp table-st 
		select top 1 @Id = Id, @NewName = Name,
		@NewGender = Gender, @NewSalary = Salary,
		@NewDeptId = DepartmentId
		from #TempTable

		-- selekteerib käesoleva rea kustutatud tabelist
		select @OldName = Name,
		@OldGender = Gender, @OldSalary = Salary,
		@OldDeptId = DepartmentId
		from deleted where Id = @Id

		--- ehitame audit stringi dünaamiliseks
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4))
		+ ' changed '

		if(@OldName <> @NewName)
			set @AuditString = @AuditString + ' Name from ' + @OldName + ' to '
			+ @NewName

		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to '
			+ @OldGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' 
			+ CAST(@OldSalary as nvarchar(10))
			+ ' to ' + CAST(@NewSalary as nvarchar(10))

		if(@OldDeptId <> @NewDeptId)
			set @AuditString = @AuditString + ' DepartmentId from ' 
			+ CAST(@OldDeptId as nvarchar(10))
			+ ' to ' + CAST(@NewDeptId as nvarchar(10))

		insert into EmployeeAudit values(@AuditString)

		-- kustutab kogu info temp table-st
		delete from #TempTable where Id = @Id
	end
end

select * from EmployeeTrigger

update EmployeeTrigger set Name = 'Todd123', Salary = 3456,
Gender = 'Female', DepartmentId = 3 
where Id = 4

select * from EmployeeTrigger
select * from EmployeeAudit

--?
create table Department
(
Id int primary key,
DeptName nvarchar(20)
)

insert into Department values(1, 'IT')
insert into Department values(2, 'Payroll')
insert into Department values(3, 'HR')
insert into Department values(4, 'Admin')


-- enne triggeri tegemist tuleb teha vaade?
create view vEmployeeDetails
as
select EmployeeTrigger.Id, Name, Gender, DeptName
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id



---- instead of insert trigger
create trigger trEmployeeDetailsInsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = Department.Id
	from Department 
	join inserted
	on inserted.DeptName = Department.DeptName

	if(@DeptId is null)
	begin
		raiserror('Invalid Department Name. Statement terminated', 16, 1)
		return
	end

	insert into EmployeeTrigger(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end
--- raiserror funktsioon
-- selle eesmärk on välja tuua veateade, kui DepartmentName veerus ei ole väärtust
-- ja ei ühti sisestatud väärtusega
-- esimene parameeter on veateate sisu, teiene on veatase (nr 16 tähendab üldiseid vigu),
-- kolmas on veaolek

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'assd')

delete from EmployeeTrigger where Id = 7
--- 10 tund SQL
select * from EmployeeTrigger
select * from vEmployeeDetails


update vEmployeeDetails
set DeptName = 'Payroll'
where Id = 2

--- teeme vaate
alter view vEmployeeDetailsUpdate
as
select EmployeeTrigger.Id, Name, Salary, Gender, DeptName
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id

select * from vEmployeeDetailsUpdate
update EmployeeTrigger set DepartmentId = 4
where Id = 4

--- ?
alter trigger trEmployeeDetailsInsteadOfUpdate
on vEmployeeDetailsUpdate
instead of update
as begin
	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(UPDATE(DeptName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DeptName = Department.DeptName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update EmployeeTrigger set DepartmentId = @DeptId
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(update(Gender))
	begin
		update EmployeeTrigger set Gender = inserted.Gender
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Name))
	begin
		update EmployeeTrigger set Name = inserted.Name
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Salary))
	begin
		update EmployeeTrigger set Salary = inserted.Salary
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end
end

select * from EmployeeTrigger

update vEmployeeDetailsUpdate
set Name = 'Johny', Gender = 'Female', DeptName = 'IT'
where Id = 1


--- ?

create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
	delete EmployeeTrigger
	from EmployeeTrigger
	join deleted
	on EmployeeTrigger.Id = deleted.Id
end

delete from vEmployeeDetails where Id = 2
--- kui seda triggerit ei oleks, siis annaks veateate
