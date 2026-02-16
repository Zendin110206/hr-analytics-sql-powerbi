# HR Executive Command Center: People Analytics Platform

![MySQL](https://img.shields.io/badge/Database-MySQL_8.0-005C84?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Visualization-Power_BI-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Active_Development-007ACC)

## Dashboard Architecture Preview
![Dashboard Landing Page](visualization/landing_page_preview.png)

> **Current Status:** This project is currently under active development. The Data Engineering (SQL) pipeline and UI/UX Architecture are complete. Development is now focused on finalizing the visualization modules (Executive View, Root Cause Analysis, and Risk Action List).

---

## Project Overview
This project serves as a strategic analytics solution designed to diagnose Employee Attrition and quantify Workforce Performance risks. Unlike standard reporting dashboards, this solution is architected as an **Analytics Application** with a dedicated navigation system, treating data analysis as a distinct internal product.

Leveraging a dataset from IBM HR Analytics, the primary objective is to shift HR monitoring from descriptive reporting to **diagnostic analysis**. The system calculates critical financial metrics, such as the estimated **$9M Bad Hiring Cost**, and identifies high-risk employee segments to formulate data-driven retention strategies.

## Technical Implementation

### 1. Data Engineering & Transformation (MySQL)
To ensure scalability and performance, this project rejects the standard workflow of loading raw CSV files directly into visualization tools. Instead, **SQL** is utilized for data hardening, logic encapsulation, and anomaly resolution before the data reaches the BI layer.

* **Data Integrity & Auditing**
    * Performed rigorous data auditing to identify schema inconsistencies and constant values.
    * Resolved critical data ingestion issues, specifically handling hidden **UTF-8 BOM characters** in the raw CSV headers that prevented standard column recognition.

* **Feature Engineering via SQL**
    * Developed categorical features directly in the database layer using `CASE` statements.
    * **Generational Segmentation:** Transforming numerical Age into 'Gen Z', 'Millennials', 'Gen X', and 'Boomers'.
    * **Socio-Economic Grouping:** Bucketing salary data into 'Low', 'Medium', and 'High' Income Groups.
    * *Benefit:* This approach reduces the processing load on Power BI (DAX) and ensures consistent business logic across the platform.

* **Logic Encapsulation (Views)**
    * Created a master view `vw_hr_master` to serve as the single source of truth. This abstraction layer protects the dashboard from changes in the underlying raw tables and pre-calculates binary flags for attrition.

### 2. Dashboard Architecture (Power BI)
The visualization layer is designed with a **"Navigation-First"** approach, mimicking a modern web application interface rather than a static long-scroll report.

* **Module 00: Command Center (Landing Page)**
    * Acts as the central navigation hub.
    * Features state-based button interactivity (Hover/Press logic) to enhance user experience.
* **Module 01: Executive View (In Progress)**
    * Focuses on high-level KPIs including Attrition Rate, Financial Impact, and Average Tenure.
* **Module 02: Root Cause Lab (In Progress)**
    * Deep-dive diagnostic analysis correlating Overtime, Job Satisfaction, and Distance from Home with attrition risk.
* **Module 03: Action List (In Progress)**
    * Detailed employee profiling and row-level data to identify specific individuals requiring immediate retention intervention.

---

## Repository Structure

```text
├── data/
│   └── HR_Employee_Attrition.csv      # Raw Data Source
│
├── visualization/
│   ├── HR_Analytics_Dashboard.pbix    # Power BI Project File (WIP)
│   └── landing_page_preview.png       # Dashboard UI Screenshot
│
├── HR_Analytics_Query.sql             # Complete Data Engineering Script
└── README.md                          # Technical Documentation
```

---

## Development Roadmap

* [x] **Phase 1: Data Engineering** (Audit, Cleaning, View Creation)
* [x] **Phase 2: Semantic Modeling** (DAX Measures & Financial Metrics)
* [x] **Phase 3: UI Architecture** (Landing Page & Navigation System)
* [ ] **Phase 4: Strategic Dashboard** (Executive View Construction)
* [ ] **Phase 5: Diagnostic Dashboard** (Root Cause Analysis)
* [ ] **Phase 6: Operational Detail** (Risk List & Row Level Security)

---

*Implementation by [Muhammad Zaenal Abidin Abdurrahman](https://www.linkedin.com/in/zendin1102/) - 2026*
