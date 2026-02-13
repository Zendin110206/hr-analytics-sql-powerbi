# HR Analytics: Employee Attrition & Performance Analysis

![SQL](https://img.shields.io/badge/Language-MySQL-orange)
![Power BI](https://img.shields.io/badge/Tool-Power%20BI-F2C811)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

## Project Overview
This project focuses on analyzing employee attrition and performance metrics using a fictional dataset provided by IBM Data Scientists. The primary objective is to identify key factors contributing to employee turnover and to provide data-driven recommendations for retention strategies.

The analysis workflow involves data engineering and exploration using **SQL** (Microsoft SQL Server), followed by the development of an interactive dashboard in **Power BI** to visualize critical KPIs and risk factors.

## Business Problem
High employee attrition rates can lead to significant operational costs and loss of institutional knowledge. The Human Resources department requires a diagnostic analysis to answer the following questions:
1.  What is the current attrition rate, and how does it vary by department?
2.  Are there correlations between overtime, income, and attrition?
3.  Which employee segments are at the highest risk of leaving?
4.  What is the estimated financial impact of attrition on the organization?

## Methodology & Technical Approach

### 1. Data Engineering (SQL)
The raw data is processed using SQL to simulate a real-world data warehousing environment. Key tasks include:
*   **Data Quality Assessment:** Checking for null values, duplicates, and inconsistent data types.
*   **Feature Engineering:** Creating age buckets (Generational grouping) and income brackets for categorical analysis.
*   **Diagnostic Analysis:** Utilizing complex queries (aggregations, conditional logic) to uncover patterns related to job satisfaction, work-life balance, and compensation.

### 2. Visualization & Reporting (Power BI)
The findings will be translated into a strategic dashboard featuring:
*   **Executive Summary:** High-level KPIs including total attrition, average tenure, and average salary.
*   **Demographic Analysis:** Attrition breakdown by age, gender, and marital status.
*   **Risk Profiling:** Identifying specific employee groups with high probability of attrition based on performance and satisfaction gaps.

## Dataset
*   **Source:** IBM HR Analytics Employee Attrition & Performance.
*   **Format:** CSV.
*   **Volume:** Contains demographic and job-related data for approximately 1,470 employees.

## Project Structure
```text
├── data/
│   └── HR_Employee_Attrition.csv
├── visualization/
│   └── (Power BI file and screenshots will be added here)
├── HR_Analytics_Query.sql
└── README.md
```

---

*Implementation by [Muhammad Zaenal Abidin Abdurrahman](https://www.linkedin.com/in/zendin1102/) - 2026*

