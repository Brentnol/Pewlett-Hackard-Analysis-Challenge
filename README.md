<!-- Strong-->
# Pewlett-Hackard-Analysis

<!-- Horizontal Rule-->

## Overview and Background of Project
Pewlett Hackard(PH) has identified a problem within the database department, wherein they have fallen behind with the management of the company's database. To help solve this problem, we have been requested by PH's management to use PostgreSQL and pgAdmin to create a database to work with the data. t
      
## Purpose
The purpose of this Data Analytic exercise is to use the combined power of PostgreSQL and pgAdmin to determine the number of retiring employees per title, identify employees who are eligible to participate in a mentorship program, and further prepare a report to summarize the analysis to enable management to deal with the many current employees reaching retirement age.

## Analysis and Challenges
The challenge of this exercise is to create new tables for the employees, department employee and employee title datasets using PostgreSQL and pgAdmin query scripting. And further, to display the results in multiple tables thus; retirement titles, retiring titles, unique titles and ultimately a mentorship eligibility table, which shows the employees eligible for mentorship. 

### Initial Review of Dataset:
<!--UL-->
* As a routine first step, a high-level inspection and review were done to get a sense of the source data regarding the dataset's number of columns and rows. This was done to understand the data types and to determine whether the data was readable or would need to be converted before progressing further with the analysis. Upon inspection of the dataset, it was determined that the files (Employees, department, department employee, department and title) were in csv format, which contained information stored in what appeared to be columns, separated by commas, with headings for employee number, first and last name, birthday, department number etc., which included, in the case of the employee dataset for example; more than 300,000 rows of data in 6 columns.  

<!--Links-->
<!--UL-->
* Because the employee dataset was so large, an investigation was done to precisely establish the number of columns and rows. This was done by opening the file in excel and utilizing various keyboard shortcuts, combining keyboard keys such as CTRL/right or down arrow keys to get a quick idea of the dataset's number of rows and columns. It was established that the employee data was stored in 300,025 rows and in 6 columns. 
  
* Next, it was necessary to determine whether PostgreSQL and pgAdmin were installed correctly on the machine to allow the creation of a database and manipulation of the data to progress. This was achieved by installing PostgreSQL and pgAdmin, followed by the creation of a database and importation of the CSV files in preparation for data wrangling. Checks were done to verify that the said data were imported by running the "SELECT* FROM table;" function. All the required data having been imported into PostgreSQL and pgAdmin, further inspections of the data were done as further steps towards performing the Pewlett Hackard(PH) analysis.  
  
<!--UL-->
### Initial analysis to test data before deep dive:

* This was achieved by utilizing the pseudocode method, which helps to facilitate the code scripting process by creating models or flowcharts for a high-level understanding and roadmap for the project. Hence an entity-relationship diagram (ERD) was created to highlight different tables and their relationships to each other, which captured the following pertinent information for each CSV file:
* Primary keys
* Foreign keys
* Data types for each column

The ERD also help to show the flow of information between tables, as shown in the figure below:

