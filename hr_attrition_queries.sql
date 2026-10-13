-- Employee Attrition & Workforce Analysis

CREATE DATABASE employee_attrition_analysis; 
USE employee_attrition_analysis;

SELECT * FROM employee_attrition;

-- 1. Display the first 10 rows from the table. 
SELECT * 
FROM employee_attrition
LIMIT 10;

-- 2. Find the total number of employees in the company. 
SELECT COUNT(*) AS employee_count
FROM employee_attrition;

-- 3. List all unique departments. 
SELECT DISTINCT(department)
FROM employee_attrition;

-- 4. Show how many employees have left the company and how many are still working.
SELECT 
	COUNT(CASE WHEN attrition = "Yes" THEN 1 END)AS employee_left_count,
    COUNT(CASE WHEN attrition = "No" THEN 1 END) AS employee_working_count
FROM employee_attrition;

SELECT 
	attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY attrition;
  
-- 5. Retrieve the list of employees who work overtime. 
SELECT 
	COUNT(*) AS employee_count
FROM employee_attrition
WHERE overtime = "Yes";

SELECT *
FROM employee_attrition
WHERE overtime = "Yes";

SELECT 
	employeenumber,
    age,
    department,
    jobrole,
    overtime
FROM employee_attrition
WHERE overtime = "Yes";

-- 6. Find the average monthly income of all employees. 
SELECT 
	ROUND(AVG(monthlyincome),2) AS average_monthly_income
FROM employee_attrition;

-- 7. Identify employees whose number of companies worked is missing (NULL). 
SELECT 
	*
FROM employee_attrition
WHERE numcompaniesworked IS NULL; 

-- 8. Find the employee(s) with the maximum monthly income. 
SELECT *
FROM employee_attrition
WHERE monthlyincome = (
	SELECT MAX(monthlyincome)
    FROM employee_attrition
);

SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    Attrition
FROM employee_attrition
WHERE MonthlyIncome = (
    SELECT MAX(MonthlyIncome)
    FROM employee_attrition
);

-- 9. Count the number of employees by gender. 
SELECT 
	COUNT(CASE WHEN gender = "Male" THEN 1 END) AS male_employee_count,
    COUNT(CASE WHEN gender = "Female" THEN 1 END) AS female_employee_count
FROM employee_attrition;

SELECT 
	gender,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY gender;

-- 10. List all employees who have just joined (YearsAtCompany = 0). 
SELECT *
FROM employee_attrition
WHERE yearsatcompany = 0;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany
FROM employee_attrition
WHERE YearsAtCompany = 0;

-- 11. Calculate the attrition rate (%) by department. 
SELECT 
	department,
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS leavers,
    ROUND(COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM employee_attrition
GROUP BY department
ORDER BY attrition_rate DESC;

-- 12. List the top 10 employees with the highest total working years.
SELECT *
FROM employee_attrition
ORDER BY totalworkingyears DESC
LIMIT 10;

SELECT
    EmployeeNumber,
    Age,
    JobRole,
    TotalWorkingYears
FROM employee_attrition
ORDER BY TotalWorkingYears DESC
LIMIT 10;
 
-- 13. Group employees into tenure categories (<1yr, 1–3yr, 4–6yr, 7+yr) and count employees in each. 
SELECT 
	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END AS tenure_category,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY tenure_category
ORDER BY 	
    CASE tenure_category
        WHEN '<1yr' THEN 1
        WHEN '1-3yr' THEN 2
        WHEN '4-6yr' THEN 3
        WHEN '7+yr' THEN 4
    END;

SELECT 
	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END AS tenure_category,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY tenure_category
ORDER BY 	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END ASC;
	
-- 14. Find the average monthly income by job level and attrition status. 
SELECT 
	joblevel,
    attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthlyincome),2) AS average_monthly_income
FROM employee_attrition
GROUP BY joblevel,attrition 
ORDER BY joblevel,attrition;

-- 15. Identify the top 5 job roles with the highest number of employees who left.
SELECT 
	jobrole,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS employees_left_count
FROM employee_attrition
GROUP BY jobrole
ORDER BY employees_left_count DESC
LIMIT 5;

SELECT
    JobRole,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY employees_left DESC
LIMIT 5;
 
-- 16. List employees who left the company within their first year. 
SELECT 
	*
FROM employee_attrition
WHERE attrition = "Yes"
AND yearsatcompany < 1;

SELECT COUNT(*) count_of_employees
FROM employee_attrition
WHERE attrition = "Yes"
AND yearsatcompany < 1;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    Attrition
FROM employee_attrition
WHERE Attrition = 'Yes'
AND YearsAtCompany < 1;

