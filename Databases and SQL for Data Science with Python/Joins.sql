-- JOINS

-- Exercise Problems

--HR Database
--Select the names and job start dates of all employees who work for the department number 5.

SELECT E.F_NAME, E.L_NAME, JH.START_DATE
FROM EMPLOYEES as E
INNER JOIN JOB_HISTORY as JH
ON E.EMP_ID=JH.EMPL_ID
WHERE E.DEP_ID = '5';

--Select the names, job start dates, and job titles of all employees who work for the department number 5.

SELECT E.F_NAME,E.L_NAME, JH.START_DATE, J.JOB_TITLE 
FROM EMPLOYEES as E 
INNER JOIN JOB_HISTORY as JH on E.EMP_ID=JH.EMPL_ID 
INNER JOIN JOBS as J on E.JOB_ID=J.JOB_IDENT
where E.DEP_ID ='5';

--Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and select employee id, last name, department id and department name for all employees.

SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP;

--Re-write the previous query but limit the result set to include only the rows for employees born before 1980.

SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP
WHERE YEAR(E.B_DATE) < 1980;

--Re-write the previous query but have the result set include all the employees but department names for only the employees who were born before 1980.

select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
from EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D 
ON E.DEP_ID=D.DEPT_ID_DEP 
AND YEAR(E.B_DATE) < 1980;

--AND VE WHERE FARKI:
--Ýlk örneðin (WHERE YEAR(E.B_DATE) < 1980) WHERE koþulu, sorgunun sonucunu filtrelemek için kullanýlýr. Bu durumda, sorgu, E.B_DATE sütununda bulunan yýlýn 1980'den küçük olduðu durumlarý döndürecektir. Bu koþul, sorgunun sonucunu daha dar bir þekilde belirler.
--Ýkinci örnekte (AND YEAR(E.B_DATE) < 1980), AND ifadesi kullanýlarak iki koþul birleþtirilir. Bu durumda, sol tarafýndaki LEFT OUTER JOIN ile birleþtirilen tablolar arasýndaki iliþkiyi belirlemek için kullanýlan koþullarýn yaný sýra, E.B_DATE sütunundaki yýlýn da 1980'den küçük olmasý gerektiði belirtilir. AND ifadesi, bu iki koþulu birleþtirerek, her iki koþulu da saðlayan durumlarý döndürecektir.


--Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and select the First name, Last name and Department name of all employees.

SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP

UNION

SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E 
RIGHT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP

--Re-write the previous query but have the result set include all employee names but department id and department names only for male employees.

SELECT E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E 
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M'

UNION

SELECT E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E 
RIGHT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M';
