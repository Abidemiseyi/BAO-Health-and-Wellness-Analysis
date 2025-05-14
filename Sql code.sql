SELECT *
FROM stress

--Select * INTO Stress_tbl
--From Stress;

EXEC sp_rename 'Stress_tbl.id','ID','COLUMN';
EXEC sp_rename 'Stress_tbl.first_name','First Name','COLUMN';
EXEC sp_rename 'Stress_tbl.last_name','Last Name','COLUMN';
EXEC sp_rename 'Stress_tbl.gender','Gender','COLUMN';
EXEC sp_rename 'Stress_tbl.dob','Date of Birth','COLUMN';
EXEC sp_rename 'Stress_tbl.test_date','Date','COLUMN';
EXEC sp_rename 'Stress_tbl.test_time','Time','COLUMN';
EXEC sp_rename 'Stress_tbl.stress_level_score','Self Reported Stress Score','COLUMN';
EXEC sp_rename 'Stress_tbl.stress_source','Stress Source','COLUMN';
EXEC sp_rename 'Stress_tbl.physical_symptoms','Physical Symptoms','COLUMN';
EXEC sp_rename 'Stress_tbl.emotional_symptoms','Emotional Symptoms','COLUMN';
EXEC sp_rename 'Stress_tbl.coping_mechanism','Coping Mechanism','COLUMN';
EXEC sp_rename 'Stress_tbl.stress_duration','Duration of Stress','COLUMN';
EXEC sp_rename 'Stress_tbl.severity','Severity','COLUMN';
EXEC sp_rename 'Stress_tbl.sleep_quality','Sleep Quality','COLUMN';
EXEC sp_rename 'Stress_tbl.mood','Mood','COLUMN';
EXEC sp_rename 'Stress_tbl.heart_rate','Heart Rate','COLUMN';
EXEC sp_rename 'Stress_tbl.cortisol_level','Cortisol Level','COLUMN';

--1. Remove Duplicates
Select *, 
ROW_NUMBER() OVER(
PARTITION BY ID, [FIRST NAME],[LAST NAME],GENDER,[Date of Birth],[DATE]  ORDER BY ID)AS ROW_NUM
from Stress_tbl;

WITH Duplicate_CTE AS
(Select *, 
ROW_NUMBER() OVER(
PARTITION BY ID, [FIRST NAME],[LAST NAME],GENDER,[Date Of Birth],[DATE],[TIME],[STRESS SOURCE], [PHYSICAL SYMPTOMS],
[EMOTIONAL SYMPTOMS],[COPING MECHANISM],[DURATION OF STRESS],SEVERITY,[SLEEP QUALITY],
MOOD,[HEART RATE],[CORTISOL LEVEL],[SELF REPORTED STRESS SCORE] ORDER BY ID)AS ROW_NUM
from Stress_tbl
)
DELETE 
FROM Duplicate_CTE
WHERE ROW_NUM>1;

--Select *
--from Duplicate_CTE
--where ROW_NUM>1

WITH DUPLICATE_ID AS(
Select *, 
ROW_NUMBER() OVER(
PARTITION BY ID ORDER BY 
CASE 
                    WHEN [Date of birth] IS NOT NULL AND [date] IS NOT NULL AND [cortisol level] IS NOT NULL AND [stress source] IS NOT NULL AND severity 
					IS NOT NULL THEN 1
                    ELSE 2
                END)AS ID_NUM
from Stress_tbl)
DELETE 
FROM DUPLICATE_ID
WHERE ID_NUM>1;

--2. Standardization of data
--a. Remove extra spaces
Select TRIM([First Name]),TRIM([Last name])
From Stress_tbl

Update Stress_tbl
Set [First Name]= TRIM([First Name]),
[Last Name]=TRIM([Last Name])

--b. Update Physical symptoms column correcting the misspelt words
Select Distinct [Physical Symptoms]
From Stress_tbl

Select *
From Stress_tbl
Where [Physical Symptoms] like 'Stomach%'

Update Stress_tbl
Set [Physical Symptoms]='Stomach Ache'
where [Physical Symptoms] like 'Stomach%'

Select *
From Stress_tbl
Where [Physical Symptoms] like 'Arthritis%'

Update Stress_tbl
Set [Physical Symptoms]='Arthritis'
where [Physical Symptoms] like 'Arthritis%'

--c. Update the stress_level_score that are null with the average stress level score
Select *
From Stress_tbl
Where [Self Reported Stress Score] is null

Select Avg([Self Reported Stress Score]) as Avg_stress
From Stress_tbl
where [Self Reported Stress Score] is not null

Update Stress_tbl
Set [Self Reported Stress Score]=(
Select Avg([Self Reported Stress Score]) as Avg_stress
From Stress_tbl
where [Self Reported Stress Score] is not null)
Where [Self Reported Stress Score] is null;

--d. Update the test_time column
SELECT [Time], 
    CONVERT(Time(0), [Time]) AS StandardizedTime
FROM Stress_tbl;

Update Stress_tbl
Set [Time]= CONVERT(Time(0), [Time])
where [time]=[time];

