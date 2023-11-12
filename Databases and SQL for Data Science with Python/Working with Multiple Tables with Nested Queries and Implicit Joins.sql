--Working with Multiple Tables with nested queries and implicit join

--Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_IDENT FROM JOBS);

--Retrieve JOB information for employees earning over $70,000.
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS
WHERE JOB_IDENT IN(SELECT JOB_ID FROM EMPLOYEES WHERE SALARY > 70000 );

--Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
-- we will use Implicit Join to retrieve the required information. 
SELECT *
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

--Redo the previous query using shorter aliases for table names.
SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

--In the previous query, retrieve only the Employee ID, Name, and Job Title.
SELECT EMP_ID, F_NAME, L_NAME, JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT

--Redo the previous query, but specify the fully qualified column names with aliases in the SELECT clause.
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;


--Practice problems

--Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.

-- Using sub-queries
SELECT *
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_IDENT
                 FROM JOBS
                 WHERE JOB_TITLE = 'Jr. Designer')

--Using Implicit Joins
SELECT *
FROM EMPLOYEES E , JOBS J
WHERE E.JOB_ID = J.JOB_IDENT AND JOB_TITLE = 'Jr. Designer';

--Retrieve JOB information and a list of employees whose birth year is after 1976.

--Using sub-queries
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS
WHERE JOB_IDENT IN(SELECT JOB_ID
                   FROM EMPLOYEES
                   WHERE YEAR(B_DATE)>1976);

--Using implicit join
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS J, EMPLOYEES E
WHERE E.JOB_ID = J.JOB_IDENT AND YEAR(E.B_DATE)>1976;


 