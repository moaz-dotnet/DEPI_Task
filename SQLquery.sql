CREATE DATABASE DEPI_SQL
use DEPI_SQL

CREATE TABLE EMPLOYEE (
    EmpID INT IDENTITY PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    DeptID INT NOT NULL,
    SupervisorID INT NULL,
    HireDate DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT CHK_Emp_Gender CHECK (Gender IN ('M','F'))
);
CREATE TABLE DEPARTMENT (
    DeptID INT IDENTITY PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL,
    ManagerID INT NULL,
    ManagerHireDate DATE
);

CREATE TABLE PROJECT (
    ProjectID INT IDENTITY PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    DeptID INT NOT NULL,
    CONSTRAINT FK_Project_Dept
        FOREIGN KEY (DeptID)
        REFERENCES DEPARTMENT(DeptID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--DEPENDENT

CREATE TABLE DEPENDENT (
    DependentID INT IDENTITY PRIMARY KEY,
    DependentName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BirthDate DATE NOT NULL,
    EmpID INT NOT NULL,
    CONSTRAINT CHK_Dep_Gender CHECK (Gender IN ('M','F')),
    CONSTRAINT FK_Dependent_Emp
        FOREIGN KEY (EmpID)
        REFERENCES EMPLOYEE(EmpID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--WORKS_ON (M:N)

CREATE TABLE WORKS_ON (
    EmpID INT NOT NULL,
    ProjectID INT NOT NULL,
    WorkingHours DECIMAL(5,2) NOT NULL DEFAULT 0,
    CONSTRAINT PK_WorksOn PRIMARY KEY (EmpID, ProjectID),
    CONSTRAINT FK_WorksOn_Emp FOREIGN KEY (EmpID)
        REFERENCES EMPLOYEE(EmpID)
        ON DELETE CASCADE,
    CONSTRAINT FK_WorksOn_Project FOREIGN KEY (ProjectID)
        REFERENCES PROJECT(ProjectID)
        ON DELETE CASCADE
);
-- ALTER TABLE 


ALTER TABLE EMPLOYEE
ADD Email VARCHAR(100);


ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_Emp_Dept
FOREIGN KEY (DeptID)
REFERENCES DEPARTMENT(DeptID)
ON UPDATE CASCADE;
go

ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_Dept_Manager
FOREIGN KEY (ManagerID)
REFERENCES EMPLOYEE(EmpID)
ON UPDATE CASCADE;
go



ALTER TABLE EMPLOYEE
ALTER COLUMN Email VARCHAR(150);
go

ALTER TABLE EMPLOYEE
DROP CONSTRAINT CHK_Emp_Gender;
go

INSERT INTO DEPARTMENT (DeptName, Location)
VALUES
('IT','Cairo'),
('HR','Alex'),
('Finance','Giza');
go


INSERT INTO EMPLOYEE (Fname,Lname,BirthDate,Gender,DeptID)
VALUES
('Ahmed','Ali','1990-05-01','M',1),
('Sara','Hassan','1992-07-20','F',2),
('Mohamed','Khaled','1988-11-12','M',3),
('Mona','Samir','1995-02-28','F',1),
('Omar','Tarek','1991-09-10','M',2);
go

UPDATE DEPARTMENT
SET ManagerID = 1, ManagerHireDate = '2023-01-01'
WHERE DeptID = 1;
go

INSERT INTO PROJECT (ProjectName, City, DeptID)
VALUES
('Website','Cairo',1),
('Recruitment','Alex',2),
('Budget','Giza',3);
go

INSERT INTO DEPENDENT (DependentName,Gender,BirthDate,EmpID)
VALUES
('Ali','M','2015-03-01',1),
('Lina','F','2018-06-12',4);
go

INSERT INTO WORKS_ON VALUES
(1,1,40),
(4,1,20),
(2,2,35);
go

















