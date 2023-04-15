-------------------------------------------------- FREQUENCY
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
	, count(order_id) as order_cnt
from analysis.orders_v as a
join analysis.orderstatuses_v as b
 on a.status = b.id
where 1=1
	and b.key = 'Closed'
group by user_id
;

-- frequency distribution
insert into analysis.tmp_rfm_frequency
select 
	a.user_id as user_id
	, ntile(5) over(order by coalesce(order_cnt,0)) as frequency
from uid as a
left join uord as b
	on a.user_id = b.user_id
;


