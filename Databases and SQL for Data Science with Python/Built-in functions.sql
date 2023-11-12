--Aggregation Functions

--Write a query that calculates the total cost of all animal rescues in the PETRESCUE table.
SELECT SUM(COST) AS SUM_OF_COST
FROM PETRESCUE

--Write a query that displays the maximum quantity of animals rescued (of any kind).
SELECT MAX(QUANTITY)
FROM PETRESCUE

--Write a query that displays the average cost of animals rescued.
SELECT AVG(COST)
FROM PETRESCUE

--Write a query that displays the rounded integral cost of each rescue.
SELECT ROUND(COST)
FROM PETRESCUE

--In case the question was to round the value to 2 decimal places, the query would change to:
SELECT ROUND(COST, 2)
FROM PETRESCUE;

--use the function LENGTH(COLUMN_NAME)
SELECT LENGTH(ANIMAL)
FROM PETRESCUE;

-- upper case letters
SELECT UCASE(ANIMAL)
FROM PETRESCUE;

--lower
SELECT LCASE(ANIMAL)
FROM PETRESCUE;

--Date Functions

--The output of this query will be only the DAY part of the date in the column
SELECT DAY(RESCUEDATE)
FROM PETRESCUE;

--Month
SELECT MONTH(RESCUEDATE)
FROM PETRESCUE;

--Year
SELECT YEAR(RESCUEDATE)
FROM PETRESCUE;

-- Here, the quantity in Number and in Date_element will combine to form the interval to be added to the date in the column. 
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY)
FROM PETRESCUE;

--If the question was to add 2 months to the date, the query would change to:
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH)
FROM PETRESCUE;

--Similarly, we can retrieve a date before the one given in the column by a given number using the function DATE_SUB. By modifying the same example, the following query would provide the date 3 days before the rescue.
SELECT DATE_SUB(RESCUEDATE, INTERVAL 3 DAY)
FROM PETRESCUE;

--Write a query that displays the length of time the animals have been rescued, for example, the difference between the current date and the rescue date.
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE)
FROM PETRESCUE;
--CURRENT_DATE is also an inbuilt function that returns the present date as known to the server.

--To present the output in a YYYY-MM-DD format, another function FROM_DAYS(number_of_days)can be used. This function takes a number of days and returns the required formatted output. 
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE))
FROM PETRESCUE;

--Practice Problems

--Write a query that displays the average cost of rescuing a single dog. Note that the cost per dog would not be the same in different instances.

SELECT AVG(COST/QUANTITY) 
FROM PETRESCUE
WHERE ANIMAL = 'Dog'

--Write a query that displays the animal name in each rescue in uppercase without duplications.

SELECT DISTINCT UCASE(ANIMAL)
FROM PETRESCUE;

--Write a query that displays all the columns from the PETRESCUE table where the animal(s) rescued are cats. Use cat in lowercase in the query.

SELECT * 
FROM PETRESCUE 
WHERE LCASE(ANIMAL)="cat";

--Write a query that displays the number of rescues in the 5th month.

SELECT SUM(QUANTITY)
FROM PETRESCUE 
WHERE MONTH(RESCUEDATE) = 05;

--The rescue shelter is supposed to find good homes for all animals within 1 year of their rescue. Write a query that displays the ID and the target date.
SELECT ID, DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR)
FROM PETRESCUE;