# Employee Attrition Analysis Report

**Name**: Russell Jamieson

**Date**: August 17, 2024

Exploring the correlation between employee attrition and various factors such as age, salary, job satisfaction, etc.

## Background

Attrition is the departure of employees from an organization for any particular reason. Reasons may range from retirement or resignation, voluntary attrition, to termination or death, involuntary attrition. Employee attrition is an inevitable part of any business. However, when attrition crosses a particular threshold, it becomes a cause for concern. For example, attrition amongst employees of a particular minority group can hurt the diversity of an organization. Attrition amongst senior leaders can lead to a significant gap in organizational leadership.

## Objective
The main objective of this analysis is to identify key factors contributing to employee attrition.

## Dataset
- The dataset used in this analysis was provided by [Kaggle.com](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset/data)

- The dataset contains 1470 rows of data.

- The data contains 35 columns namely:
    - Age
    - Attrition
    - BusinessTravel
    - DailyRate
    - Department
    - DistanceFromHome
    - Education
    - EducationField
    - EmployeeCount
    - EmployeeNumber	
    - EnvironmentSatisfaction
    - Gender
    - HourlyRate
    - JobInvolvement
    - JobLevel
    - JobRole
    - JobSatisfaction
    - MaritalStatus
    - MonthlyIncome
    - MonthlyRate
    - NumCompaniesWorked
    - Over18
    - OverTime
    - PercentSalaryHike 
    - PerformanceRating
    - RelationshipSatisfaction
    - Standard Hours
    - StockOptionLevel
    - TotalWorkingYears
    - TrainingTimesLastYear                  
    - WorkLifeBalance
    - YearsAtCompany
    - YearsInCurrentRole
    - YearsSinceLastPromotion
    - YearsWithCurrManager

The following variables are considered factors for attrition: Education, EnvironmentSatisfaction, JobInvolvement, JobSatisfaction, PerformanceRating, RelationshipSatisfaction, WorkLifeBalance

