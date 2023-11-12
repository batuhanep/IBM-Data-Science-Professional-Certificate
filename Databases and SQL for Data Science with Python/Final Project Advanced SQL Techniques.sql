--Final Project: Advanced SQL Techniques

--Exercise 1: Using Joins
--1.Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.

SELECT CPS.NAME_OF_SCHOOL, CPS.AVERAGE_STUDENT_ATTENDANCE, CSE.COMMUNITY_AREA_NAME, CSE.HARDSHIP_INDEX 
FROM chicago_public_schools AS CPS 
LEFT OUTER JOIN chicago_socioeconomic_data AS CSE 
ON CPS.COMMUNITY_AREA_NUMBER= CSE.COMMUNITY_AREA_NUMBER 
WHERE CSE.HARDSHIP_INDEX = 98;

--2.Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.

SELECT cc.CASE_NUMBER, cc.PRIMARY_TYPE, csd.COMMUNITY_AREA_NAME
FROM chicago_crime cc
LEFT OUTER JOIN chicago_socioeconomic_data csd
ON cc.COMMUNITY_AREA_NUMBER = csd.COMMUNITY_AREA_NUMBER
WHERE cc.LOCATION_DESCRIPTION LIKE '%School%';

--	Exercise 2: Creating a View
--Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.

CREATE VIEW CHICAGO_VIEW(School_Name,Safety_Rating,Family_Rating,Environment_Rating,Instruction_Rating,Leaders_Rating,Teachers_Rating)
AS SELECT NAME_OF_SCHOOL,Safety_Icon, Family_Involvement_Icon, Environment_Icon,Instruction_Icon, Leaders_Icon, Teachers_Icon
FROM chicago_public_schools;

--Exercise 3: Creating a Stored Procedure

--Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer.
CREATE   PROCEDURE `UPDATE_LEADERS_SCOREE` (IN in_School_ID  int,IN in_Leader_Score  int)
BEGIN
 UPDATE CHICAGO_PUBLIC_SCHOOLS
 SET Leaders_Score = in_Leader_Score
 WHERE School_ID = in_School_ID ;
  IF in_Leader_Score >0 AND in_Leader_Score <20
  THEN UPDATE CHICAGO_PUBLIC_SCHOOLS
  SET Leaders_Icon ='Very Weak'
  WHERE School_ID = in_School_ID;
  ELSEIF in_Leader_Score < 40
  THEN UPDATE CHICAGO_PUBLIC_SCHOOLS
  SET Leaders_Icon ='Weak'
  WHERE School_ID = in_School_ID;
  ELSEIF in_Leader_Score < 60
  THEN UPDATE CHICAGO_PUBLIC_SCHOOLS
  SET Leaders_Icon ='Average'
  WHERE School_ID = in_School_ID;
  ELSEIF in_Leader_Score < 80
  THEN UPDATE CHICAGO_PUBLIC_SCHOOLS
  SET Leaders_Icon ='Strong'
  WHERE School_ID = in_School_ID;
  ELSEIF in_Leader_Score < 100
  THEN UPDATE CHICAGO_PUBLIC_SCHOOLS
  SET Leaders_Icon ='Very Strong'
  WHERE School_ID = in_School_ID;
  
  END IF;
END //


