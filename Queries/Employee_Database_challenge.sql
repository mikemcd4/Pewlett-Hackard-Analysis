-- Deliverable 1 Retirement_titles

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Deliverable 1 Filter out only most recent title

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Deliverable 1  Count of retirement by title
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Deliverable 2, mentorship eligibility

SELECT DISTINCT ON (e.emp_no) 
	e.emp_no, e.first_name, e.last_name, 
	e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- Deliverable 3, additional tables
SELECT COUNT(emp_no), title
INTO mentoring_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
to_date,
title
INTO unique2_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT COUNT(emp_no), title
INTO retiring2_titles
FROM unique2_titles
GROUP BY title
ORDER BY count DESC;