-- A. Workforce Demographics & Distribution (Descriptive Analytics) --

-- 1. What is the total headcount for each department, and what is the gender breakdown (percentage split) within each?

SELECT
  department,
  COUNT(department) AS total_employees,
  COUNT(CASE WHEN gender = 'Female' THEN 'Female' END) AS female,
  COUNT(CASE WHEN gender = 'Male' THEN 'Male' END) AS male
FROM hr.employees
GROUP BY department
ORDER BY total_employees DESC;

-- 2. How is the company distributed across different age brackets (e.g., <25, 25-34, 35-44, etc.) and average years of service (tenure)?

SELECT
  CASE 
    WHEN age < 25 THEN '<25'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age > 44 THEN '>44'
  END AS age_groups,
  COUNT(age) AS total_employees,
  ROUND(AVG(tenure_years), 1) avg_years_of_service
FROM `hr.employees`
GROUP BY age_groups;

-- 3. Which state, city, or office branch houses the highest concentration of employees, and how does the average salary scale by location?

-- Create a permanent right-joined table --
CREATE TABLE hr.employees_full AS
SELECT
  ep.*,
  cp.company_name,
  cp.industry,
  cp.city,
  cp.founded_year,
  cp.company_size,
  cp.remote_policy,
FROM hr.companies cp
RIGHT JOIN hr.employees ep
  ON cp.company_id = ep.company_id;

SELECT
  city,
  COUNT(employee_id) AS total_employees,
  ROUND(AVG(monthly_salary_egp), 2) AS avg_montly_salary
FROM hr.employees_full
GROUP BY city
ORDER BY total_employees DESC;

-- B. Compensation & Salary Analysis (Financial / Reward Analytics) --

-- 4. What are the minimum, maximum, and average salaries for each job title? Which roles show the widest pay gaps between min and max?

SELECT
  department,
  job_level,
  MIN(monthly_salary_egp) AS min_salary,
  MAX(monthly_salary_egp) AS max_salary,
  ROUND(AVG(monthly_salary_egp) ,2) AS avg_salary
FROM hr.employees_full
GROUP BY department, job_level
ORDER BY (max_salary - min_salary) DESC; 

-- 5. Within the same job title and performance score bracket, is there a noticeable difference in average compensation across genders or demographic groups?

SELECT
  gender,
  department,
  job_level,
  ROUND(AVG(monthly_salary_egp) ,2) AS avg_salary
FROM hr.employees_full
GROUP BY gender, department, job_level
ORDER BY department, job_level;

-- 6. Do employees with higher performance scores consistently receive higher compensation, or are there significant outliers (e.g., high performers earning below the departmental average)?

SELECT performance_rating, ROUND((AVG(monthly_salary_egp)), 2) AS avg_monthly_salary
FROM hr.employees_full
GROUP BY performance_rating
ORDER BY performance_rating DESC;


-- C. Employee Retention & Attrition (Predictive / Risk Analytics)

-- 7. What is the overall company attrition rate, and which specific departments or job roles suffer from the highest turnover?
WITH attrition_rate AS (
    SELECT 
      ef.department,
      ef.job_level,
      COUNT(CASE WHEN ef.left_company = true THEN 1 END) * 1.0 AS left_count,
      COUNT(ef.left_company) * 1.0 AS total_count
    FROM hr.employees_full ef
    GROUP BY ef.department, ef.job_level
)
SELECT
  department,
  job_level,
  ROUND((left_count / total_count) * 100, 2) AS left_pct,
FROM attrition_rate
ORDER BY left_pct DESC;

-- 8. For employees who have left, what is the average length of service (tenure) before departure? Is there a "critical cliff" period (e.g., within the first year, or right around year 3)
SELECT ROUND(AVG(tenure_years), 1) AS avg_tenure
FROM hr.employees_full
WHERE left_company = true;

-- 9. Which supervisors or managers have the highest number or percentage of direct reports leaving the company?
WITH attrition_rate AS (
    SELECT 
      ef.department,
      ef.job_level,
      COUNT(CASE WHEN ef.left_company = true THEN 1 END) * 1.0 AS left_count,
      COUNT(ef.left_company) * 1.0 AS total_count
    FROM hr.employees_full ef
    GROUP BY ef.department, ef.job_level
)
SELECT
  department,
  job_level,
  ROUND((left_count / total_count) * 100, 2) AS left_pct,
FROM attrition_rate
WHERE job_level = 'Manager'
ORDER BY left_pct DESC;

-- 10. Who are the top-performing employees (based on performance scores/ratings) who have been with the company for more than 3 years but haven't received a title change or promotion?
SELECT full_name, department, job_level, tenure_years, performance_rating
FROM hr.employees_full
WHERE tenure_years > 3 AND job_level <> 'Manager'
ORDER BY performance_rating DESC
LIMIT(5);