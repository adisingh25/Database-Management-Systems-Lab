CREATE DATABASE DBMS_LAB;
SHOW DATABASES;
USE DBMS_LAB;

SHOW TABLES;


CREATE TABLE employee
(
	SSN varchar(10) PRIMARY KEY,
	Name varchar(10) not null,
	DeptNo int not null
);




CREATE TABLE project
(
	ProjectNo int PRIMARY KEY,
	ProjectArea varchar(10)
);


CREATE TABLE assigned_to
(
	SSN varchar(10) not null,
	ProjectNo int not null,
	FOREIGN KEY (SSN) REFERENCES employee(SSN) ON DELETE CASCADE,
	FOREIGN KEY (ProjectNo) REFERENCES project(ProjectNo)
	ON DELETE CASCADE
);


INSERT INTO EMPLOYEE VALUES
	(1,'ADITYA',1),
    (2,'VANSH',3),
    (3,'ALOK',4),
    (4,'MEHUL',2),
    (5,'PAWAN',5),
    (6,'ANANJAY', 1),
    (7, 'AMAN', 2),
    (8, 'ADITI', 3);

SELECT * FROM EMPLOYEE;

INSERT INTO PROJECT VALUES
	(1, 'ML'),
    (2, 'DATABASE'),
    (3, 'CLOUD'),
    (4, 'BLOCKCHAIN'),
    (5, 'AR/VR');
    
SELECT * FROM PROJECT;


INSERT INTO assigned_to VALUES
	(1,1),
    (1,2),
    (2,3),
    (2,4),
    (3,5),
    (4,1),
    (5,2);
    
SELECT * FROM ASSIGNED_TO;


SELECT * FROM EMPLOYEE WHERE SSN IN(
SELECT SSN FROM ASSIGNED_TO WHERE PROJECTNO IN(
SELECT PROJECTNO FROM PROJECT WHERE PROJECTAREA='DATABASE')
);


SELECT DEPTNO, COUNT(SSN) AS COUNT FROM EMPLOYEE GROUP BY DEPTNO;

SELECT NAME FROM EMPLOYEE WHERE SSN NOT IN(
	SELECT SSN FROM ASSIGNED_TO GROUP BY SSN HAVING COUNT(SSN)>=2);
    
SELECT NAME FROM EMPLOYEE WHERE SSN NOT IN(
	SELECT SSN FROM ASSIGNED_TO GROUP BY SSN HAVING COUNT(ProjectNo)>=2);
    

-- SET SQL_SAFE_UPDATES=0;

UPDATE ASSIGNED_TO 
SET PROJECTNO=4
WHERE SSN=3;

SELECT * FROM ASSIGNED_TO;



select ssn
from assigned_to
group by ssn
having count(ProjectNo) >= (
	(select count(*) from assigned_to)
    /
    (select count(*) from assigned_to where ssn in (1,2))
);