#### Figure 1: Entity Relationship Diagram (ERD)
![Entity Relationship Diagram](https://github.com/Brentnol/Pewlett-Hackard-Analysis-Challenge/blob/main/Data/ERD.png)
 
*  list of actions was written down. For example; Create a new table for retiring employees from Sales, open the data file, to create a new table to hold the information. Let's name it "retirement_titles, thus:

#### Pseudocode:
   * To add the code that will join these two tables;
   * To add a filter, using the WHERE keyword and the employees birth_date emp.emp_no ASC; 
   * To retrieve the number of employees by their most recent job title who are about to retire; 
   * To write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
  
1. Intitial CSV files imported into database:
   * department.csv
   * dept_emp.csv
   * dept_manager.csv
   * employees.csv
   * salaries.csv
   * titles
   
2. Combined tables to produce new CSV files:
   * menthorship_eligibility.csv
   * retirement_titles.csv
   * retiring_titles.csv
   * unique_titles.csv

<!--Links-->
1. Next,  [Stockoverflow](https://stackoverflow.com/questions/1164479/using-the-distinct-function-in-sql
"Using the distinct function in SQL") was consulted for assistance with a code on the use of the SQL DISTINCT ON  function.  

4.  Next,  [PostgreSQL Documentation](https://www.postgresql.org/docs/9.5/queries-union.html "Combining Queries") was consulted for assistance with general code string for combining queries.
  
## Deliverable 1: 
### Performing the analysis.
1.  A new table for retiring employees was created:
    * SELECT emp.emp_no,
    * emp.first_name,
    * emp.last_name,
    * ti.title,
    * ti.from_date,
    * ti.to_date
2. Next, we needed to create a new table to hold the information for retirement_titles":
    * INTO retirement_titles
3. Next step was to add the code that will join these two tables:  
    * FROM employees as emp
    * LEFT JOIN titles as ti
    * ON emp.emp_no = ti.emp_no
4. And finally, because this was a table of retiring employees titles, we needed to add a filter, using the WHERE keyword and the employees birth_date emp.emp_no ASC:
    * WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
    * ORDER BY emp.emp_no ASC;
    
5. We next used the Distinct with Order by to remove duplicate rows, thus:
    * SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title 
    * INTO unique_titles
    * FROM retirement_titles
    * WHERE to_date IN ('9999-01-01')
    * ORDER BY emp_no, to_date  DESC;

6. To retrieve the number of employees by their most recent job title who are about to retire we: 
    
    * SELECT COUNT (title), title 
    * INTO retiring_titles
    * FROM unique_titles
    * GROUP BY title
    * ORDER BY COUNT DESC
    
 <!--UL--> 
## DELIVERABLE # 2:
1. Wrote a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program:

    * SELECT DISTINCT ON (e.emp_no) e.emp_no,
    * e.first_name,
    * e.last_name,
    * e.birth_date,
    * de.from_date,
    * de.to_date,
    * ti.title
    * INTO mentorship_eligibilty
    * FROM employees as e
    * INNER JOIN dept_emp as de
    * ON (e.emp_no = de.emp_no)
    * INNER JOIN titles as ti
    * ON (e.emp_no = ti.emp_no)
    * WHERE (de.to_date = '9999-01-01')
    * AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
    * ORDER BY e.emp_no  ASC;

 <!--UL-->
 <!--Strong--> 
 <!--Images-->
### Results from queries:
#### Figure 2.: Retirement Titles
![retirement_titles](https://github.com/Brentnol/Pewlett-Hackard-Analysis-Challenge/blob/main/Queries/retirement_titles.png)

#### Figure 3.: Unique Titles
![unique_titles](https://github.com/Brentnol/Pewlett-Hackard-Analysis-Challenge/blob/main/Queries/unique_titles.png)

#### Figure 4.: Retiring Titles
![retiring_titles](https://github.com/Brentnol/Pewlett-Hackard-Analysis-Challenge/blob/main/Queries/retiring_titles.png)

#### Figure 5.: Mentorship Eligibility
![mentorship_eligibilty](https://github.com/Brentnol/Pewlett-Hackard-Analysis-Challenge/blob/main/Queries/unique_titles.png)

  
 <!--OL--> 
### Challenges and Solutions Encountered

1.  Learning and developing the various data wrangling queries and functions for the Pewlett Hackard Analysis, including the importing and exporting to and from the database, was challenging at first. Preparing and creating the various code and scripts to produce the resultant tables was a significant challenge for me at first. However, over time, I will grasp key concepts of these commands to deliver consistent and desired results.

2.  Stockoverflow and the PostgreSQL Documentation continued to be a fantastic resource with a considerable repertoire of codes and other valuable resources. Both resources were consulted extensively during this exercise. 

## Conclusions:
<!--OL-->
### Outcomes based on PostgreSQL and pgAdmin Analysis for the Pewlett Hackard Analysis:
1.  PostgreSQL and pgAdmin scripting was found to be a powerful data analytic tool in performing the Pewlett Hackard Analysis for the Pewlett Hackard Database Department. As can be seen from the results, we were able to accurately determine, by way of PostgreSQL and pgAdmin scripting,  the total number of employees' retirement titles, uniques titles, titles retiring, and more importantly, the number of employees that were eligible to enter the mentorship program. This allowed us to determine interesting facts about Pewlett Hackard; for example, we were able to establish that of the 133,776 retiring employees; more than 1500 hundred of them were eligible for the mentoring program. 


