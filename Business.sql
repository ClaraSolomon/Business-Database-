--Question 1 
Create index idkHire 
on HumanResources.Employee (HireDate)

--Question 2
--Part 1 create column
Alter table Person.Person add FullName varchar(100)
--Part 2 update the created column
update Person.Person set FullName = Concat(FirstName, ' ', MiddleName, ' ', LastName)
--Part 3 create a view to view the old and new columns
Create view vPersonNames as
Select FirstName, MiddleName, LastName, FullName
from Person.Person

--Question 3
Select FirstName, MiddleName,  FullName from vPersonNames

--Question 4
Create view vEmployee
as
Select  Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName, Person.Person.FullName
from Person.Person
Inner join HumanResources.EmployeeDepartmentHistory on Person.Person.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
where EndDate is null

--Question 5
Create view vTenYear
as
Select Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName, Person.Person.FullName
from Person.Person
Inner join HumanResources.EmployeeDepartmentHistory on Person.Person.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
where (StartDate < '2011-11-15') 

--Question 6
Create procedure OldestHire (@BirthDate int) as
select BusinessEntityID, BirthDate
from HumanResources.Employee
order by BirthDate Asc

--Question 7
use AdventureWorks2019
go 
create procedure spEmployee
as
begin
set nocount on
select FirstName, MiddleName, LastName, FullName
from Person.Person
end

--Question 8
exec spEmployee

--Question 9 
use AdventureWorks2019
go 
create procedure spEmployeeByID 
as
Begin
set nocount on
select BusinessEntityID, FirstName, MiddleName, LastName, FullName
from Person.Person
where BusinessEntityID = 12
end

--Question 10
execute spEmployeeByID 

--Question 11
use AdventureWorks2019
go 
create procedure spVerifiedEmployeeByID
as
Begin
set nocount on
select  FirstName, MiddleName, LastName, FullName
from Person.Person
join HumanResources.EmployeeDepartmentHistory 
on 
Person.Person.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
where HumanResources.EmployeeDepartmentHistory.EndDate is null
or HumanResources.EmployeeDepartmentHistory.EndDate is not null print 'Not a valid Employee'

end
