--Sub-queries and Nested Selects

--Say you are asked to retrieve all employee records whose salary is lower than the average salary. You might use the following query to do this.
SELECT * 
FROM EMPLOYEES 
WHERE salary < AVG(salary);

--However, this query will generate an error stating, "Illegal use of group function." Here, the group function is AVG and cannot be used directly in the condition since it has not been retrieved from the data.
--herefore, the condition will use a sub-query to retrieve the average salary information to compare the existing salary. The modified query would become:

SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

--Now, consider executing a query that retrieves all employee records with EMP_ID, SALARY, and maximum salary as MAX_SALARY in every row.
--For this, the maximum salary must be queried and used as one of the columns.

SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM EMPLOYEES) AS MAX_SALARY
FROM EMPLOYEES;

--Now, consider that you wish to extract the first and last names of the oldest employee. Since the oldest employee will be the one with the smallest date of birth

SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE DOB = (SELECT MIN(DOB) FROM EMPLOYEES);

--You may also use sub-queries to create derived tables, which can then be used to query specific information. Say you want to know the average salary of the top 5 earners in the company.
--You will first have to extract a table of the top five salaries as a table. From that table, you can query the average value of the salary.

SELECT AVG(SALARY) 
FROM(SELECT SALARY
     FROM EMPLOYEES
     ORDER BY SALARY DESC
     LIMIT 5) AS SALARY_TABLE;
	 

--Practice Problems

--Write a query to find the average salary of the five least-earning employees.

SELECT *
FROM EMPLOYEES
WHERE YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,BirthDate))) > 
    (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,BirthDate)))) 
FROM EMPLOYEES);                                                          

--From the Job_History table, display the list of Employee IDs, years of service, and average years of service for all entries.
SELECT EMPL_ID, YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, STARTDATE))), 
    (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, STARTDATE)))) 
    FROM JOB_HISTORY)
FROM JOB_HISTORY;