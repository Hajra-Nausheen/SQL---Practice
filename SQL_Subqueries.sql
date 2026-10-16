create table departments(
	department_id varchar(20) primary key,
	department_name varchar(20)
);
CREATE TABLE employees(
	emp_id text primary key,
	emp_name varchar(20),
	department_id varchar(20),
	foreign key (department_id)
	references departments(department_id),
	salary INT,
	experience int
);
SELECT 
AVG(salary) from employees;
-- Q1
select 
	emp_name,salary
from employees 
where salary >(
	SELECT 
	AVG(salary) from employees
);
-- Q2
select
	emp_name,salary
from employees
where salary =(
	select 
	max(salary) from employees
);

-- Q3
select salary
from employees
where emp_name ='Rahul';
select
	emp_name,salary
from employees 
where salary >(
	select salary
from employees
where emp_name ='Rahul'
);

-- Q4
select
	e.emp_name,
	d.department_name
from employees as e
join departments as d
	on e.department_id=d.department_id
where emp_name='Aisha';	
select
	emp_name,department_id
from employees 
where department_id in(
select department_id
from departments	
where department_name='Sales'
);

-- Q5
select
emp_name
from employees 
where salary > 70000;
select
emp_name,
department_id,
salary
from employees
where salary in (
select
	salary
from employees 
where salary > 70000
);

-- Q6
select 
	d.department_name,
	e.emp_name
from employees e
join departments d
	on d.department_id=e.department_id
where salary < 80000;
select 
	d.department_name,
	e.salary
from departments d
join employees e
	on d.department_id=e.department_id
where salary not in (
select 
salary from employees
where salary < 80000
);	

-- Q7
select 
d.department_name,
avg(e.salary) as avg_dept_salary
from departments d
join employees e
	on d.department_id=e.department_id
group by department_name
order by avg_dept_salary desc; 
select 
emp_name,
department_id,
salary
from employees e1
where salary >(
select
avg(e2.salary) 
from employees e2
where e2.department_id=e1.department_id	
);