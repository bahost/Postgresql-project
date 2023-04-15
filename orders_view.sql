create or replace view analysis.orders_v as
select 
	a.order_id as order_id
	, a.order_ts as order_ts
	, a.user_id as user_id
	, a.bonus_payment as bonus_payment
	, a.payment as payment
	, a.cost as cost
	, a.bonus_grant as bonus_grant
	, b.status_id as status
from orders as a
left join (select 
		order_id
		, status_id
		, row_number() over(partition by order_id order by dttm desc) as rn
	from production.OrderStatusLog
	  ) as b
on a.order_id = b.order_id
	and b.rn = 1
;
