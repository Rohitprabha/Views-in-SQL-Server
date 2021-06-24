--Simple view 

--Creating View with all columns 
create view vwAllEmployees1 As Select * from Employee1

--Creating View with specific columns
create view vwAllEmployees2 As Select ID,Name,Department from Employee1

select * from vwAllEmployees1
select * from Employee1

--DML Operations on the View

--Insert Operation on View
insert vwAllEmployees1 values(13,'Rohit','IT',20000)

--Update Operation on View
update vwAllEmployees1 set Salary = 30000 where ID=13

--Delete Operation on View
DELETE FROM vwAllEmployees1 where ID = 13

select * from vwAllEmployees1
select * from Employee1

--Complex View

CREATE VIEW vwEmployeesByDepartment AS SELECT emp.EmpID, emp.EmpName, emp.Salary, emp.EmpAddress, emp.DeptID,
dept.DeptName AS DepartmentName FROM Employee emp INNER JOIN Department dept ON emp.DeptID = dept.DeptID

select * from vwEmployeesByDepartment

--DML Operations on the View

insert into vwEmployeesByDepartment values(110,'Mandy',40000,'IT','BVRM')	--error

--Below update will Execute because modification is only on single table and also Department table doesnot contain Salary column
update vwEmployeesByDepartment set Salary = 40000 where EmpID=102

update vwEmployeesByDepartment set  Salary = 40000, DepartmentName='IT' where EmpID=102		--error

DELETE FROM vwEmployeesByDepartment WHERE EmpID=106				--error

--Limitations and Dis-Advantages of Views in SQL Server

-- Error: Cannot pass Parameters to a View
CREATE VIEW vwEmployeeDepartment @Dept varchar(20) AS SELECT ID, Name, Department FROM  Employee1 WHERE Department = @Dept

--Error : The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified. 
CREATE VIEW vwEmployeeDetailsSortedByName1 AS SELECT ID, Name, Department FROM  Employee1 ORDER BY Name

--Use TOP Clause to support Order By clause in SQL Server
CREATE VIEW vwEmployeeDetailsSortedByName AS SELECT TOP 100 PERCENT ID, Name, Department FROM  Employee1 ORDER BY Name

select * from vwEmployeeDetailsSortedByName

--Use Table-Valued functions in SQL Server as a replacement for parameterized views
select * from fn_EmployeeByDepartment('IT')


CREATE VIEW vwTotalSalesPriceByProduct
WITH SCHEMABINDING
AS
SELECT Name, 
  COUNT_BIG(*) AS TotalTransactions,
  SUM(ISNULL((QuantitySold * UnitPrice), 0)) AS TotalSalesPrice  
FROM dbo.ProductSales prdSales
INNER JOIN dbo.Product prd
ON prdSales.ProductId = prd.ProductId
GROUP BY Name

--Creating an index on a view
CREATE UNIQUE CLUSTERED INDEX UIX_vwTotalSalesPriceByProduct_Name ON vwTotalSalesPriceByProduct(Name) 

Select * from vwTotalSalesPriceByProduct
