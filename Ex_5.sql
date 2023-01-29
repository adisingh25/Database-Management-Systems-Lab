USE DBMS_LAB;
SHOW TABLES;

CREATE TABLE BOOK
(
	ISBN INT PRIMARY KEY,
    TITLE varchar(10) not null,
	Author varchar(10) not null,
	Publisher varchar(10) not null
);

INSERT INTO BOOK VALUES(121, 'DATABASE', 'A1', 'P1');
INSERT INTO BOOK VALUES(122, 'CLOUD', 'A2', 'P2');
INSERT INTO BOOK VALUES(123, 'BLOCKCHAIN', 'A3', 'P3');
INSERT INTO BOOK VALUES(124, 'NETWORKS', 'A4', 'P4');
INSERT INTO BOOK VALUES(125, 'DAA', 'A5', 'P5');

SELECT * FROM BOOK;


CREATE TABLE STUDENT
(
	USN INT PRIMARY KEY,
    NAME varchar(10) not null,
	SEX varchar(1) not null
);

INSERT INTO STUDENT VALUES(001, 'JOHN', 'M');
INSERT INTO STUDENT VALUES(002, 'MAX', 'M');
INSERT INTO STUDENT VALUES(003, 'JENI', 'F');
INSERT INTO STUDENT VALUES(004, 'ANNE', 'F');
INSERT INTO STUDENT VALUES(005, 'WILL', 'M');


SELECT * FROM STUDENT;

CREATE TABLE BORROW(
    ISBN INT,
    USN INT,
    DATE varchar(10),
    primary key(ISBN,USN),
    foreign key(ISBN) references BOOK(ISBN) on delete cascade,
    foreign key(USN) references STUDENT(USN) on delete cascade
);


INSERT INTO BORROW VALUES(123, 1, '19-11-22');
INSERT INTO BORROW VALUES(123, 2, '20-11-22');
INSERT INTO BORROW VALUES(124, 1, '19-11-22');
INSERT INTO BORROW VALUES(121, 3, '1-11-22');
INSERT INTO BORROW VALUES(121, 4, '1-11-22');
INSERT INTO BORROW VALUES(122, 5, '2-11-22');
INSERT INTO BORROW VALUES(121, 2, '10-11-22');
INSERT INTO BORROW VALUES(121, 2, '25-11-22');


SELECT * FROM BORROW;

SELECT * 
FROM STUDENT
WHERE USN IN (
	SELECT USN 
    FROM BORROW 
    WHERE ISBN IN(123,124)
);


SELECT USN,COUNT(USN) AS NO_OF_BOOKS FROM BORROW GROUP BY USN;    -- DISPLAYS THE COUNT OF THE NUMBER OF BOOKS ISSUED BY EACH STUDENT


SELECT NAME
FROM STUDENT AS S
WHERE SEX='F'
AND USN IN ( 
	SELECT USN FROM BORROW 
	WHERE ISBN = 
	(SELECT ISBN FROM BOOK 
	WHERE TITLE='DATABASE' ) 
);

SELECT S.USN,S.NAME,COUNT(B.USN) AS NO_OF_BOOKS
FROM STUDENT AS S
INNER JOIN BORROW AS B
ON S.USN=B.USN
GROUP BY (B.USN);

SELECT S.USN,S.NAME,COUNT(B.ISBN) AS NO_OF_BOOKS
FROM STUDENT AS S, BORROW AS B
WHERE S.USN=B.USN
GROUP BY (B.USN);


SELECT TITLE 
FROM BOOK AS B
WHERE TITLE LIKE 'DA%'
AND ISBN NOT IN (
	SELECT ISBN FROM BORROW
    );
    
    



