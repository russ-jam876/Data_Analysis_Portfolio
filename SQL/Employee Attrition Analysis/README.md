# Employee Attrition Analysis

## Overview
This project aims to analyze employee attrition within a company based on various factors such as job role, salary, work-life balance, job satisfaction, and more. The goal is to uncover insights that can help improve employee retention strategies.

## Dataset
The dataset used in this analysis is the `Attrition_Table`, which contains information about employees, including their age, salary, education level, job satisfaction, work-life balance, and attrition status.

### Columns:
- **EmployeeNumber**: Unique identifier for each employee
- **Attrition**: 1 = YES (Employee left), 0 = NO (Employee is still with the company)
- **Age**: Age of the employee
- **Salary**: Salary of the employee
- **JobRole**: Role of the employee (e.g., Manager, Sales Executive, etc.)
- **Department**: Department in which the employee works
- **WorkLifeBalance**: Rating of work-life balance (1 = Poor, 2 = Fair, 3 = Good, 4 = Great)
- **JobSatisfaction**: Rating of job satisfaction (1 = Low, 2 = Medium, 3 = High, 4 = Very High)
- **Other relevant attributes**: Includes EnvironmentSatisfaction, PerformanceRating, RelationshipSatisfaction, etc.

## Analysis Performed

1. **Overall Attrition Rate**:
   - Calculated the total attrition rate for the company.
   
2. **Attrition by Department**:
   - Analyzed attrition rates by department to identify departments with higher attrition.

3. **Attrition by Job Role**:
   - Analyzed attrition rates by job role to understand the impact of different roles on employee turnover.

4. **Attrition by Salary**:
   - Classified employees into salary categories (`Above Average`, `Average`, `Below Average`) based on their salary relative to the company average, and calculated the attrition rate for each category.

5. **Attrition by Age Group**:
   - Created age groups (`Young Adult`, `Adult`, `Senior`) and analyzed attrition rates by these groups.

6. **Attrition by Work-Life Balance**:
   - Analyzed the correlation between work-life balance and attrition, highlighting the importance of work-life balance on employee retention.

7. **Attrition by Job Satisfaction**:
   - Analyzed the correlation between job satisfaction and attrition, investigating how different levels of satisfaction affect employee turnover.

8. **Attrition by Job Role and Overtime**:
   - Investigated how overtime influences attrition rates across different job roles.

9. **Attrition by Promotion**:
   - Analyzed the impact of the number of years since the last promotion on employee attrition.

## Key Insights
- **Attrition by Department**: Certain departments showed significantly higher attrition rates compared to others, indicating potential areas for improvement in employee engagement and retention.
- **Attrition by Salary**: Employees earning below the company’s average salary had higher attrition rates, which suggests that competitive compensation could be key to retaining talent.
- **Attrition by Age Group**: Younger employees had a higher attrition rate compared to older employees, which could be due to various career development and job satisfaction factors.
- **Work-Life Balance**: Employees with better work-life balance had lower attrition rates, emphasizing the importance of maintaining a healthy balance between work and personal life.
