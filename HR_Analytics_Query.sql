/*
=============================================================================
PROJECT: HR Analytics - Employee Attrition & Performance
AUTHOR: Muhammad Zaenal Abidin Abdurrahman
DATABASE: MySQL
DESCRIPTION:
  End-to-end data engineering script:
  audit, BOM fix, feature engineering, and master view creation for BI.
=============================================================================
*/

USE hr_analytics;

-- Mengecek data apakah sudah berhasil di load dan sesuai dengan ekspetasi
select *
from hr_analytics.ibm_hr_attrition;

select count(*)
from hr_analytics.ibm_hr_attrition;

show columns from hr_analytics.ibm_hr_attrition;	


------------------------------------------------------------------------------------
# TICKET #02: Data Audit

-- Jika sebuah kolom nilainya sama semua, maka kolom itu di drop karena tidak akan berguna untuk analisis lebih lanjut.
-- Secara intuitive dan jika dilihat sekilas maka kolom yang sepertinya tidak akan berguna adalah : 
select distinct EmployeeCount, Over18, StandardHours
from hr_analytics.ibm_hr_attrition;


-- Constant column audit (better than DISTINCT multi-column) 
SELECT
  COUNT(DISTINCT EmployeeCount)  AS dc_employee_count,
  MIN(EmployeeCount)             AS min_employee_count,
  MAX(EmployeeCount)             AS max_employee_count,
  COUNT(DISTINCT Over18)         AS dc_over18,
  MIN(Over18)                    AS min_over18,
  MAX(Over18)                    AS max_over18,
  COUNT(DISTINCT StandardHours)  AS dc_standard_hours,
  MIN(StandardHours)             AS min_standard_hours,
  MAX(StandardHours)             AS max_standard_hours
FROM hr_analytics.ibm_hr_attrition;

-- check duplikat
select count(DISTINCT EmployeeNumber) AS UniqueEmployeeNumber, count(*) AS DataCount
from hr_analytics.ibm_hr_attrition;
-- Tidak ada data duplikat

-- Check if there is null in important column
select Attrition, Department, JobRole
from hr_analytics.ibm_hr_attrition
where Attrition is null
	or Department is null
	or JobRole is null;
-- Bersih, tidak ada yang null

-- Penemuan hal aneh : 
select `﻿Age`
from hr_analytics.ibm_hr_attrition;

select Age
from hr_analytics.ibm_hr_attrition;
-- ketika dijalankan, baris yang akan jalan adalah line 36, sedangkan line 39 gagal

/*
Description: 
    Handling data ingestion issue related to UTF-8 Byte Order Mark (BOM).
    The CSV source contained a hidden BOM character (\ufeff) in the header,
    causing the first column 'Age' to be unrecognized by standard queries.
-------------------------------------------------------------------------
*/

-- Step 1: Fix Column Name (Remove BOM character from 'Age')
-- Note: The first column name below contains the invisible BOM character.
alter table hr_analytics.ibm_hr_attrition 
change column `﻿Age` `Age` int;

-- Verification: Check if column is now queryable
select Age from hr_analytics.ibm_hr_attrition limit 5;

-- Check apakah ada baris ataupun kolom yang memiliki keanehan logika
-- 1. Mungkinkah TotalWorkingYears (Pengalaman Kerja) lebih besar dari Age (Umur)?
select Age, TotalWorkingYears 
from hr_analytics.ibm_hr_attrition
where TotalWorkingYears > Age;

-- 2. Mungkinkah YearsAtCompany (Lama di IBM) lebih besar dari TotalWorkingYears (Pengalaman Total)? 
select YearsAtCompany, TotalWorkingYears 
from hr_analytics.ibm_hr_attrition
where YearsAtCompany > TotalWorkingYears;

-- hasilnya Kosong (0 rows).


------------------------------------------------------------------------------------
-- TICKET #03: Data Cleaning & Feature Engineering

-- Menghapus kolom yang tidak bermanfaat (Pastikan selalu memiliki backup ataupun juga bisa menggunakan view table)
-- Recommendation: DO NOT mutate raw table (drop columns) for analytics.
-- Instead, handle exclusions via VIEW.
alter table hr_analytics.ibm_hr_attrition
	drop column EmployeeCount, 
    drop column Over18, 
    drop column StandardHours; 

show columns from hr_analytics.ibm_hr_attrition;

-- Feature Engineering: 
-- 1. "Age Grouping" (Generation)
select Age,
	case 
		when Age < 25 then 'Gen Z'
		when Age >= 25 and Age < 40 then 'Millennials'
        when Age >= 40 and Age < 55 then 'Gen X'
        else 'Boomers' end as Generation
from hr_analytics.ibm_hr_attrition; 

-- 2. Income Bracket
select min(MonthlyIncome) as Smallest_Income,
	   max(MonthlyIncome) as Biggest_Income
from hr_analytics.ibm_hr_attrition; 

/*
smallest : 1009 
biggest : 19999
*/

select MonthlyIncome,
	case
		when MonthlyIncome < 5000 then 'Low'
        when MonthlyIncome >= 5000 and MonthlyIncome <= 15000 then 'Medium'
        else 'High' end as Income_Group
from hr_analytics.ibm_hr_attrition; 


------------------------------------------------------------------------------------
-- TICKET #04: Create Master View for Power BI
-- Transforms raw codes into Business-Friendly categories.
-- Pre-calculates metrics to optimize Power BI performance.

DROP VIEW IF EXISTS vw_hr_master;

CREATE VIEW vw_hr_master AS
SELECT
    *,
    
    -- 1. METRIC: Attrition Count
    CASE 
        WHEN Attrition = 'Yes' THEN 1 
        ELSE 0 
    END AS Attrition_Count,
    
    -- 2. SEGMENT: Generation
    CASE 
        WHEN Age < 25 THEN 'Gen Z'
        WHEN Age >= 25 AND Age < 40 THEN 'Millennials'
        WHEN Age >= 40 AND Age < 55 THEN 'Gen X'
        ELSE 'Boomers' 
    END AS Generation,
    
    -- 3. SEGMENT: Income Bracket
    CASE 
        WHEN MonthlyIncome < 5000 THEN 'Low Income (<5k)'
        WHEN MonthlyIncome BETWEEN 5000 AND 15000 THEN 'Medium Income (5k-15k)'
        ELSE 'High Income (>15k)' 
    END AS Income_Group,
    
    -- 4. SEGMENT: Performance Label
    CASE 
        WHEN PerformanceRating = 1 THEN 'Low'
        WHEN PerformanceRating = 2 THEN 'Good'
        WHEN PerformanceRating = 3 THEN 'Excellent'
        WHEN PerformanceRating = 4 THEN 'Outstanding'
    END AS Performance_Label,

    -- 5. SEGMENT: Job Satisfaction Category
    CASE
        WHEN JobSatisfaction <= 2 THEN 'Unhappy'
        ELSE 'Happy'
    END AS Satisfaction_Status

FROM hr_analytics.ibm_hr_attrition;

-- Verification
SELECT * FROM vw_hr_master LIMIT 5;