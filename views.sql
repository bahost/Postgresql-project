-------------------------------------------------- create views
create view analysis.orderitems_v as
select * from production.orderitems
;
create view analysis.orders_v as
select * from production.orders
;
create view analysis.orderstatuses_v as
select * from production.orderstatuses
;
create view analysis.orderstatuslog_v as
select * from production.orderstatuslog
;
create view analysis.products_v as
select * from production.products
;
create view analysis.users_v as
select * from production.users
;
