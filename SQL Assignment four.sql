/*1.	What is View? What are the benefits of using views?
 1) View is a virtual table based on the result-set of an SQL statement. 
 View is a select statement.
 2) Views can represent a subset of the data contained in a table. 
Views can join and simplify multiple tables into a single virtual table.
Views can act as aggregated tables, where the database engine aggregates data (sum, average, etc.) and presents the calculated results as part of the data.
Views can hide the complexity of data. 
Views take very little space to store.
Depending on the SQL engine used, views can provide extra security.

2.	Can data be modified through views?
We can modify the data of an underlying base table through a view, as long as the following conditions are true:
1) Any modifications, including UPDATE, INSERT, and DELETE statements, 
must reference columns from only one base table.
2) The columns being modified in the view must directly reference the underlying data 
in the table columns. The columns cannot be derived in any other way, 
such as through the following:
An aggregate function: AVG, COUNT, SUM, MIN, MAX, GROUPING, STDEV, STDEVP, VAR, and VARP.
A computation. The column cannot be computed from an expression that uses other columns. 
Columns that are formed by using the set operators UNION, UNION ALL, CROSSJOIN, EXCEPT, 
and INTERSECT amount to a computation and are also not updatable.
3) The columns being modified are not affected by GROUP BY, HAVING, or DISTINCT clauses.
4) TOP is not used anywhere in the select_statement of the view together with 
the WITH CHECK OPTION clause.

3.	What is stored procedure and what are the benefits of using it?
1) A stored procedure is a prepared SQL code that you can save, 
so the code can be reused over and over again.
2) Better Performance � The procedure calls are quick and 
efficient as stored procedures are compiled once and stored in executable form.
Higher Productivity
Ease of Use
Scalability
Maintainability
Security 

4.	What is the difference between view and stored procedure?
A Stored Procedure:
Accepts parameters
Can NOT be used as building block in a larger query
Can contain several statements, loops, IF ELSE, etc.
Can perform modifications to one or several tables
Can NOT be used as the target of an INSERT, UPDATE or DELETE statement.
A View:
Does NOT accept parameters
Can be used as building block in a larger query
Can contain only one single SELECT query
Can NOT perform modifications to any table
But can (sometimes) be used as the target of an INSERT, UPDATE or DELETE statement.

5.	What is the difference between stored procedure and functions?
The function must return a value but in Stored Procedure it is optional. 
Even a procedure can return zero or n values. 
Functions can have only input parameters for it whereas Procedures can have input or output parameters. 
Functions can be called from Procedure whereas Procedures cannot be called from a Function.

6.	Can stored procedure return multiple result sets?
Yes, most stored procedures return multiple result sets. 
Such a stored procedure usually includes one or more select statements. 

7.	Can stored procedure be executed as part of SELECT Statement? Why?
Stored procedures are typically executed with an EXEC statement. 
We can execute a stored procedure implicitly from within a SELECT statement, 
provided that the stored procedure returns a result set.

8.	What is Trigger? What types of Triggers are there?
1) A database trigger is procedural code that is automatically executed 
in response to certain events on a particular table or view in a database. 
The trigger is mostly used for maintaining the integrity of the information on the database.
2) DDL Trigger
DML Trigger
Logon Trigger

9.	What are the scenarios to use Triggers?
Log table modifications. Some tables have sensitive data such as customer email, 
employee salary, etc., that you want to log all the changes.
Enforce complex integrity of data.

10.	What is the difference between Trigger and Stored Procedure?
A stored procedure is a user defined piece of code written in the local version of PL/SQL, 
which may return a value (making it a function) that is invoked by calling it explicitly. 
A trigger is a stored procedure that runs automatically when various events happen 
(eg update, insert, delete).
*/

use Northwind
go
--1.	Lock tables Region, Territories, EmployeeTerritories and Employees. 
--Insert following information into the database. 
--In case of an error, no changes should be made to DB.
--a.	A new region called �Middle Earth�;
insert into Lock (Region) values ('Middle Earth')
--b.	A new territory called �Gondor�, belongs to region �Middle Earth�;
update Lock set Territories = 'Aragorn King' where Region = 'Middle Earth'
--c.	A new employee �Aragorn King� who's territory is �Gondor�.
insert into Lock (Territories, Employee) values ('Gondor', 'Aragorn King')
--2.	Change territory �Gondor� to �Arnor�.
update Lock set Territories = 'Gondor' where Territories = 'Arnor'

