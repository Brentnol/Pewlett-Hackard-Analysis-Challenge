 -- DELIVERABLE # 1:
 -- Create new table for retiring employees from Sales
    SELECT emp.emp_no,
   	emp.first_name,
   	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
 -- Next, we need to create a new table to hold the information. Let's name it "retirement_titles".
	INTO retirement_titles
 -- The next step is to add the code that will join these two tables.  
    FROM employees as emp
	LEFT JOIN titles as ti
	ON emp.emp_no = ti.emp_no
 -- Finally, because this is a table of retiring employees titles, we need to add a filter, using the WHERE keyword and the employees birth_date emp.emp_no ASC;
    WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	ORDER BY emp.emp_no ASC;
    
    SELECT* FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
	SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title 
	INTO unique_titles
	FROM retirement_titles
	WHERE to_date IN ('9999-01-01')
	ORDER BY emp_no, to_date  DESC;

    SELECT* FROM unique_titles;

-- Retrive the number of employees by their most recent job title who are about to retire 

 	SELECT COUNT (title), title 
	INTO retiring_titles
	FROM unique_titles
	GROUP BY title
	ORDER BY COUNT DESC

	SELECT* FROM retiring_titles;

-- DELIVERABLE # 2:
-- write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

    SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
	de.to_date,
	ti.title
	INTO mentorship_eligibilty
	FROM employees as e
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
	WHERE (de.to_date = '9999-01-01')
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
	ORDER BY e.emp_no  ASC;

	SELECT* FROM mentorship_eligibilty;