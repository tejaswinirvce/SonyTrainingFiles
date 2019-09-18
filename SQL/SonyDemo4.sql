-- Index - 2 types - clustered/nonclustered index
--clustered index - automatically created with pK - table only one clustered index
--physically alter - match with the table rows

use SonyDB

create clustered index myidx
on employees(empid)
with pad_index,fillfactor = 50

--non-clustered index - many indexes to the table

create  nonclustered index myidx2
on employees(empid,salary)

drop index employees.myidx2
sp_help employees

--view - selectively few columns from a single table or more than one table can be organized 
-- as a view - Can index the view - to be stored in the disk
create view Vw_Emp
with encryption
as
select empid,firstname,lastname
from
Employees

drop view Vw_Emp

sp_helptext vw_emp

select * from Vw_Emp
sp_help Vw_Emp

--Triggers-- Called when the DML actions are made which are tied to the triggers
--explicitly called
--sample tables
create table sample1(ssid int, sdec varchar(10))
create table sample3(ssid int, sdec varchar(10))
create table sample2(ssid int, sdec varchar(50),sndec varchar(50))

--INSERT TRIGGER--
create trigger trinsert1
on sample3
for insert
as
print 'First trigger - row inserted at: '
print getdate()
go

insert into sample1
values (1,'random'),
(2,'test2')


--Delete trigger
--DELETE TRIGGER

Create trigger trdel1
on sample2
for delete 
as

begin
declare @ssid int

select @ssid = deleted.ssid
from deleted

insert into sample3
values(@ssid,'Deleted')
end

select * from sample2
select * from sample3

delete from sample2
where ssid=2

--Instead of trigger
Create trigger trg_Del_Cust
on sample1 
instead of delete
as
 begin
set nocount on
update sample1
set sdec = 'not active'
from sample1 s1 inner join deleted d on s1.ssid = d.ssid
end

select * from sample1

delete from sample1
where ssid=2

use sonydb

--Transactions
--Implicit transactions
update Employees
set firstname = 'Krish'
where firstname = 'Ezhil'

delete Employees
where firstname ='Maya'

select * from employees

--Explicit transaction
begin tran mytran
update Employees
set firstname = 'Krish'
where firstname = 'Ezhil'
--insert
--call sp
--update
--delete
if @@error = 0
begin
commit tran
print 'Commiting the trans - updating the employee'
end
else
begin
print 'Error - Rolling back'
rollback tran
end

select * from Employees

use master
--Savepoints
begin tran mytrans3  with mark N'New trans for employee'
save tran pt1

delete Employees
where empid =1

save tran pt2
delete Employees
where empid =2

rollback tran pt2
rollback tran pt1

rollback

select * from Employees