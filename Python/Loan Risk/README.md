# Loan Eligibility Prediction

This project explores factors influencing loan eligibility and evaluates different machine learning models to predict if an individual is likely to receive a loan. Models considered include **Logistic Regression**, **Random Forest**, and **Support Vector Machines (SVM)**.  

---

## **Dataset**
The dataset, `credit.csv`, contains information about individuals and their loan applications, including financial history, demographics, and loan-related attributes.

---

## **Project Workflow**

### **1. Data Loading and Exploration**
- Load the dataset using `pandas`.
- Inspect the structure of the dataset (e.g., missing values, data types, summary statistics).
- Visualize relationships between variables using libraries like `seaborn` and `matplotlib`.

### **2. Data Cleaning**
- Handle missing or inconsistent values.
- Encode categorical variables (using **One-Hot Encoding**).
- Normalize or standardize numerical features.
- Split the dataset into training and testing sets.

### **3. Feature Selection**
- Evaluate feature importance using correlation heatmaps and statistical techniques.
- Select features that significantly influence loan eligibility.

### **4. Model Implementation**
- Train and evaluate the following models:
  - **Logistic Regression**
  - **Random Forest**
  - **SVM (Support Vector Machine)**

### **5. Model Evaluation**
- Assess model performance using metrics such as:
  - Accuracy
  - Precision, Recall, F1-Score
- Compare models to identify the best-performing one for this task.

### **6. Insights and Visualization**
- Identify key factors influencing loan eligibility.
- Visualize model predictions and performance comparisons.

---

## **Dependencies**
The following Python libraries are required:
- **pandas**: For data manipulation and analysis.
- **numpy**: For numerical computations.
- **matplotlib**: For data visualization.
- **seaborn**: For statistical data visualization.
- **scikit-learn**: For machine learning model implementation and evaluation.

---

## **License**
This project is licensed under the [MIT License](LICENSE).

---

## **Acknowledgements**
Special thanks to the creators of the dataset and the contributors to Python's open-source libraries.