--3.	Delete Region �Middle Earth�. (tip: remove referenced data first) 
--(Caution: do not forget WHERE or you will delete everything.) 
--In case of an error, no changes should be made to DB. Unlock the tables mentioned 
--in question 1.
Delete from Lock where Region = 'Middle Earth'

--4.	Create a view named "view_product_order_[your_last_name]", 
--list all products and total ordered quantity for that product.
create view view_product_order_[your_last_name] as 
select productID, sum(quantity) as Total_Quantity
from [Order_details]
group by productID

--5.	Create a stored procedure �sp_product_order_quantity_[your_last_name]� 
--that accept product id as an input and total quantities of order as output parameter.

--6.	Create a stored procedure �sp_product_order_city_[your_last_name]� 
--that accept product name as an input and top 5 cities that ordered most 
--that product combined with the total quantity of that product ordered from that city as output.

--7.	Lock tables Region, Territories, EmployeeTerritories and Employees. 
--Create a stored procedure �sp_move_employees_[your_last_name]� 
--that automatically find all employees in territory �Tory�; 
--if more than 0 found, insert a new territory �Stevens Point� of region �North� 
--to the database, and then move those employees to �Stevens Point�.

--8.	Create a trigger that when there are more than 100 employees in territory 
--�Stevens Point�, move them back to Troy. (After test your code,) remove the trigger. 
--Move those employees back to �Troy�, if any. Unlock the tables.

--9.	Create 2 new tables �people_your_last_name� �city_your_last_name�. 
--City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. 
--People has three records: {id:1, Name: Aaron Rodgers, City: 2}, 
--{id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. 
--Remove city of Seattle. If there was anyone from Seattle, put them into a new city �Madison�. 
--Create a view �Packers_your_name� lists all people from Green Bay. 
--If any error occurred, no changes should be made to DB. (after test) 
--Drop both tables and view.
create table people_your_last_name (id int, Name varchar(20), City int)
create table city_your_last_name (id int, name varchar(20))
insert into city_your_last_name values (1, 'Seattle'), (2, 'Green Bay')
insert into people_your_last_name values (1, 'Aaron Rodgers', 2), (2, 'Russell Wilson', 1), (3, 'Jody Nelson', 2)
update city_your_last_name set City = 'Madison' where City = 'Seattle'
create view Packers_your_name as
select people_your_last_name.ID from people_your_last_name
where people_your_last_name.city = city_your_last_name.id
Drop table city_your_last_name
drop table people_your_last_name

--10.	 Create a stored procedure �sp_birthday_employees_[you_last_name]� 
--that creates a new table �birthday_employees_your_last_name� 
--and fill it with all employees that have a birthday on Feb. 
--(Make a screen shot) drop the table. Employee table should not be affected.

--11.	Create a stored procedure named �sp_your_last_name_1� that returns all cites 
--that have at least 2 customers who have bought no or only one kind of product. 
--Create a stored procedure named �sp_your_last_name_2� 
--that returns the same but using a different approach. (sub-query and no-sub-query).

--12.	How do you make sure two tables have the same data?
SELECT * FROM Table1
UNION
SELECT * FROM Table2

/*14. First Name	Last Name	Middle Name
John	Green	
Mike	White	M
Output should be
Full Name
John Green
Mike White M.
Note: There is a dot after M when you output.*/
select [First Name]+' '+ [Last Name] + (case when [Middle Name] is not null 
then ' ' + [Middle Name] + '.' else ' ' end) as [Full Name]
from table

/*15.
Student	Marks	Sex
Ci	70	F
Bob	80	M
Li	90	F
Mi	95	M
Find the top marks of Female students.
If there are two students have the max score, only output one.*/
select top 1 student, Marks from table 
where Sex = 'F'
order by 2 desc, 1

/*16.
Student	Marks	Sex
Li	90	F
Ci	70	F
Mi	95	M
Bob	80	M
How do you out put this?*/
select top 1 student, Marks from table 
where Sex = 'F'
order by 2 desc, 1








