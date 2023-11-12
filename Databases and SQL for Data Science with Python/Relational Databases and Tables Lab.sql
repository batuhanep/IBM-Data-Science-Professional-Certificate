--CREATE, ALTER, TRUNCATE, DROP
--In this lab, you will use MySQL.

--You need to create two tables, PETSALE and PET.
CREATE TABLE PETSALE(
    ID INTEGER NOT NULL,
    PET CHAR(20),
    SALEPRICE DECIMAL(6,2),
    PROFIT DECIMAL(6,2),
    SALEDATE DATE
    );
    
CREATE TABLE PET (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER
    );
--Insert new values to the table
INSERT INTO PETSALE VALUES
        (1,'Cat',450.09,100.47,'2018-05-29'),
        (2,'Dog',666.66,150.76,'2018-06-01'),
        (3,'Parrot',50.00,8.9,'2018-06-04'),
        (4,'Hamster',60.60,12,'2018-06-11'),
        (5,'Goldfish',48.48,3.5,'2018-06-14');
        
INSERT INTO PET VALUES
        (1,'Cat',3),
        (2,'Dog',4),
        (3,'Hamster',2);
SELECT * FROM PETSALE;
SELECT * FROM PET;

--1. Adding a column
--Add a new column named QUANTITY to the PETSALE table and display the altered table.
ALTER TABLE PETSALE
ADD COLUMN QUANTITY INTEGER;

SELECT * FROM PETSALE;

--Now update the newly added QUANTITY column of the PETSALE table with some values and show all the table records. 
UPDATE PETSALE SET QUANTITY = 9 WHERE ID =1;
UPDATE PETSALE SET QUANTITY = 3 WHERE ID = 2;
UPDATE PETSALE SET QUANTITY = 2 WHERE ID = 3;
UPDATE PETSALE SET QUANTITY = 6 WHERE ID = 4;
UPDATE PETSALE SET QUANTITY = 24 WHERE ID = 5;

SELECT * FROM PETSALE;

--2. Deleting a column
--Delete the PROFIT column from the PETSALE table and show the altered table.
ALTER TABLE PETSALE
DROP COLUMN PROFIT;

SELECT * FROM PETSALE;

--3. Modify a column
--Change the data type to VARCHAR(20) type of the column PET of the table PETSALE and show the altered table.
ALTER TABLE PETSALE
MODIFY PET VARCHAR(20);

SELECT * FROM PETSALE;

--4. Rename a Column
--Rename the column PET to ANIMAL of the PETSALE table and show the altered table.
ALTER TABLE PETSALE
CHANGE PET ANIMAL VARCHAR(20);

SELECT * FROM PETSALE;

--TRUNCATE statement
-- remove all rows from an existing table without deleting it
TRUNCATE TABLE PET;

SELECT * FROM PET;

--DROP statement
--Let's delete the PET table and verify if the table still exists or not (the SELECT statement should give an error if a table doesn't exist). 
DROP TABLE PET;

SELECT * FROM PET;


