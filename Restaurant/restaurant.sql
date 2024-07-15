create database restaurant;
use restaurant;

create table sales(
customer_id char,
order_date date,
product_id int );

create table members(
customer_id char,
join_date timestamp
);

create table menu(
product_id int,
product_name varchar(5),
price int
);

insert into sales (customer_id,order_date,product_id) values ("A",'2021-01-01',1);
insert into sales values ("A",'2021-01-01',2);
insert into sales values ("A",'2021-01-07',2);
insert into sales values ("A",'2021-01-10',3);
insert into sales values ("A",'2021-01-11',3);
insert into sales values ("A",'2021-01-11',3);
insert into sales values ("B",'2021-01-01',2);
insert into sales values ("B",'2021-01-02',2);
insert into sales values ("B",'2021-01-04',1);
insert into sales values ("B",'2021-01-11',1);
insert into sales values ("B",'2021-01-16',3);
insert into sales values ("B",'2021-02-01',3);
insert into sales values ("C",'2021-01-01',3);
insert into sales values ("C",'2021-01-01',3);
insert into sales values ("C",'2021-01-07',3);

select * from sales;

insert into menu values (1,"sushi",10);
insert into menu values (2,"curry",15);
insert into menu values (3,"ramen",12);

select * from menu;

insert into members values ("A",'2021-01-07');
insert into members values ("B",'2021-01-09');

select * from members;

alter table members 
modify join_date date;


-- 01. What is the total amount each customer spent at the restaurant?
select customer_id,sum(price) as "Total spent"
from sales 
join menu
on sales.product_id = menu.product_id
group by customer_id;


-- 02.How many days has each customer visited the restaurant?
select customer_id, count(distinct(order_date)) as "No.of Days visited"
from sales
group by customer_id;


-- 03.What was the first item from the menu purchased by each customer?
select customer_id,First_Item
from (
		select customer_id,order_date,product_name as "First_Item",
		dense_rank() over(partition by customer_id order by order_date) as "rank"
		from sales 
		join menu 
		on sales.product_id = menu.product_id	) as pd
where ln = 1 ;


-- 04.What is the most purchased item on the menu and how many times was it purchased by all customers?
select product_name,count(customer_id) as "No.of times purchased"
from menu
join sales 
on menu.product_id = sales.product_id
group by product_name
order by count(customer_id) desc
limit 1;


-- 05.Which item was the most popular for each customer?
select customer_id,product_name
from
	(select customer_id,product_name,count(product_name),
	rank() over(partition by customer_id order by count(product_name)desc) as "rank"
	from sales
	join menu 
	on menu.product_id = sales.product_id
	group by customer_id,product_name) 		as pd
where `rank` = 1;


-- 06.Which item was purchased first by the customer after they became a member?
select customer_id,product_name
from 
	(select members.customer_id,product_name,order_date,
	rank() over(partition by members.customer_id order by order_date ) as "rank" 
	from sales
	join menu 
	on menu.product_id = sales.product_id
	join members
	on sales.customer_id = members.customer_id
	where order_date > join_date ) 	as pd
where `rank` = 1;


-- 07.Which item was purchased just before the customer became a member?
select customer_id,product_name
from	
	(select members.customer_id,order_date,product_name,
	rank() over(partition by members.customer_id order by order_date desc ) as "Rank"
	from sales
	join menu 
	on menu.product_id = sales.product_id
	join members
	on sales.customer_id = members.customer_id
	where order_date < join_date)	 as pd 
where `rank` = 1;


-- 08.What is the total items and amount spent for each member before they became a member?
select sales.customer_id,count(sales.product_id) as "Total Items Brought",sum(price) as "Total Spent"
from sales
join menu 
on menu.product_id = sales.product_id
join members
on sales.customer_id = members.customer_id
where order_date < join_date
group by customer_id;


/* 09.If each $1 spent equates to 10 points and sushi has a 2x points
multiplier - how many points would each customer have? */
select customer_id, sum(Total_Points) as "Total Points Gained"
from
	(select customer_id,product_name,
		sum(
			case 
			when product_name = "sushi" then price*2*10 
			else price*10
			end
		)as "Total_Points"
	from sales
	join menu 
	on menu.product_id = sales.product_id
	group by customer_id,product_name) as pd
group by customer_id;


/* 10.In the first week after a customer joins the program (including their
join date) they earn 2x points on all items, not just sushi - how many
points do customer A and B have at the end of January?*/
select members.customer_id,
sum( 
	if (order_date between join_date and date_add(join_date,interval 7 Day),price*2*10,price ) 
	)as points
from sales 
join members
on members.customer_id = sales.customer_id
join menu 
on menu.product_id = sales.product_id
where join_date < order_date and order_date < '2021-02-01'
group by customer_id
order by points desc;
