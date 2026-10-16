-- CTE
CREATE TABLE sales (
    sale_id TEXT PRIMARY KEY,
    customer TEXT,
    product TEXT,
    region TEXT,
    quantity INT,
    amount INT
);
-- Q1 Calculate total sales amount for each customer.
with customer_sales as(
	select
		customer,
		sum(amount) as total_sales
	from sales
	group by customer
)
select
	customer,
	total_sales
from customer_sales;
-- Q2 Find customers whose total sales are greater than ₹50,000. 
WITH customer_sales as(
	select
		customer,
		sum(amount) as total_sales
	from sales
	group by customer
)
select 
	customer
from customer_sales
where total_sales > 50000;
-- Q3 Find the average sales amount for each region.
with avg_sales as(
	select
		region,
		avg(amount) as avg_region_sales
	from sales
	group by region
)
select
	region,
	avg_region_sales
from avg_sales;	
-- Q4 Find products whose total sales amount is greater than ₹20,000.
with total_sales as(
	select 
		product,
		sum(amount) as total_sales_amount
	from sales
	group by product
)
select
	product,
	total_sales_amount
from total_sales
where total_sales_amount > 20000;
-- Q5 Find the region with the highest total sales.
with total_sales as(
	select
		region,
		sum(amount) as highest_total_sales
		from sales
		group by region
)
select
	region,
	highest_total_sales
from total_sales
order by highest_total_sales
limit 1;
-- Q6 Find customers whose total sales are greater than the average customer
with customer_sales as (
	select
		customer,
		sum(amount) as total_sales
	from sales
	group by customer
),
avg_customer_sales as(
	select
		avg(total_sales) as avg_sales
	from customer_sales
)
select 
	cs.customer,
	cs.total_sales
from customer_sales cs
cross join avg_customer_sales acs
where cs.total_sales > acs.avg_sales;
-- Q7 Find the highest-selling product in each region.
with total_sales as (
	select
		region,
		sum(product) as highest_selling_product
	from sales
	group by region
)
select
	region,
	highest_selling_product
from total_sales
limit 1;
-- Q8 Find customers who purchased more than 2 units in total.
with customer_quantity as (
	select
		customer,
		sum(quantity) as total_quantity
	from sales
	group by customer
)
select
	customer,
	total_quantity
from customer_quantity
where total_quantity > 2;
-- Q9 Find the customer who generated the highest revenue.
with total_revenue as (
	select
		customer,
		sum(amount) as highest_revenue
	from sales
	group by customer
)
select
	customer
from total_revenue
order by highest_revenue desc
limit 1 ;
-- Q10 Create a customer performance report.
with customer_report as(
	select
		customer,
		sum(amount) as total_sales,
		sum(quantity) as total_quantity,
		avg(amount) as avg_sales
	from sales
	group by customer
)
select
	customer,
	total_sales,
	total_quantity,
	avg_sales
from customer_report;
	