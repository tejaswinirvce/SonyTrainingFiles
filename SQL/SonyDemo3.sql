use TSQL2012

--stored proc

alter proc getorders

--I - declare variable
--@custid int,
@fromdate datetime,
@todate datetime,
@numrows int out
as

--II logic for SP

select o.orderid, o.custid, c.contactname
from sales.Orders o join Sales.Customers c on o.custid = c.custid
where  o.orderdate >= @fromdate and orderdate < @todate

set @numrows = @@ROWCOUNT
select @numrows as 'Total rows'

---sp--end--


---III Execute Sp

DECLARE @rc AS INT;

EXEC getorders 
  @fromdate = '20070101',
  
  @todate   = '20080101',
  @numrows  = @rc OUTPUT;



  -- User defined Functions

  alter function calculate(@num1 int, @num2 int)
  returns int
  
  as
  begin
  --
  --
  return @num1+@num2
  end
	
	select dbo.calculate(25,56) as 'Result from Function:Calculate'

	--Joins

	--return all the germany customers, total number of orders, total qty

	use tsql2012

	select c.contactname,c.custid, 
	count(distinct  o.orderid) as NumofOrders, 
	sum(od.qty) as TotalQty 
	from sales.Customers as c 
	join sales.orders as o
	on o.custid = c.custid
	join sales.OrderDetails as od
	on od.orderid = o.orderid
	where c.country = 'Germany'
	group by c.custid, c.contactname


	