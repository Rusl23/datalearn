--- sales dynamic 
with rev_dynamic as
(
select
to_char(date_trunc('year', o.order_date), 'YYYY') as "Year",
to_char(date_trunc('month', o.order_date), 'Month') as "Month",
to_char(date_trunc('month', o.order_date), 'MM') as "Month sort",
sum(o.sales) as "Income"
from orders o
group by to_char(date_trunc('year', o.order_date), 'YYYY'),
	to_char(date_trunc('month', o.order_date), 'Month'),
	to_char(date_trunc('month', o.order_date), 'MM')
order by to_char(date_trunc('year', o.order_date), 'YYYY'),
	to_char(date_trunc('month', o.order_date), 'MM')
)
select 
"Year",
"Month",
"Income"
from rev_dynamic;

--- category sales
select
o.subcategory,
round(sum(o.sales)) as "Income",
round(sum(o.profit)) as "Profit"
from orders o
group by o.subcategory
order by sum(o.sales) desc;

--- managers KPIs
select
p.person as "Manager",
round(sum(o.sales)) as "Income",
round(sum(o.profit)) as "Profit",
sum(o.quantity) as "Quantity"
from orders o
	left join people p on o.region = p.region
group by p.person
order by sum(o.sales) desc
