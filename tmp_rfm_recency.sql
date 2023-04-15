-------------------------------------------------- RECENCY
-- clients
drop table if exists uid;
create temp table uid as
select distinct id as user_id
from analysis.users_v
;

-- orders
drop table if exists uord;
create temp table uord as
select 
	user_id
	, max(order_ts) as last_order_dt
from analysis.orders_v as a
join analysis.orderstatuses_v as b
 on a.status = b.id
where 1=1
	and b.key = 'Closed'
group by user_id
;

-- recency distribution
insert into analysis.tmp_rfm_recency 
select 
	a.user_id as user_id
	, case
		when row_number() over(order by b.last_order_dt asc) between count(a.user_id) over()/5 + 1 and count(a.user_id) over()/5 * 2 then 2
		when row_number() over(order by b.last_order_dt asc) between count(a.user_id) over()/5 * 2 + 1 and count(a.user_id) over()/5 * 3 then 3    
		when row_number() over(order by b.last_order_dt asc) between count(a.user_id) over()/5 * 3 + 1 and count(a.user_id) over()/5 * 4 then 4
		when row_number() over(order by b.last_order_dt asc) between count(a.user_id) over()/5 * 4 + 1 and count(a.user_id) over()/5 * 5 then 5
		else 1
	end as recency
from uid as a
left join uord as b
	on a.user_id = b.user_id
;
