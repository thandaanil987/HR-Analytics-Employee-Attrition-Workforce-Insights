use da_projects;
select*from hr_employee_cleaned;

--  1 – Total employees
select count(*)as Total_employees from hr_employee_cleaned;

-- 2– Employee attrition count
select attrition,count(*) as employee_count 
from hr_employee_cleaned 
group by attrition;

-- 3- Overall attrition rate
select round(sum(case when attrition="Yes" then 1 else 0 end)*100/count(*),2)
as attrition_rate 
from hr_employee_cleaned;

-- 4-Department-wise attrition

select department,count(*)as total_employees,
sum(case when attrition="Yes" then 1 else 0 end) as employee_left,
round(sum(case when attrition="Yes" then 1 else 0 end)*100.0/count(*),2)as attrition_rate 
from hr_employee_cleaned 
group by department
order by attrition_rate desc;

-- 5-Attrition by job role

select jobrole,count(*)as total_employees,
sum(case when attrition="Yes" then 1 else 0 end) as employee_left
from hr_employee_cleaned 
group by jobrole
order by employee_left desc;

-- 6 Attrition by age group

select 
	 CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left
from hr_employee_cleaned 
group by age_group
order by employees_left desc;

-- 7 Overtime and attrition

SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employee_cleaned
GROUP BY OverTime;


-- 8 – Attrition by work experience

SELECT
    CASE
        WHEN YearsAtCompany < 1 THEN 'Less than 1 year'
        WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN YearsAtCompany BETWEEN 4 AND 6 THEN '4-6 years'
        WHEN YearsAtCompany BETWEEN 7 AND 10 THEN '7-10 years'
        ELSE 'Above 10 years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left
FROM hr_employee_cleaned
GROUP BY tenure_group
ORDER BY employees_left DESC;

-- 9 – Average income by attrition

SELECT
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM hr_employee_cleaned
GROUP BY Attrition;


-- 10 – MaritalStatus and attrition
SELECT
    MaritalStatus,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left
FROM hr_employee_cleaned
GROUP BY MaritalStatus
ORDER BY MaritalStatus;

