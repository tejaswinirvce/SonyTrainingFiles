use newwarehouse

alter table orders
drop constraint cust_def

alter table employee
drop constraint chk_date

---Contraints - not null, default, check,unique,Pk,Fk,rule
--default - second method
alter table employee
add constraint emp_def
default 'unknown' for empname

use MovieDB
create table MReview
(
ReviewId int identity(1,1),
Review nvarchar(max),
MovieId int not null
)

sp_help MReview





alter table MReview
add constraint fk_rev
foreign key (MovieId)
references Movie(MovieId)


select * from Movie

insert MReview(Review, MovieId)
values ('Great movie',1005)
('not bad movie',1002)

select * from MReview
alter table 

drop table MReview

--default as independant object -- third method - reusability
create default defgeneral as 'xyz'

use newwarehouse
Exec sp_bindefault defgeneral,'Movie_From_Access.Movie_Name'
exec sp_unbindefault 'Movie_From_Access.Movie_Name'

--check constraint
alter table employee
add constraint chkdt
check  (hiredate < getdate())
	
	--unique constraint
alter table employee
add constraint unq_id
unique (mgrid)

---rule
CREATE RULE sal_code  AS @salerule IN (1000,2000,3000)

EXEC sp_bindrule sal_code,  'Employee.salary' 


sp_help employee