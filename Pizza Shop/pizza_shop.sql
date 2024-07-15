create database pizza;
use pizza;
drop table orders;
drop table order_details;
create table orders (
order_id int primary key,
`date` date,
`time` time 
);

create table order_details(
order_details_id int primary key,
order_id int,
pizza_id varchar(700),
quantity int
);
select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;

 select count(distinct(order_id)) as "Total no.of pizzas ordered"
 from orders;
 
 select  round(sum(quantity*price),2) as "Total"
 from order_details
 join pizzas on pizzas.pizza_id = order_details.pizza_id ;
 
 select pizza_id as "Highest priced pizza",price
 from pizzas
 order by price desc
 limit  1;
 
 
select count(quantity),size
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by size;

select `name`, count(quantity)
from order_details
join pizzas 
on order_details.pizza_id = pizzas.pizza_id
join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by `name`
limit 5;
 
 
 select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;


select category,count(quantity)
from order_details
join pizzas 
on order_details.pizza_id = pizzas.pizza_id
join pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by category;


select hour(`time`) as "day-hours",count(order_id) as "orders-count"
from orders
group by hour(`time`)
order by hour(`time`) asc;

select count(name), category
from pizza_types
group by category;

select (`date`) as "day of the month",count(quantity) as "no of pizzas ordered"
from orders
join order_details
on order_details.order_id = orders.order_id
group by `date`;

select round(avg(no_of_pizzas_ordered),2) as "avg pizzas ordered"
from 
    (select (`date`) as "day of the month",sum (quantity) as "no_of_pizzas_ordered"
	from orders
	join order_details
	on order_details.order_id = orders.order_id
	group by `date`) as order_quantity ;


select `name`, sum(price*quantity) as "revenue"
from order_details
join pizzas 
on order_details.pizza_id = pizzas.pizza_id
join pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by `name`
order by revenue desc
limit 3;



select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;

select `category`,
(sum(quantity*price) / (select round(sum(quantity*price),2) 
	from order_details
	join pizzas
	on order_details.pizza_id = pizzas.pizza_id)) * 100 as revenue
from order_details
join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by `category`;
    

select `date`, 
	sum(revenue) over(order by `date`) as cum_sum
from	(select `date`,sum(quantity*price) as revenue
		from  orders
		join order_details
		on orders.order_id = order_details.order_id
		join pizzas 
		on pizzas.pizza_id = order_details.pizza_id
		group by `date`) as gg;
    
    
select category,`name`,revenue
from
	(select category,`name`, round(sum(price*quantity),2) as revenue,
		rank() over(partition by category order by round(sum(price*quantity),2)desc) as ln 
	from 
		order_details
	join pizzas
	on pizzas.pizza_id = order_details.pizza_id
	join pizza_types
	on pizza_types.pizza_type_id = pizzas.pizza_type_id
	group by category,`name` ) as gg
where ln <= 3;
    
