Create table orders(
	order_id text primary key,
	order_date date,
	customer varchar(20),
	city varchar(20),
	category varchar(20),
	product varchar(20),
	quantity int,
	unit_price int,
	payment_status varchar(20)
)
select * from orders;
-- Q1. Display all orders where payment status is Paid.
select * from orders
where payment_status='Paid';
-- Q2. Find total revenue.
select
 sum(quantity * unit_price) as total_revenue
from orders;
-- Q3. Find total revenue by category.
select 
	category,
	sum(quantity * unit_price) as total_revenue
from orders
group by category
order by total_revenue desc;
-- Q4. Find total quantity sold by product.
select
	product,
	sum(quantity) as total_quantity
from orders
group by product
order by total_quantity desc;
-- Q5. Find the top 5 customers by total revenue.
select 
	customer,
	sum(quantity * unit_price) as total_revenue
from orders
group by customer
order by total_revenue desc
limit 5;
-- Q6. Find the city generating the highest revenue.
select
	city,
	sum(quantity * unit_price) as highest_revenue
from orders
group by city
order by highest_revenue desc
limit 1;
-- Q7. Find customers whose total revenue is greater than the average customer revenue.
with customer_revenue as(
	select
		customer,
		sum(quantity * unit_price) as total_revenue
	from orders
	group by customer
)
select
	customer,
	total_revenue
from customer_revenue
where total_revenue >(
	 select avg(total_revenue)
	 from customer_revenue
);
-- Q8. Find the highest-selling product in each category.
with product_sales as(
select
	product,
	category,
	sum(quantity * unit_price) as total_revenue
	from orders
	group by category , product
),
ranked_product as(
select 
	product,
	category,
	total_revenue,
	dense_rank() over(
	partition by category
	order by total_revenue desc
	) as  product_rank
 from product_sales
)
select
	product,
	category,
	total_revenue
from ranked_product
where product_rank = 1;
-- Q9. Find the second-highest revenue-generating customer.
with customer_revenue as (
select 
 	customer,
	sum(quantity * unit_price) as total_revenue
	from orders
	group by customer
),
ranked_revenue as(
	select
		customer,
		total_revenue,
		dense_rank() over(
				order by total_revenue desc
		) as revenve_rank
		from customer_revenue
)
select
	customer,
	total_revenue
from ranked_revenue
where revenve_rank =2;
-- Q10. Rank customers by revenue within each city.
with customer_revenue as(
	select
		customer,
		city,
		sum(quantity * unit_price) as total_revenue
		from orders
		group by city , customer
),
ranked_revenue as(
	select
		customer,
		city,
		total_revenue,
		rank() over(
			partition by city
			order by total_revenue desc
		) as revenue_rank
		from customer_revenue
)
select
customer,
city,
total_revenue,
revenue_rank
from ranked_revenue;
-- Q11. Calculate each category's percentage contribution to total revenue.
select
	category,
	sum(quantity * unit_price) as category_revenue,
	round(
		(sum(quantity* unit_price)/sum(sum(quantity*unit_price)) over()) * 100,
		2
	) as percentage_contribution
from orders
group by category
order by percentage_contribution desc;
-- Q12. Find monthly revenue.
select
	date_trunc('month',order_date) as revenue_month,
	sum(quantity * unit_price) as monthly_revenue
from orders
group by 1
order by revenue_month;
-- Q13. Find running monthly revenue.
with monthly_rev as(
	select
		date_trunc('month',order_date) as revenue_month,
		sum(quantity*unit_price) as monthly_revenue
	from orders
	group by 1
)
select 
	revenue_month,
	monthly_revenue,
	sum(monthly_revenue) over(
	order by revenue_month
	) as running_monthly_revenue
from monthly_rev;
-- Q14. Compare each month's revenue with the previous month.
with montly_rev as(
	select
		date_trunc('month', order_date) as revenue_month,
		sum(quantity * unit_price) as monthly_revenue
		from orders
		group by 1
)
select
	revenue_month,
	monthly_revenue,
	lag(monthly_revenue) over(
		order by revenue_month
		) as revenue_difference,
	round(
		(monthly_revenue - LAG(monthly-revenue) over (order by revenue_month)) /
		lag(montly_revenue) over (order by revenue_month)) * 100,
		2
		) as mon_growth_percentage
from monthly_rev;	
--Q15. Create a final Customer Performance Report:
with customer_performance_report as(

)
-- customer
total_orders
total_quantity
total_revenue
customer_rank