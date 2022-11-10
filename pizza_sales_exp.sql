  -- Data Exploration

-- Data type changes in orders table
Alter TABLE pizza_sales.orders modify COLUMN date date;
Alter TABLE pizza_sales.orders modify COLUMN time time;
SHOW FIELDS FROM pizza_sales.orders;

-- I). Lets answer the simple questions with our data :-
-- 1. Lets start with looking at the column of each table:
-- For orders table
select *
from pizza_sales.orders;

-- For order_detais table
select *
from pizza_sales.order_details;

-- For pizza_types:
select *
from pizza_sales.pizza_types;

-- For pizzas table:
select *
from pizza_sales.pizzas;

-- 2. Duration included in the data:
select max(date) as recent_purchase, min(date) as first_purchase
from pizza_sales.orders;
-- The data have purchase related info for the year 2015

-- 3. Number of orders in this dataset
select count(order_id) as "total customers"
from pizza_sales.orders;
-- 21350 orders in total.

-- 4. Quantity ordered by customers
select distinct quantity
from pizza_sales.order_details;
-- 4 is the max quantity ordered by customers

-- 5. Different types of pizza served:
select count(distinct name) types_served
from pizza_sales.pizza_types;

select distinct category
from pizza_sales.pizza_types;

-- 6. Different sizes and prices available
select distinct size
from pizza_sales.pizzas;
-- Total 5 sizes are available.

select max(price) as highest_price, min(price) as lowest_price
from pizza_sales.pizzas;
-- The costliest pizza is of approx $36 and affordable pizza is of approx $10.

 -- II). Lets look explore data in more detail using joins:-
 -- 1. Lets look at the name and size of costliest and lowest price pizza:
 
select name, size ,max(high_price) 
from (select distinct name, size, max(price) as high_price
from pizza_sales.pizza_types pt
right join pizza_sales.pizzas p
on pt.pizza_type_id = p.pizza_type_id
group by 1,2
order by 3 desc) hp;
-- The Greek Pizza of size XXL is the costliest with approx price of $36

select name, size, min(low_price) as lowest_price_pizza
from(select distinct name, size, min(price) as low_price
from pizza_sales.pizza_types pt
right join pizza_sales.pizzas p
on pt.pizza_type_id = p.pizza_type_id
group by 1,2
order by 3) lp; 
-- The Pepperoni Pizza of size S is of lowest price of approx $9.75

 -- 2. Most purchased pizza
 select name, sum(quantity) as most_ordered
 from pizza_sales.order_details o
 left join pizza_sales.pizzas p
 on o.pizza_id = p.pizza_id
 left join pizza_sales.pizza_types pt
 on p.pizza_type_id = pt.pizza_type_id
 group by 1
 order by 2 desc;
 -- The most purchased pizza is The Classic Deluxe Pizza with total of 2453 orders.
 -- The Brie pizza is not so favoured choice with only 490 orders for the year 2015.
 
 -- 3. Days when the most purhases & least purchases occurred
 select date, sum(od.quantity) as orders_count
 from pizza_sales.order_details od
 join pizza_sales.orders o
 on od.order_id = o.order_id
 group by 1
 order by 2 desc;
 -- Largest orders: 266 orders were placed on 26 November 2015
 -- Lowest orders: 77 orders were placed on 30 December 2015
 
 -- 4. Peak time to order pizza
with peak_time as
	(select order_id, date, time, Case when time between '5:00:00.001' and '12:00:00.000' then 'Morning' 
					when time between '12:00:00.001' and '17:00:00.000' then 'Afternoon' 
					when time between '17:00:00.001' and '22:00:00.000' then 'Evening' 
					else 'Night' end time_period
	from pizza_sales.orders)
select peak_time.time_period, count(peak_time.time_period) as order_slot
from peak_time 
group by 1
order by 2 desc;
-- Most orders were made during afternoon (12:01 pm - 5:00 pm) and evening (5:01 pm - 8:00 pm).

 -- 5. Pizza ordered on weeken vs weekdays
 with week_day as
	(select order_id, date, dayname(date) day_name
	from pizza_sales.orders)
select week_day.day_name, count(week_day.day_name) as week_order
from week_day
group by 1
order by 2 desc;
-- Most orders are placed on Frday's and Thursday's.