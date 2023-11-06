--SELECT Statements lAB
--Let us first explore the SanFranciscoFilmLocations database using the Datasette tool:
SELECT * FROM FilmLocations;
--Retrieve the names of all films with director names and writer names.
SELECT Title, Director, Writer
FROM FilmLocations;
--Retrieve the names of all films released in the 21st century and onwards (release years after 2001 including 2001), along with filming locations and release years.
SELECT Title, Director, Writer
FROM FilmLocations
WHERE ReleaseYear>=2001;
--Retrieve the fun facts and filming locations of all films.
SELECT Locations, FunFacts
FROM FilmLocations;
--Retrieve the names of all films released in the 20th century and before (release years before 2000 including 2000) that, along with filming locations and release years.
SELECT Title, ReleaseYear, Locations
FROM FilmLocations
WHERE ReleaseYear<=2000;
--Retrieve the names, production company names, filming locations, and release years of the films which are not written by James Cameron.
SELECT ProductionCompany, Title, Locations, ReleaseYear
FROM FilmLocations
WHERE Writer<>"James Cameron";


--COUNT, DISTINCT, LIMIT
--Retrieve the number of rows from the “FilmLocations” table.
SELECT COUNT(*)
FROM FilmLocations;
--Retrieve the number of locations of the films which are written by James Cameron.
SELECT COUNT(Locations)
FROM FilmLocations
WHERE Writer = "James Cameron";
--Retrieve the number of locations of the films which are directed by Woody Allen.
SELECT COUNT(Locations)
FROM FilmLocations
WHERE Director = "Woody Allen";
--Retrieve the number of films shot at Russian Hill.
SELECT COUNT(Title)
FROM FilmLocations
WHERE Locations = "Russian Hill";
--Retrieve the number of rows having a release year older than 1950 from the “FilmLocations” table.
SELECT COUNT(Title)
FROM FilmLocations
WHERE ReleaseYear < 1950;
--Retrieve the name of all films without any repeated titles.
SELECT DISTINCT Title
FROM FilmLocations;
--Retrieve the number of release years of the films distinctly, produced by Warner Bros. Pictures.
SELECT COUNT(DISTINCT ReleaseYear) 
FROM FilmLocations 
WHERE ProductionCompany="Warner Bros. Pictures";
--Retrieve the name of all unique films released in the 21st century and onwards, along with their release years.
SELECT DISTINCT Title, ReleaseYear
FROM FilmLocations 
WHERE ReleaseYear>=2001;
--Retrieve the names of all the directors and their distinct films shot at City Hall.
SELECT DISTINCT Title, Director
FROM FilmLocations 
WHERE Locations = "City Hall";
--Retrieve the number of distributors distinctly who distributed films acted by Clint Eastwood as 1st actor.
SELECT COUNT(DISTINCT Distributor)
FROM FilmLocations 
WHERE Actor1="Clint Eastwood";
--Retrieve the first 25 rows from the “FilmLocations” table.
SELECT *
FROM FilmLocations 
LIMIT 25;
--Retrieve the first 15 rows from the “FilmLocations” table starting from row 11.
SELECT *
FROM FilmLocations 
LIMIT 15 OFFSET 10;
--Retrieve the name of first 50 films distinctly.
SELECT DISTINCT Title
FROM FilmLocations 
LIMIT 50;
--Retrieve first 10 film names distinctly released in 2015.
SELECT DISTINCT Title
FROM FilmLocations
WHERE ReleaseYear = 2015
LIMIT 10;
--Retrieve the next 3 film names distinctly after first 5 films released in 2015.
SELECT DISTINCT Title
FROM FilmLocations
WHERE ReleaseYear = 2015
LIMIT 3 OFFSET 5;


--INSERT, UPDATE, and DELETE
--Insert a new instructor record with id 4 for Sandip Saha who lives in Edmonton, CA into the “Instructor” table.
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(4, 'Saha', 'Sandip', 'Edmonton', 'CA');

SELECT * 
FROM Instructor;
--Insert two new instructor records into the “Instructor” table. First record with id 5 for John Doe who lives in Sydney, AU. Second record with id 6 for Jane Doe who lives in Dhaka, BD.
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(5, 'Doe', 'John', 'Sydney', 'AU'), (6, 'Doe', 'Jane', 'Dhaka', 'BD');


SELECT * 
FROM Instructor;
--Insert a new instructor record with id 7 for Antonio Cangiano who lives in Vancouver, CA into the “Instructor” table
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(7, 'Cangiano', 'Antonio', 'Vancouver', 'CA');


SELECT * 
FROM Instructor;
--Insert two new instructor records into the “Instructor” table. First record with id 8 for Steve Ryan who lives in Barlby, GB. Second record with id 9 for Ramesh Sannareddy who lives in Hyderabad, IN.
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(8, 'Ryan', 'Steve', 'Barlby', 'GB'), (9, 'Sannareddy', 'Ramesh', 'Hyderabad', 'IN');

SELECT * 
FROM Instructor;
--Update the city for Sandip to Toronto.
UPDATE Instructor
SET city='Toronto'
WHERE firstname="Sandip";


SELECT * FROM Instructor;
--Update the city and country for Doe with id 5 to Dubai and AE respectively.
UPDATE Instructor
SET city='Dubai', country='AE'
WHERE ins_id=5;

--Remove the instructor record of Doe whose id is 6.
DELETE FROM instructor
WHERE ins_id = 6;

SELECT * 
FROM Instructor;
--Remove the instructor record of Hima.
DELETE FROM instructor
WHERE firstname = 'Hima';

SELECT * FROM Instructor;




