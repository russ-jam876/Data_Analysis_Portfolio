# Overview

This project utilizes SQL to handle tasks such as identifying and removing duplicate records, handling null values, and standardizing data formats.

## Key Steps

### 1. Data Cleaning
**Removing Duplicates**
- Utilized a CTE to identify duplicate rows based on multiple columns.
- Dropped duplicate records to ensure data integrity.

**Handling Null Values**
- Identified null values in critical columns.
- Applied strategies to address these missing values, such as filling them with default values or dropping rows where applicable.

**Standardizing Data**
- Ensured consistency in data formats.
- Standardized categorical data to avoid discrepancies caused by case sensitivity or variations in naming conventions.

### 2. Data Transformation
- Cleaned data was stored in a staging table for further processing.
- Removed unnecessary columns or rows that did not add any value to the analysis.

### 3. Exploratory Data Analysis
- Conducted an exploratory data analysis to gain key insights about the sales of biking products in regards to regional performance, customer demographics, product profits.

## Tools
- SQL: Used for data cleaning, preparation and exploration
- Database Management System: SQL Server