-- 17. Calculate each employee’s approximate new monthly compensation after applying their salary hike percentage.
SELECT 
	monthlyincome,
    monthlyincome * percentsalaryhike / 100.0 AS hike,
	monthlyincome + monthlyincome * percentsalaryhike / 100.0 AS new_monthly_income
FROM employee_attrition;

SELECT
    EmployeeNumber,
    MonthlyIncome,
    PercentSalaryHike,
    ROUND(MonthlyIncome * (1 + PercentSalaryHike / 100),2) AS approximate_new_monthly_income
FROM employee_attrition;

-- 18. Count employees grouped by overtime status and attrition. 
SELECT
	overtime, 
    attrition,
	COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY overtime, attrition
ORDER BY overtime, attrition;

-- 19. Display the top 10 employees who attended the most training sessions last year. 
SELECT *
FROM employee_attrition
WHERE trainingtimeslastyear = (
	SELECT max(trainingtimeslastyear)
    FROM employee_attrition
)
LIMIT 10;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    TrainingTimesLastYear
FROM employee_attrition
ORDER BY TrainingTimesLastYear DESC
LIMIT 10;

-- 20. Rank employees by total working years (most experienced = rank 1).
SELECT 
	*,
    RANK() OVER(ORDER BY totalworkingyears DESC) AS experience_rank
FROM employee_attrition;

SELECT
    EmployeeNumber,
    Age,
    JobRole,
    TotalWorkingYears,
    RANK() OVER (ORDER BY TotalWorkingYears DESC) AS experience_rank
FROM employee_attrition; 

-- 21. For each department, find employees whose monthly income is in the top 25% of that department. 
WITH cte AS(
	SELECT
		employeenumber,
		department,
		monthlyincome,
		PERCENT_RANK() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS percent_rnk,
		CUME_DIST() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS cume_dist_,
		NTILE(4) OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS quartile
	FROM employee_attrition
)
SELECT *
FROM cte 
WHERE quartile = 1
ORDER BY monthlyincome DESC;

-- 22. Divide employees into 10 income deciles and find attrition rate for each decile. 
WITH cte AS(
	SELECT *,
		NTILE(10) OVER(ORDER BY monthlyincome ASC) AS income_deciles
	FROM employee_attrition
)
SELECT 
	income_deciles,
    ROUND(AVG(monthlyincome),2) AS avg_monthly_income,
    COUNT(*) AS employee_count,
	COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS leavers,
    ROUND(COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM cte 
GROUP BY income_deciles
ORDER BY income_deciles;	

WITH income_deciles AS (
    SELECT
        EmployeeNumber,
        MonthlyIncome,
        Attrition,
        NTILE(10) OVER (ORDER BY MonthlyIncome) AS income_decile
    FROM employee_attrition
)
SELECT
    income_decile,
    COUNT(*) AS employee_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2) AS attrition_rate
FROM income_deciles
GROUP BY income_decile
ORDER BY income_decile;

-- 23. Create a simple risk score based on tenure, performance, overtime, and work-life balance —and list the top 50 high-risk employees. 
SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    PerformanceRating,
    OverTime,
    WorkLifeBalance,
    (
        CASE
            WHEN OverTime = 'Yes' THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN YearsAtCompany < 3 THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN PerformanceRating = 3 THEN 1
            ELSE 0
        END
        +
        CASE
            WHEN WorkLifeBalance <= 2 THEN 2 
            ELSE 0 
		END) AS risk_score
FROM employee_attrition
ORDER BY risk_score DESC
LIMIT 50;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    PerformanceRating,
    OverTime,
    WorkLifeBalance,
    (
        CASE WHEN OverTime = 'Yes' THEN 2 ELSE 0 END
        +
        CASE WHEN YearsAtCompany < 3 THEN 2 ELSE 0 END
        +
        CASE WHEN WorkLifeBalance <= 2 THEN 2 ELSE 0 END
    ) AS risk_score
FROM employee_attrition
ORDER BY risk_score DESC
LIMIT 50;

-- 24. Create a summary view showing, for each department and job level: total employees, number of leavers, attrition rate, and average monthly income.
SELECT 
	department,
    joblevel,
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS no_of_leavers,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate,
    AVG(monthlyincome) AS average_monthly_income
FROM employee_attrition
GROUP BY department,joblevel
ORDER BY department,joblevel;

CREATE VIEW department_joblevel_summary AS
SELECT
    Department,
    JobLevel,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) AS number_of_leavers,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0 
			END) * 100.0 / COUNT(*),2) AS attrition_rate,
	ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM employee_attrition
GROUP BY Department, JobLevel;

SELECT *
FROM department_joblevel_summary
ORDER BY department,joblevel;
