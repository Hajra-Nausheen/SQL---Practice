-- 3.customers
create table customers(
	customer_id text primary key,
	customer_name varchar (20),
	city varchar (20),
	state varchar(20)
);
-- 4.orders
create table orders(
	order_id text primary key,
	customer_id text,
	foreign key (customer_id)
	references customers(customer_id),
	product_id text,
	foreign key (product_id)
	references products(product_id),
	order_date date,
	quantity int
);
-- 2.products
create table products(
	product_id text primary key,
	product_name text,
	category_id text,
	foreign key (category_id)
	references categories(category_id),
	price int
);
-- 1.categories
create table categories(
	category_id text primary key,
	category_name varchar(20)
);
-- 5.payments
create table payments(
	payment_id text primary key,
	order_id text,
	foreign key (order_id)
	references orders(order_id),
	payment_method text,
	payment_status text,
	amount int
);

alter TABLE orders
drop column order_date;

-- INNER JOIN
-- Q1
SELECT
c.customer_name,
o.order_id,
o.quantity
from customers c
inner join orders o
	on c.customer_id=o.customer_id;
select * from customers;
select * from orders;

-- Q2
select
o.order_id,
o.quantity,
p.product_name,
p.price
from orders o
inner join products p
	on o.product_id=p.product_id;
	
-- Q3
SELECT
p.product_name,
p.price,
c.category_name
from products p
inner join categories c
	on p.category_id=c.category_id;
	
-- Q4
select 
o.customer_id,
c.customer_name
from customers c
left join orders o
	on o.customer_id=c.customer_id
where o.customer_id is null	;
-- Q5
select
o.product_id,
p.product_name
from products p
left join orders o
	on o.product_id=p.product_id
where o.product_id is null;
-- Q6
select
c.customer_name,
o.order_id,
o.quantity
from customers c
left join orders o
	on c.customer_id=o.customer_id;
-- Q7
select 
c.customer_name,
o.order_id,
p.product_name,
ca.category_name,
o.quantity,
p.price
from customers c
join orders o
	on c.customer_id=o.customer_id
join products p
	on o.product_id=p.product_id
join categories ca
	on p.category_id=ca.category_id;

-- Q8
select
c.customer_name,
o.order_id,
p.payment_method,
p.payment_status,
p.amount
from customers c
join orders o
	on c.customer_id=o.customer_id
join payments p
	on o.order_id=p.order_id;

-- Q9
select
c.customer_name,
o.order_id,
p.payment_method,
p.amount
from customers c
join orders o
	on c.customer_id=o.customer_id
join payments p
	on o.order_id=p.order_id
where payment_status = 'Paid';	

-- Q10
select 
c.customer_name,
sum(p.amount) as total_spending
from customers c
join orders o
	on c.customer_id=o.customer_id
join payments p
	on o.order_id=p.order_id
where p.payment_status='Paid'
group by c.customer_name
order by total_spending;

-- Q11
select
c.customer_name,
sum(o.quantity * p.price) as total_spending
from customers c
join orders o
	on c.customer_id=o.customer_id
join products p
	on o.product_id=p.product_id
group by c.customer_name
order by total_spending desc
limit 1;	
select * from orders;
select * from products;

-- Q12
select
c.category_name,
sum(o.quantity * p.price) as total_revenue
from categories c
join products p
	on c.category_id=p.category_id
join orders o
	on o.product_id=p.product_id
group by c.category_name
order by total_revenue desc;
	
-- Q13
select
c.customer_name,
o.order_id,
p.payment_status
from customers c
join orders o
	on c.customer_id=o.customer_id
join payments p
	on o.order_id=p.order_id
where p.payment_status ='Pending' or 
p.payment_status='Failed';	

-- Q14
select 
c.customer_name,
o.order_id,
p.payment_status
from customers c
left join orders o
	on c.customer_id=o.customer_id
join payments p
	on o.order_id=p.order_id;
-- Q15
select 
c.category_name,
sum(o.quantity * p.price) as highest_total_revenue
from categories c
join products p
	on c.category_id=p.category_id
join orders o
	on p.product_id=o.product_id
group by c.category_name
order by highest_total_revenue desc;

-- Q16 
select
c.customer_id,
p.product_name,
ca.category_name,
o.quantity,
py.payment_status
from customers c
join orders o
	on c.customer_id=o.customer_id
join products p
	on o.product_id=p.product_id
join payments py
	on o.order_id=py.order_id
join categories ca
	on p.category_id=ca.category_id
where o.order_id is not null;	
	