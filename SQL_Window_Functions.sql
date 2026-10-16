CREATE TABLE employee(
	emp_id text primary key,
	emp_name varchar(20),
	department varchar(20),
	salary int,
	joining_year int
);

select * from employee;
-- Q1.Assign a row number to every employee based on salary, highest salary first.
SELECT 
	emp_name,
	salary,
	row_number() over(
		order by salary desc
	) as row_num 
from employee;
-- Q2. Rank all employees based on salary, highest salary first.
select 
	emp_name,
	salary,
	RANK() over(
		order by salary desc
	) as salary_rank
from employee;
-- Q3. Compare RANK() and DENSE_RANK().
select 
	emp_name,
	salary,
	rank() over(
		order by salary desc
	) as salary_rank,
	DENSE_RANK() OVER(
		order by salary desc
	) as salary_dense_rank
from employee;
-- Q4. Rank employees within each department based on salary.
select
	emp_name,
	department,
	salary,
rank() over(
	partition by department
	order by salary desc 
) as dept_rank
from employee;
-- Q5. Find the highest-paid employee in each department.
WITH ranked_employees as (
	select
		emp_name,
		department,
		salary,
	RANK() OVER(
		partition by department
		order by salary desc 
		) as dept_rank
	from employee
)
select
	emp_name,
	department,
	salary
from ranked_employees
where dept_rank = 1;
-- Q6. Show each employee's salary and the salary of the employee who joined immediately before them.
select 
	emp_name,
	joining_year,
	salary,
lag(salary) over(
	order by joining_year
) as previous_salary
from employee;
-- Q7. Show each employee's salary and the salary of the employee who joined immediately after them.
select
	emp_name,
	joining_year,
	salary,
lead(salary)over(
	order by joining_year
) as next_salary
from employee;
-- Q8. Calculate a running total of salaries based on joining year.
select
	emp_name,
	joining_year,
	salary,
sum(salary) over(
	order by joining_year 
)as running_salary
from employee;
-- Q9. Find the second-highest salary employee in each department.
with ranked_employees as (
	select
		department,
		emp_name,
		salary,
		dense_rank() over(
			partition by department
			order by salary desc
		) as salary_rank
		from employee
)
select
	department,
	emp_name,
	salary
from ranked_employees
where salary_rank=2;
-- Q10. Find the top 2 highest-paid employees from each department.
with ranked_employees as(
	select
		department,
		emp_name,
		salary,
		rank() over(
			partition by department
			order by salary desc
		) as salary_rank
		from employee
)
select
	department,
	emp_name,
	salary
from ranked_employees
where salary_rank <=2;