Each factor has ranking system with the following definitions:

 **Education**:
 1: "Below College" (Secondary School/Trade School/No College Education)
 2: "College" (Currently enrolled in a post-secondary institution)
 3: "Bachelor" (Earned Bachelor's degree)
 4: "Master" (Earned Master's degree)
 5: "Doctor" (Earned Doctorate)
 
 **EnvironmentSatisfaction**:
 1: "Low"
 2: "Medium"
 3: "High"
 4: "Very High"

 **JobInvolvement**
 1: "Low"
 2: "Medium"
 3: "High"
 4: "Very High"

 **JobSatisfaction**
 1: "Low"
 2: "Medium"
 3: "High"
 4: "Very High"

 **PerformanceRating**
 1: "Low"
 2: "Medium"
 3: "High"
 4: "Very High"

 **RelationshipSatisfaction**
 1: "Low"
 2: "Medium"
 3: "High"
 4: "Very High"

 **WorkLifeBalance**
 1: "Poor"
 2: "Fair"
 3: "Good"
 4: "Great"


## Data Preparation

We processed and cleaned the data through Excel, as our CSV file was easily accessible through it and modifications were made simpler.

We began with checking to ensuring that there existed no duplicated rows, and removing any if such exists. We then deleted any unnecessary columns for our analysis. This included removing the columns: Over18, DailyRate, HourlyRate, MonthlyRate, StandardHours, StockOptionLevel, EmployeeCount.

We created a new column, Salary, which calculated the yearly salary of each employee by multiplying the MonthlyIncome of each employee by 12.

We standardized our data ensuring every column was of the right format before beginning the analyzing process.


## Exploratory Data Analysis

We performed our analysis in SQL using SQL Server. The updated CSV file was imported into our created database EmployeeAttrition using the Import/Export Wizard and the resulting table was named Attrition_Table.

### Overall Attrition

To begin our data analysis, we calculated the overall attrition rate of the organization. 

```sql
SELECT COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM AttritionTable;
```

**Output**: 

![Overall Attrition Rate](TotalAttritionRate.png)

The company's total attrition rate was 16.12%.

### Attrition per Department

Next, we calculated the attrition rate across all departments.

```sql
SELECT Department,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY Department
ORDER BY AttritionRate DESC;
```

**Output**:

![Attrition per Department](AttritionPerDepartment.png)

The results showed that the Sales department had the highest rate of attrition with 20.62%.

### Attrition per Job Role

We then analyzed which job roles were more prone to attrition.

```sql
SELECT JobRole,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobRole
ORDER BY AttritionRate DESC;
```

**Output**:

![AttrtitionPerJobRole](AttritionPerJobRole.png)

We can observe that the role of Sales Representatives had the highest attrition rate with a staggering **39.76%**. This is a significant **increase of 15.82%** from the next role, Laboratory Technician, with an attrition rate of **23.94%**. 
The lowest attrition rate recorded was **2.5%** from Research Directors with only 2 directors leaving the company.

### Attrition by Salary

We wished to see whether salary correlated to attrition rates. With our employees earning a wide range for their salary, we needed a way to categorize each employee's earnings. We created a column **CompanyAverage** and assigned to it values based on the employee's salary.

If an employee was making below the average company salary, we assigned the value *Below Average* in the **CompanyAverage** column. If they were making above the average company salary, the value *Above Average* was assigned to them. Otherwise, they were assigned the value *Average*. 

```sql
ALTER TABLE Attrition_Table
ADD CompanyAverage varchar(50);

UPDATE Attrition_Table
SET CompanyAverage = CASE WHEN Salary > (SELECT AVG(Salary) FROM Attrition_Table) THEN 'Above Average'
WHEN Salary < (SELECT AVG(Salary) FROM Attrition_Table) THEN 'Below Average'
ELSE 'Average'
END;
```

We found that all employees fell into either one of two categories: *Above Average* or *Below Average*. 

Calculating the attrition rate per salary using the following code:

```sql
SELECT CompanyAverage,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY CompanyAverage
ORDER BY AttritionRate DESC;
```
**Output**:

![AttritionPerSalary](AttritionPerSalary.png)

From the results, we can see that employees who earned less than company average were **8.39%** more likely to leave than employees who made more.

### Correlation between attrition with age

Another factor we considered with employee attrition rates is the age of the employees. With our diverse team ranging in age from 18 to 60, we decided to recategorize our employees into three groups: Young Adults for those ages 18 to 30, Adults for those ages 31 to 44, Seniors for 45 and up.

Similar to our Salary grouping, we created a column **AgeGroup** and assigned the values *Young Adult*, *Adult*, and *Senior* based on the employee's age.

```sql
ALTER TABLE Attrition_Table
ADD AgeGroup varchar(50);

UPDATE Attrition_Table
SET AgeGroup = CASE WHEN Age BETWEEN 18 AND 30 THEN 'Young Adult'
WHEN Age BETWEEN 31 AND 44 THEN 'Adult'
ELSE 'Senior'
END;
```

Calculating the attrition rate per salary using the following code:

```sql
SELECT AgeGroup,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY AgeGroup
ORDER BY AttritionRate DESC;
```

**Output**:

![AttritionPerAge](AttritionPerAge.png)

We see that Young Adults are twice as likely to leave the company than any other age group. This may call into question our inclusivity to younger employees in the workplace.

## Advanced Analysis

We will now take a deeper glance at employee attrition by observing combining multiple factors to see their total effect on attrition

### Job Role and Overtime

Firstly, we will observe the correlation between employee job roles and whether they work overtime, and see its impact on attrition.

```sql
SELECT JobRole, OverTime,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobRole, OverTime
ORDER BY AttritionRate DESC;
```

**Output**:

![JobRoleandOvertime](JobRoleandOvertime.png)

Although there is no apparent correlation, we would like to note that the 5 highest attrition rates are for job roles that worked overtime.

 *(OverTime = 1 represents an employee who works overtime and OverTime = 0 represents one who does not)*
 
  We may need to amend our policies on overtime and be more lenient on deadlines for tasks given to our employees.

### Job and Environment Satisfaction

Next, we will see how job and environment satisfaction correlates to overall attrition.

```sql
SELECT JobSatisfaction, EnvironmentSatisfaction,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY JobSatisfaction, EnvironmentSatisfaction
ORDER BY AttritionRate DESC;
```

**Output**:

![JobandEnvironmentSatisfaction](JobandEnvironmentSatisfaction.png)

The results show that the higher either the job and environment satisfaction was, the lower the attrition rate. The highest attrition rate corresponded to the lowest job and environment satisfaction and the lowest attrition rate corresponded to the highest job and environment satisfaction. This may be a cause for concern for our overall job environment.

### Attrition by Promotion

Finally, we look at the correlation between attrition and promotion.

```sql
SELECT YearsSinceLastPromotion,
COUNT(EmployeeNumber) AS TotalEmployees,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS TotalAttrition,
COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeNumber) AS AttritionRate
FROM Attrition_Table
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;
```

**Output**:

![AttritionbyPromotion](AttritionbyPromotion.png)

If we plot a line graph of Attrition Rate vs Years Since Last Promotion, it is evident that there is not correlation between the two.

![CorrelationGraph](AttritionbyPromotionGraph.png)

## Summary

In summary, we found that young adults, aged 18 - 30, were twice as likely to leave than those of any other age bracket. We also found that employees who work overtime were more likely to leave than ones who do not. Finally, employees who were disatisfied with their job and the environment showed increase signs of leaving the organization.

## Recommendations

- Implement better career growth opportunities/engagement programs in order to retain younger employees.

- Update office equipment, systems and spaces and foster a more positive and fun work environment to improve job and environment satisfaction.

- Implement flexible scheduling, analyze workload distribution and/or adjust staffing levels to decrease the amount overtime employees.


## References

1. [Gartner](https://www.gartner.com/en/human-resources/glossary/attrition#:~:text=Attrition%20is%20the%20departure%20of,%2C%20termination%2C%20death%20or%20retirement.)

2. [Spiceworks](https://www.spiceworks.com/hr/engagement-retention/articles/what-is-attrition-complete-guide/#:~:text=Employee%20attrition%20is%20defined%20as,is%20moving%20to%20another%20city.)
