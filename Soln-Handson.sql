create database SOT;
use SOT;

-- Create Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    Location VARCHAR(100),
    ManagerID INT
);

-- Insert data into Department table
INSERT INTO Department (DepartmentID, DepartmentName, Location, ManagerID)
VALUES (1, 'HR', 'New York', 101),(2, 'Finance', 'Chicago', 102), (3, 'Engineering', 'San Francisco', 103),(4, 'Marketing', 'Los Angeles', 104),
(5, 'Sales', 'Miami', 105);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert data into Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES (1, 'John', 'Doe', 60000, 1), (2, 'Jane', 'Smith', 65000, 2), (3, 'Michael', 'Brown', 70000, 3),(4, 'Emily', 'Davis', 72000, 3),
(5, 'James', 'Wilson', 58000, 4), (6, 'Sarah', 'Johnson', 75000, 5), (7, 'David', 'Martinez', 80000, 1), (8, 'Laura', 'Garcia', 55000, 2),
(9, 'Chris', 'Lee', 67000, 3), (10, 'Anna', 'Kim', 60000, 4), (11, 'Mark', 'Clark', 82000, 5), (12, 'Sophia', 'Hall', 71000, 1),
(13, 'Daniel', 'Allen', 63000, 2), (14, 'Olivia', 'Young', 76000, 5),(15, 'Noah', 'King', 62000, 4);

select * from Department;
select * from Employee;

-- 01
select distinct(DepartmentName) as "Department Name",sum(Salary) as "Salary"
from Department
join Employee 
on Employee.DepartmentID = Department.DepartmentID
group by DepartmentName ; 

-- 02
select FirstName,LastName,DepartmentName
from Employee
join Department
on Employee.DepartmentID = Department.DepartmentID
where Salary > 70000;

-- 03
insert into Department(DepartmentID,DepartmentName,Location,ManagerID)
values("6","Research and Development","Boston","110");

-- 04
update Department 
join Employee 
on Department.DepartmentID = Employee.DepartmentID
set DepartmentName = "Marketing" 
where  concat(FirstName,"",LastName) = "Emily Davis";

-- 05
select FirstName,LastName
from Department
join Employee
on Department.DepartmentID = Employee.DepartmentID
where Employee.DepartmentID is NULL;

SET SQL_SAFE_UPDATES = 0;

update Department
set DepartmentID = null
where DepartmentID = ( select departmentID from department where DepartmentName = "Sales");
Delete from Department 
where DepartmentID = "Sales";


-- 07
select FirstName,LastName,Salary,DepartmentName
from Department
join Employee
on Department.DepartmentID = Employee.DepartmentID
order by Salary desc
limit 1;

-- 08
select round(avg(salary),2) as "Average Salary of Engineering Dept "
from Department
join Employee
on Department.DepartmentID = Employee.DepartmentID
where DepartmentName = "Engineering";

-- 09
select FirstName,LastName,DepartmentName
from Department
join Employee
on Department.DepartmentID = Employee.DepartmentID
order by DepartmentName;

-- 10
update Employee
set Salary = Salary * 1.05;










