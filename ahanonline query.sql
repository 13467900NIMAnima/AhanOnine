select * from Sales_Table 

--1
select SUM([Quantity]*[UnitPrice]) from [dbo].[Sales_Table]

--2
select count(DISTINCT([Customer])) from [dbo].[Sales_Table]

--3
select product,SUM([Quantity]*[UnitPrice]) from [dbo].[Sales_Table] group by [Product]

--4
select table1.[Customer],sum(table1.[Quantity]*table1.[UnitPrice]) as total_buy,count(distinct(table1.OrderID)) as invoice_count,sum(table1.[Quantity]) as quant_sum from [dbo].[Sales_Table] as table1 right join
(select [OrderID],[Customer],SUM([Quantity]*[UnitPrice]) as invoicesum from [dbo].[Sales_Table] where [Quantity]*[UnitPrice]>1500  group by [OrderID],[Customer] ) as table2 on(table1.Customer=table2.Customer)
group by table1.Customer

--5
select sum(UnitPrice*Quantity) as total_sale,sum(UnitPrice*Quantity*ProfitRatio) as total_profit,(sum(UnitPrice*Quantity*ProfitRatio)/sum(UnitPrice*Quantity)) from [dbo].[Sales_Table] left join [dbo].[Sales_Profit]  on [dbo].[Sales_Table].Product=[dbo].[Sales_Table].Product



--6
select count(distinct(table3.b)) as customer_count_buying from 
(select *,cast([Customer] as varchar)+cast([Date] as varchar) as b  from [dbo].[Sales_Table] ) as table3



-7
WITH EMP_CTE AS
(
SELECT EmployeeId, EmployeeName, ManagerId, CAST('' AS VARCHAR(50)) ManagerName, 1 AS EmployeeLevel FROM tbEmployee WHERE ManagerId IS NULL
UNION ALL
SELECT T.EmployeeId,T.EmployeeName, T.ManagerId,CAST(C.EmployeeName AS VARCHAR(50)) ManagerName, EmployeeLevel + 1 AS EmployeeLevel FROM tbEmployee AS T
INNER JOIN EMP_CTE  AS C ON C.EmployeeId=T.ManagerId
)
SELECT EmployeeName,EmployeeLevel FROM EMP_CTE


