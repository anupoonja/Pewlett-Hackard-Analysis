-- Additional queries

-- Total Employees ready to retire
SELECT COUNT(ut.emp_no)
FROM unique_titles AS ut;

-- Count of mentorship_eligilibity
SELECT COUNT(me.emp_no)
FROM mentorship_eligibility AS me;

-- Mentorship Eligibilty by title
SELECT COUNT(mt.emp_no), mt.title
INTO mentorship_eligibility_title
FROM mentorship_eligibility as mt
GROUP BY mt.title
ORDER BY count DESC;

SELECT * FROM mentorship_eligibility_title;

-- Count the retirement eligible employees per department
SELECT COUNT(ei.emp_no), d.dept_name
FROM emp_info as ei
INNER JOIN dept_emp AS de
ON (ei.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
GROUP BY d.dept_name
ORDER BY COUNT DESC;

-- Mentorship Eligibility by Department
SELECT COUNT(me.emp_no), d.dept_name
FROM mentorship_eligibility as me
INNER JOIN dept_emp AS de
ON (me.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
GROUP BY d.dept_name
ORDER BY COUNT DESC;

-- Extended Mentorship Eligibility to 4 years
SELECT DISTINCT ON(e.emp_no) 
	e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibility4
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1961-01-01' AND '1965-12-31')
	AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;

SELECT COUNT(mt4.emp_no), mt4.title
INTO mentorship_eligibility4_by_title
FROM mentorship_eligibility4 as mt4
GROUP BY mt4.title
ORDER BY count DESC;

