# Customer Segmentation Analysis

## Overview
This project focuses on performing a comprehensive customer segmentation analysis for an automobile company aiming to enter new markets. By leveraging existing customer data and machine learning techniques, the goal is to classify potential new customers into pre-defined segments (A, B, C, D) for targeted marketing and outreach strategies.

---

## Objectives
- Analyze customer data to identify patterns and key insights.
- Train and evaluate machine learning models to predict customer segments.
- Provide actionable recommendations based on segmentation results to enhance business decision-making.

---

## Dataset
The dataset consists of:
- **Training Data**: Historical customer data with known segment labels.
- **Test Data**: New customer data requiring segmentation predictions.

### Key Features:
- `Gender`, `Ever_Married`, `Graduated`, `Profession`: Categorical variables.
- `Age`, `Work_Experience`, `Family_Size`: Numerical variables.
- `Spending_Score`: Ordinal variable (`Low`, `Average`, `High`).

### Target Variable:
- `Segmentation`: Ordinal classification (`A`, `B`, `C`, `D`).

---

## Methodology
1. **Data Preprocessing**:
   - Handling missing values, outliers, and inconsistent formats.
   - Encoding categorical variables and scaling numerical features.

2. **Exploratory Data Analysis (EDA)**:
   - Visualizations to understand feature distributions and relationships.
   - Correlation analysis and feature importance.

3. **Model Selection and Training**:
   - Models evaluated: Logistic Regression, Decision Tree, Random Forest, CatBoost, SVM, and KNN.
   - **Best Model**: CatBoost with an accuracy of 54.21%.

4. **Prediction**:
   - Used the trained CatBoost model to predict segments for 2627 new customers.
   - Validated predictions with visualizations (e.g., segment distributions).

---

## Results
- **Key Insights**:
  - The predicted segments for the new customers show a relatively balanced distribution.

---

## Recommendations
1. Enhance data collection to include additional features (e.g., geographic or behavioral data).
2. Improve feature engineering to better separate overlapping segments.
3. Explore ensemble techniques like stacking to further improve model accuracy.

---

## Technologies Used
- **Programming Language**: Python
- **Libraries**: Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn, CatBoost



---

## Conclusion
This project demonstrates the use of machine learning and data analysis techniques to solve a business problem by predicting customer segments. The analysis provides valuable insights and highlights opportunities for further improvement in data collection and model optimization.

