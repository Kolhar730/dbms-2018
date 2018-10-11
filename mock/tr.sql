create table mock_customer (cust_id number(2) primary key not null, name varchar2(20) not null, total_purchase number(6) not null);

create table mock_category (cust_id number(2) primary key not null, name varchar2(20) not null, class varchar2(20) not null);

insert into mock_customer(cust_id, name, total_purchase) values (1, 'Samir Nasri', 15000);
insert into mock_customer(cust_id, name, total_purchase) values (2, 'Cesc Fabregas', 3500);
insert into mock_customer(cust_id, name, total_purchase) values (3, 'David Silva', 3000);
insert into mock_customer(cust_id, name, total_purchase) values (4, 'Frank Lampard', 19000);
insert into mock_customer(cust_id, name, total_purchase) values (5, 'Steven Gerrard', 8000);

select * from mock_customer;
select * from mock_category;

update mock_customer set total_purchase=3500 where cust_id=2;


create or replace procedure mock_proc_grade 
is
begin
	for cust in (select cust_id, name, total_purchase from mock_customer)
	loop
		if cust.total_purchase <= 20000 AND cust.total_purchase >=10000 then
			insert into mock_category(cust_id, name, class) values (cust.cust_id, cust.name, 'Platinum');
		elsif cust.total_purchase <= 9999 AND cust.total_purchase >= 5000 then
			insert into mock_category(cust_id, name, class) values (cust.cust_id, cust.name, 'Gold');
		elsif cust.total_purchase <= 4999 AND cust.total_purchase >= 2000 then
			insert into mock_category(cust_id, name, class) values (cust.cust_id, cust.name, 'Silver');
		end if;
	end loop;
end mock_proc_grade;
