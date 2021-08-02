USE employees;
-- 1. Show a list of all the tables in the database.
SHOW TABLES;

-- 2.	Find the names, and gender of all employees.
SELECT first_name, last_name, gender FROM employees;

-- 3.	Find all job titles.
SELECT title FROM titles;

-- 4.	Find all distinct job titles.
SELECT DISTINCT title FROM titles;

-- 5. What is the total number of employees? 300024
SELECT COUNT(*) FROM employees;

-- 6.	How many times were salaries paid?
-- 2844047
SELECT COUNT(*) FROM salaries;

-- 7.	How many departments are there?
-- 9
SELECT COUNT(*) FROM departments;

-- 8.	What are the names of these departments?
SELECT dept_name FROM departments;

-- 9. Find the names of all female employees.
SELECT first_name, last_name FROM employees WHERE gender = 'F';

-- 10.	How many male employees are there?
SELECT COUNT(*) FROM employees WHERE gender = 'M';

-- 11. Find all employees who were hired before the year 1990.
SELECT * FROM employees WHERE YEAR(hire_date) < 1990;

-- 12. Find male employees who were hired after 1995;
SELECT * FROM employees WHERE (YEAR(hire_date) > 1995 AND gender = 'm');

-- 13. How many employees have their first names as either Adin, Deniz, Youssef and Roded?
SELECT COUNT(*) FROM employees WHERE first_name IN ( 'Adin', 'Deniz', 'Youssef', 'Roded');

-- 14.	How many employees are:
-- 		a.	engineers? 120510
SELECT COUNT(*) FROM titles WHERE title LIKE '%Engineer%' AND YEAR(to_date) = 9999;

-- 		b.	non-engineers? 119614
SELECT * FROM titles WHERE title NOT LIKE '%Engineer%' AND YEAR(to_date) = 9999;


-- 15. How many employees were hired between 1990/01/01 and 1994/01/01.
SELECT COUNT(*) FROM employees WHERE hire_date BETWEEN '1990-01-01' AND'1994-01-01';

-- 16. Find the list of unique last names of female employees (in alphabetical order), who were born before the year 1970, and hired after 1996. 
SELECT DISTINCT last_name FROM employees WHERE YEAR(birth_date) < 1970 AND YEAR(hire_date) > 1996 AND gender = 'F'ORDER BY last_name; 


-- 17.	For each gender, how many employees were hired before 1989;
SELECT gender, COUNT(*) FROM employees WHERE YEAR(hire_date) < 1989 GROUP BY gender;

-- 18.	For each gender:
-- a.	how many employees are in each department?
SELECT gender, dept_name, COUNT(*) FROM dept_emp
	LEFT OUTER JOIN departments ON dept_emp.dept_no = departments.dept_no
    LEFT OUTER JOIN employees ON dept_emp.emp_no = employees.emp_no
    WHERE YEAR(to_date) = 9999
    GROUP BY gender, dept_name
    ORDER BY gender;
    
-- b.	hired between the years of 1994-1996?
SELECT gender, COUNT(*) FROM employees 
WHERE YEAR(hire_date) > 1994 AND YEAR(hire_date) < 1996 
GROUP BY gender;


-- 19.	List the names of all employees with department managers appointed starting from 1992/09/08 and ending at 1996/01/03.
SELECT first_name, last_name FROM employees 
WHERE 
emp_no = 
(SELECT emp_no FROM dept_manager 
WHERE from_date = '1992-09-08' AND to_date = '1996-01-03');


-- 20. List the names of employees and their respective job titles.
SELECT first_name, last_name, IFNULL(title, "NO CURRENT JOB TITLE") FROM employees 
LEFT OUTER JOIN 
(SELECT * FROM titles WHERE YEAR(to_date) = 9999) AS tls
ON employees.emp_no = tls.emp_no;


-- 21.	Find the average salary of every department.
-- historical average
SELECT dept_name, AVG(salary) FROM salaries 
LEFT OUTER JOIN dept_emp 
ON salaries.emp_no = dept_emp.emp_no
LEFT OUTER JOIN departments 
ON dept_emp.dept_no = departments.dept_no
GROUP BY dept_name;

-- 22. Find the average salary of every department and the number of employees.
SELECT dept_name, AVG(salary), COUNT(DISTINCT(emp_no)) AS 'number of employees' FROM
(SELECT s_1.emp_no, s_1.salary, d_e.dept_no , dep.dept_name 
FROM salaries AS s_1
INNER JOIN dept_emp AS d_e
ON s_1.emp_no = d_e.emp_no
LEFT OUTER JOIN departments AS dep
ON d_e.dept_no = dep.dept_no) AS union_table
GROUP BY dept_name;


-- UNION
-- (SELECT s_2.emp_no, s_2.salary, d_m.dept_no , dep.dept_name 
-- FROM salaries AS s_2
-- INNER JOIN dept_manager AS d_m
-- ON s_2.emp_no = d_m.emp_no
-- LEFT OUTER JOIN departments AS dep
-- ON d_m.dept_no = dep.dept_no)) AS union_table
-- GROUP BY dept_name;


-- 23.	Number of employees in every department who make more than $130000.
SELECT dept_name, COUNT(DISTINCT(emp_no)) AS 'number of employees' FROM
(SELECT s_1.emp_no, s_1.salary, d_e.dept_no , dep.dept_name 
FROM salaries AS s_1
INNER JOIN dept_emp AS d_e
ON s_1.emp_no = d_e.emp_no
LEFT OUTER JOIN departments AS dep
ON d_e.dept_no = dep.dept_no) AS union_table
WHERE union_table.salary > 130000
GROUP BY dept_name;
