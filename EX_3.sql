USE DBMS_LAB;
SHOW TABLES;

CREATE TABLE BOAT 
(
	BID INT PRIMARY KEY,
    NAME VARCHAR(5) NOT NULL,
    COLOR VARCHAR(10) NOT NULL
);

CREATE TABLE SAILOR 
(
	SID INT PRIMARY KEY,
    NAME VARCHAR(5) NOT NULL,
    AGE INT NOT NULL
);

CREATE TABLE RESERVES 
(
	BID INT,
    SID INT,
    DAY VARCHAR(10) NOT NULL,
    PRIMARY KEY (BID,SID,DAY),
    FOREIGN KEY (BID) REFERENCES BOAT(BID) ON DELETE CASCADE,
    FOREIGN KEY (SID) REFERENCES SAILOR(SID) ON DELETE CASCADE
    );


INSERT INTO BOAT VALUES(1,'B1','RED');
INSERT INTO BOAT VALUES(2,'B2','GREEN');
INSERT INTO BOAT VALUES(3,'B3','BLUE');
INSERT INTO BOAT VALUES(4,'B4','BLACK');
INSERT INTO BOAT VALUES(5,'B5','WHITE');


INSERT INTO SAILOR VALUE (101,'S1',20);
INSERT INTO SAILOR VALUE (102,'S2',22);
INSERT INTO SAILOR VALUE (103,'S3',24);
INSERT INTO SAILOR VALUE (104,'S4',26);
INSERT INTO SAILOR VALUE (105,'S5',28);

UPDATE SAILOR SET NAME='B5' WHERE SID=105;

INSERT INTO RESERVES VALUE (1,101,'MONDAY');
INSERT INTO RESERVES VALUE (2,102,'TUESDAY');
INSERT INTO RESERVES VALUE (3,103,'WEDNESDAY');
INSERT INTO RESERVES VALUE (4,104,'THRUSDAY');
INSERT INTO RESERVES VALUE (5,105,'FRIDAY');
INSERT INTO RESERVES VALUE (1,102,'WEDNESDAY');
INSERT INTO RESERVES VALUE (1,103,'THRUSDAY');
INSERT INTO RESERVES VALUE (1,104,'FRIDAY');
INSERT INTO RESERVES VALUE (1,105,'TUESDAY');




SELECT * FROM BOAT;
SELECT * FROM SAILOR;
SELECT * FROM RESERVES;



SELECT * FROM BOAT WHERE BID IN (SELECT BID FROM RESERVES WHERE SID IN (SELECT SID FROM SAILOR WHERE NAME='S2'));


-- SELECT BID 
-- FROM BOAT B 
-- WHERE NOT EXISTS 
-- ( 
-- 	SELECT SID 
--     FROM SAILOR AS S
--     LEFT JOIN 
--     ( SELECT SID 
-- 		FROM RESERVES 
--         WHERE B.BID=RESERVES.BID
-- 	) AS T2
--     WHERE S.SID=T2.SID
-- );


SELECT S.SID,S.NAME,COUNT(R.BID) AS NO_OF_BOATS FROM SAILOR S, RESERVES R WHERE S.SID=R.SID GROUP BY (S.SID);


SELECT B.NAME FROM SAILOR S, BOAT B WHERE S.NAME=B.NAME;


SELECT B.BID,S.SID,B.NAME,S.NAME
FROM BOAT B, SAILOR S, RESERVES R
WHERE B.BID=R.BID
AND B.NAME=S.NAME;