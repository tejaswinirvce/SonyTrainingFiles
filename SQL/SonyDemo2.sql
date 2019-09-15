--Table Creation

Create table Employees
(

empid int not null,
firstname varchar(30) not null,
lastname varchar(30) not null,
fullname as firstname + ' ' + lastname,
hiredate date not null,
salary money  null 

);


insert into Employees
values (2,'Maya','Aparajit','09/12/2019',3, 'Zoology' ,100000)

select * from employees 

delete employees

drop table employees


------ Data Integrity -----

---Primary Key
alter table Employees
add constraint pkemp
primary key(empid) 

--- Unique
alter table employees
add constraint ukemp
unique(firstname)

---Foriegn key


SELECT * FROM INFORMATION_SCHEMA.TABLES

sp_help employees


select @@SERVERNAME as 'My sql version'

if OBJECT_ID('dbo.employees','U') is not null
drop table dbo.employees

--DIE
drop table if exists dbo.employee
drop trigger if exists dbo.employee
drop index if exists dbo.employee


use SonyDB
--uid
create table dept
(
deptid uniqueidentifier not null default newid(),
deptname nvarchar(50) not null,
empno int 

)

insert into dept (deptname,empno)
values ('Zoology',23),
('HR',25),
('Operations',50),
('Accounts',60)
 
 select * from dept

--rules

create rule rule_dept_nm as @dtnm in ('Zoology','English','Hindi')

execute sp_unbindrule rule_dept_nm, 'employees.ssn'  

select * from employees

sp_help employees



--db help

use prod2
sp_helpdb prod2

select DATABASEPROPERTYEX('prod2','recovery')

dbcc shrinkdatabase ('prod2',30)


--select into
select * from dept2


select deptname,empno 
into #dept2
from dept

--copy rows from onr table to another
insert into table1 select * from table2



--Querying with order,group,having

use TSQL2012

select categoryid,sum(unitprice) as totalcost
from production.products
group by categoryid
order by totalcost desc

select * from production.products


select empid,year(orderdate) as orderyear,
count (distinct custid) as NumberofCustomers
from sales.Orders
group by empid,year(orderdate)


--having


select * from Sales.Orders

select empid,year(orderdate) as orderYear
from sales.orders
where custid = 71
group by empid,year(orderdate)
having count(*) >1


--string/date

select left('lazy duck',3) as stringresult


SELECT PARSE('02/12/2007' AS DATETIME USING 'en-US');

SELECT PARSE('02/12/2007' AS DATETIME USING 'en-GB');

select dateadd(day,1,'20180212')
select datediff(day,'20180601',getdate())

SELECT
  DAY('20090212') AS theday,
  MONTH('20090212') AS themonth,
  YEAR('20090212') AS theyear;

  select DATENAME(dayofyear,'20190620')

  --programming syntx

  declare @age int
  set @age=19
  if @age >= 18
  print 'You are good to vote'
  else
  begin
	if @age >= 10
	print 'Wait for 8 more years..'
	else
	print 'few more yrs to go'
	end

	--while
	
	declare @n as int = 1
	while @n <=10
	begin
	if @n = 4
	break
	set @n = @n + 1
	print @n
	end

	print 'while..'

	--select/case

	declare @choice int
	set @choice=0
	select case @choice
	when 0 then 'Friday'
	when 1 then 'Saturday'
	when 2 then 'Sunday'
	else 'Select proper choice'
	end

	use SonyDB

	--Stored Procedure - 3 steps
	create proc Calc
	--I - Declare varibles - input/output
	@num1 int,
	@num2 int,
	@result int out
	--II - write the logic for the procedure
	as
	begin
	set @result = @num1 + @num2
	end
	--
	--III - Execute or call the SP
	
	declare @res int
	exec Calc 20,30,@res out
	
	select @res as 'Result of Calc SP'
	