-- create database pizza_sales;
-- select * from pizza_sales.orders
-- select str_to_date(date,'%Y-%m-%d') as dates from pizza_sales.orders
-- select Time(time) as times  from pizza_sales.orders
-- Select * from pizza_sales.pizza_types
-- Select * from pizza_sales.pizzas
-- Select * from pizza_sales.order_details

-- Data Cleaning 
-- 1. Order_details table

-- 1.1 Looking for duplicate rows:
select *
from pizza_sales.order_details
group by order_details_id
having count(order_details_id)>1

-- 1.2 Looking for Null values or blank cells
SELECT *
FROM pizza_sales.order_details 
WHERE order_details_id IS NULL or " "
AND order_id IS NULL or " "
AND pizza_id IS NULL and quantity IS NULL or " "

-- 2.Orders
-- 2.1 Looking for duplicates
select *
from pizza_sales.orders
group by order_id
having count(order_id)>1

-- 2.2 Looking for blank cells or Null values:
select *
from pizza_sales.orders
where order_id Is Null or " " 
and date Is Null or " " 
and time Is Null or " "

-- 3. pizza_type:
-- 3.1 Looking for duplicates:
select *
from pizza_sales.pizza_types
group by pizza_type_id
having count(pizza_type_id) >1

-- 3.2 Looking for blanck cells or null values:
select *
from pizza_sales.pizza_types
where pizza_type_id Is Null or " " 
and name Is Null or " " 
and category Is Null or " "
and ingredients Is Null or " "

-- 4 pizzas
-- 4.1 Looking for duplicates:
select *
from pizza_sales.pizzas
group by pizza_id
having count(pizza_id) >1

-- 4.2 Looking for Null values or blank cells:
select *
from pizza_sales.pizzas
where pizza_type_id Is Null or " " 
and pizza_id Is Null or " " 
and size Is Null or " "
and price Is Null or " "

-- All Tables donot have any duplicates or blank cells or null values.






