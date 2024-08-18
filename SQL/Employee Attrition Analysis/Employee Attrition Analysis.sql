-- Notes on Variable Definitions:

-- Attrition: 1 = YES, 0 = NO
-- YES: Employee no longer works for the company (whether it be due to retirement, relocation, involuntary termination, etc.).
-- NO: Active employee of the company.

-- DistanceFromHome is in kilometers

-- Education:
-- 1: "Below College" (Secondary School/Trade School/No College Education)
-- 2: "College" (Currently enrolled in a post-secondary institution)
-- 3: "Bachelor" (Earned Bachelor's degree)
-- 4: "Master" (Earned Master's degree)
-- 5: "Doctor" (Earned Doctorate)
-- 
-- EnvironmentSatisfaction:
-- 1: "Low"
-- 2: "Medium"
-- 3: "High"
-- 4: "Very High"

-- JobInvolvement
-- 1: "Low"
-- 2: "Medium"
-- 3: "High"
-- 4: "Very High"

-- JobSatisfaction
-- 1: "Low"
-- 2: "Medium"
-- 3: "High"
-- 4: "Very High"

-- PerformanceRating
-- 1: "Low"
-- 2: "Medium"
-- 3: "High"
-- 4: "Very High"

-- RelationshipSatisfaction
-- 1: "Low"
-- 2: "Medium"
-- 3: "High"
-- 4: "Very High"

-- WorkLifeBalance
-- 1: "Poor"
-- 2: "Fair"
-- 3: "Good"
-- 4: "Great"


SELECT *
FROM Attrition_Table;


-- Tasks

-- Calculate overall attrition rate

SELECT COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table;


-- Calculate attrition by department
SELECT Department,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY Department
ORDER BY AttritionRate DESC;

-- Attrition by job role
SELECT JobRole,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobRole
ORDER BY AttritionRate DESC;

-- Attrition by salary

-- Creating new column CompanyAverage 
	-- CompanyAverage = "Below Average", if employee earns below company average
	-- CompanyAverage = "Above Average", if employee earns above company average
	-- CompanyAverage = "Average", if employee earns exactly company average

ALTER TABLE Attrition_Table
ADD CompanyAverage varchar(50);

UPDATE Attrition_Table
SET CompanyAverage = CASE WHEN Salary > (SELECT AVG(Salary) FROM Attrition_Table) THEN 'Above Average'
WHEN Salary < (SELECT AVG(Salary) FROM Attrition_Table) THEN 'Below Average'
ELSE 'Average'
END;

-- Now look at the attrition rate by salary

SELECT CompanyAverage,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY CompanyAverage
ORDER BY AttritionRate DESC;

-- Correlation between attrition with age

-- Creating new column AgeGroup
	-- AgeGroup = "Young Adult", if 18 <= Age < 30
	-- AgeGroup = "Adult", if 30 <= Age < 45
	-- AgeGroup = "Senior", if Age >= 45

ALTER TABLE Attrition_Table
ADD AgeGroup varchar(50);

UPDATE Attrition_Table
SET AgeGroup = CASE WHEN Age BETWEEN 18 AND 30 THEN 'Young Adult'
WHEN Age BETWEEN 31 AND 45 THEN 'Adult'
ELSE 'Senior'
END;

-- Now look at the attrition rate by age group

SELECT AgeGroup,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY AgeGroup
ORDER BY AttritionRate DESC;


SELECT *
FROM Attrition_Table;

-- Correlation between attrition with work-life balance
SELECT WorkLifeBalance,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY WorkLifeBalance
ORDER BY AttritionRate DESC;


-- Correlation between attrition with job satisfaction
SELECT JobSatisfaction,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobSatisfaction
ORDER BY AttritionRate DESC;

-- Attrition by Job Role and Overtime
SELECT JobRole, OverTime,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobRole, OverTime
ORDER BY AttritionRate DESC;


-- Attrition by Promotion
SELECT YearsSinceLastPromotion,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY YearsSinceLastPromotion
ORDER BY AttritionRate DESC;