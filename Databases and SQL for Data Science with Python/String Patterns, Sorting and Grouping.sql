--String Patterns, Sorting and Grouping

--String Patterns
--Say you need to retrieve the first names F_NAME and last names L_NAME of all employees who live in Elgin, IL.
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%';

--Now assume that you want to identify the employees who were born during the 70s.
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%'

--Consider a more specific example. Let us retrieve all employee records in department 5 where salary is between 60000 and 70000.
SELECT *
FROM EMPLOYEES
WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID=5;

--Sorting
--First, assume that you have to retrieve a list of employees ordered by department ID.
SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;

--Now, get the output of the same query in descending order of department ID, and within each deaprtment, the records should be ordered in descending alphabetical order by last name.
SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

--Grouping
--A good example of grouping would be if For each department ID, we wish to retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

--Now, for each department, retrieve the number of employees in the department and the average employee salary in the department. 
SELECT DEP_ID, COUNT(*), AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID;

--You can refine your outut by using appropriate labels for the columns of data retrieved
SELECT DEP_ID, COUNT(*) AS "NUM OF EMPLOYEES", AVG(SALARY) AS "AVG SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID;

--You can also combine the usage of GROUP BY and ORDER BY statements to sort the output of each group in accordance with a specific parameter. 
--It is important to note that in such a case, ORDER BY clause muct be used after the GROUP BY clause. 
SELECT DEP_ID, COUNT(*) AS "NUM OF EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

--In case you need to filter a grouped response, you have to use the HAVING clause.
-- if we wish to limit the result to departments with fewer than 4 employees,
--We will ahve to use HAVING after the GROUP BY, and use the count() function in the HAVING clause instead of the column label.
SELECT DEP_ID, COUNT(*) AS "NUM OF EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING count(*) < 4
ORDER BY AVG_SALARY;

--Practice Questions

--Retrieve the list of all employees, first and last names, whose first names start with ‘S’.
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE F_NAME LIKE 'S%';

--Arrange all the records of the EMPLOYEES table in ascending order of the date of joining.
SELECT *
FROM EMPLOYEES
ORDER BY B_DATE;

--Group the records in terms of the department IDs and filter them of ones that have average salary more than or equal to 60000. Display the department ID and the average salary.
SELECT DEP_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;

--For the problem above, sort the results for each group in descending order of average salary.
SELECT DEP_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG(SALARY) DESC;