--e. Update Gender
Update Stress_tbl
Set Gender= 'Male'
where Gender ='M'

Update Stress_tbl
Set Gender = 'Female'
where Gender = 'f'
--3. Categorize data
--a. Categorize the stress duration into chronic, acute and episodic
Select *,
CASE
  WHEN [Duration of Stress] <= 7 THEN 'Acute Stress'
  WHEN [Duration of Stress] <= 90 THEN 'Episodic Acute Stress'
  ELSE 'Chronic Stress'
END AS [Stress Category]
From Stress_tbl
--b. Categorize the heart_rate level
SELECT *,
       CASE 
           WHEN [Heart Rate] < 60 THEN 'Below Normal'
           WHEN [Heart Rate] BETWEEN 60 AND 100 THEN 'Normal'
           ELSE 'Above Normal'
       END AS [Heart Rate Category]
FROM Stress_tbl;

--c. Categorize the Severity based on avg heart_rate
SELECT 
    Severity,
    AVG([Heart Rate]) AS [Avg Heart Rate]
FROM Stress_tbl
GROUP BY Severity;

--d. Calculate Age
SELECT 
    ID,
    [First Name],
    [Last Name],
    [Date of Birth],
    DATEDIFF(YEAR, [Date of Birth], GETDATE()) AS age
FROM Stress_tbl;

--e. Categorize age into age group
SELECT 
    ID,
    [First Name],
    [Last Name],
    [Date of Birth],
    DATEDIFF(YEAR, [Date of Birth], GETDATE()) AS Age,
    CASE 
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 18 AND 40 THEN '18-40'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
        ELSE '71-80'
    END AS [Age group]
FROM Stress_tbl;
--f. Categorize test_time into morning, afternoon and evening
SELECT 
    ID,
    [First Name],
    [Last Name],
    [Date],
    [Time],
    CASE
        WHEN DATEPART(HOUR, [Time]) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN DATEPART(HOUR, [Time]) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END AS [Time of day]
FROM Stress_tbl;

--Create view to populate all the new data
Create View DataSummary as
Select
ID, [First Name], [Last Name], Gender,
 DATEDIFF(YEAR, [Date of Birth], GETDATE()) AS Age,
    CASE 
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 18 AND 40 THEN '18-40'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        WHEN DATEDIFF(YEAR, [Date of Birth], GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
        ELSE '71-80'
    END AS [Age group],
[Date], 
CASE
        WHEN DATEPART(HOUR, [Time]) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN DATEPART(HOUR, [Time]) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END AS [Time of day],
[Stress Source],
[Physical Symptoms],[Emotional Symptoms],[Coping Mechanism],
[Duration of Stress],
CASE
  WHEN [Duration of Stress] <= 7 THEN 'Acute Stress'
  WHEN [Duration of Stress] <= 90 THEN 'Episodic Acute Stress'
  ELSE 'Chronic Stress'
END AS [Stress Category],
Severity, [Sleep Quality], Mood, [Heart Rate],
CASE 
	WHEN [Heart Rate] < 60 THEN 'Below Normal'
	WHEN [Heart Rate] BETWEEN 60 AND 100 THEN 'Normal'
	ELSE 'Above Normal'
END AS [Heart Rate Category],
[Cortisol Level],[Self Reported Stress Score]
From Stress_tbl

Select *
from DataSummary

--4.Analysis
--a. Employee by severity
Select Severity,count(*) as Employee
From Stress_tbl
Group by Severity
Order by Employee

--b. Employee by coping mechanism
Select [Coping Mechanism],count(*) as Employee
From Stress_tbl
Group by [Coping Mechanism]
Order by Employee;

--c. Employee by stress category
With Stress_duration_CTE as
(Select [Duration of Stress],
CASE
  WHEN [Duration of Stress] <= 7 THEN 'Acute Stress'
  WHEN [Duration of Stress] <= 90 THEN 'Episodic Acute Stress'
  ELSE 'Chronic Stress'
END AS [Stress category]
From Stress_tbl)

Select [Stress category], count(*) as Employee
From Stress_duration_CTE
Group by [Stress category]
order by Employee desc

--d.
SELECT [Physical Symptoms],[Emotional Symptoms],avg([Cortisol Level])as CortisolLevel,Avg([Heart Rate]) as AvgHeartRate
FROM Stress_tbl
GROUP BY [Physical Symptoms],[Emotional Symptoms]
ORDER BY [Physical Symptoms],[Emotional Symptoms],CortisolLevel DESC, AvgHeartRate Desc


SELECT [Emotional Symptoms],AvG([Heart Rate]) as AvgHeartRate,gender,count(*) as employee
FROM Stress_tbl
GROUP BY [Emotional Symptoms],gender
ORDER BY AvgHeartRate Desc,employee desc

SELECT [Physical Symptoms],Avg([Heart Rate]) as AvgHeartRate,gender,count(*) as employee
FROM Stress_tbl
GROUP BY [Physical Symptoms],gender
ORDER BY AvgHeartRate Desc,employee desc


Select * from Stress_tbl