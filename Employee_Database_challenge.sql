-- Deliverable 1: The Number of Retiring Employees by Title
SELECT * FROM employees;
SELECT * FROM titles;

-- 1) Retrieve the emp_no, first_name, and last_name columns from the Employees table.

SELECT e.emp_no, e.first_name, e.last_name
FROM employees AS e;

-- 2) Retrieve the title, from_date, and to_date columns from the Titles table.

SELECT t.title, t.from_date, t.to_date
FROM titles AS t;

-- 3) Create a new table using the INTO clause.
-- 4) Join both tables on the primary key.
-- 5) Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955.
--    Then, order by the employee number.

SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
	LEFT JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- 10) Use the DISTINCT ON statement to retrieve the first occurrence of the 
--     employee number for each set of rows defined by the ON () clause.
-- 11) Create a Unique Titles table using the INTO clause.
-- 12) Sort the Unique Titles table in ascending order by the employee number
--     and descending order by the last date (i.e. to_date) of the most recent title.

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

-- 15) Number of employees by their most recent job title who are about to retire.
-- 16) First, retrieve the number of titles from the Unique Titles table.
-- 17) Then, create a Retiring Titles table to hold the required information.
-- 18) Group the table by title, then sort the count column in descending order.

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.

SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM titles;

SELECT DISTINCT ON(e.emp_no) 
	e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;


	