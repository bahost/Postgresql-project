
Проверки:

production.orderitems:
1. Значения поля Price всегда больше значения поля discount 
2. Значений null нет
3. В DDL использованы GENERATED идентификатор, NOT NULL ограничения, DEFAULT значения price, дополнительные проверки CONSTRAINT на discount<price  и PRIMARY KEY

production.orders:
1. bonus_payment всегда >= 0
2. Payment всегда > 0
3. cost всегда > 0
4. bonus_grant всегда > 0
5. user_id всегда >= 0
6. Status имеет всего 2 значения: 4 и 5
7. Значений null нет
8. CONSTRAINT orders_check CHECK ((cost = (payment + bonus_payment))),
9. CONSTRAINT orders_pkey PRIMARY KEY (order_id)

production.orderstatuses:
1. Справочник, замечаний нет
2. Значений null нет
3. CONSTRAINT orderstatuses_pkey PRIMARY KEY (id)

production.orderstatuslog:
1. Минимальная дата 2022-02-12 00:58:42.000
2. Максимальная дата 2022-03-14 02:38:26.000
3. Значений null нет
4. Status значения от 1 до 5
5. CONSTRAINT orderstatuslog_order_id_status_id_key UNIQUE (order_id, status_id),
6. CONSTRAINT orderstatuslog_pkey PRIMARY KEY (id)
7. FOREIGN KEY (order_id) REFERENCES production.orders(order_id) для того, чтобы в таблице существовали order_id, которые есть только в таблице production.orders
8. FOREIGN KEY (status_id) REFERENCES production.orderstatuses(id) аналогично п.7

