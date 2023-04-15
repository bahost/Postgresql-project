insert into analysis.dm_rfm_segments
select f.user_id as user_id
	, f.frequency as frequency
	, m.monetary_value as monetary_value
	, r.recency as recency
from analysis.tmp_rfm_frequency as f
join analysis.tmp_rfm_monetary_value as m
	on f.user_id = m.user_id
join analysis.tmp_rfm_recency as r
	on f.user_id = r.user_id
;

0	3	4	1
1	3	3	4
2	3	5	2
3	4	3	2
4	3	3	4
5	5	5	5
6	3	5	1
7	2	2	4
8	1	3	1
9	2	2	1

