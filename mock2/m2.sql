CREATE TABLE customer_lib (cust_id number(2) not null primary key, cust_name varchar2(20) not null, dateOfPayment date not null, nameOfScheme varchar2 (10) not null, status varchar2(1) not null);

create table fine_lib(cust_id number(2) not null primary key, cust_name varchar2(20) not null, fine_amount number(5) not null);

insert into customer_lib (cust_id, cust_name, dateOfPayment, nameOfScheme , status) values (1, 'Mr. Some Name', '30-SEP-2018', 'Scheme#1', 'P');
insert into customer_lib (cust_id, cust_name, dateOfPayment, nameOfScheme , status) values (2, 'Mr. First Name', '13-JUN-2018', 'Scheme#2', 'N');
insert into customer_lib (cust_id, cust_name, dateOfPayment, nameOfScheme , status) values (3, 'Mr. Last Name', '11-SEP-2018', 'Scheme#3', 'N');
insert into customer_lib (cust_id, cust_name, dateOfPayment, nameOfScheme , status) values (4, 'Mr. Name', '03-OCT-2018', 'Scheme#4', 'N');
insert into customer_lib (cust_id, cust_name, dateOfPayment, nameOfScheme , status) values (5, 'Mr. No Name', '30-MAR-2018', 'Scheme#5', 'P');

update customer_lib set dateOfPayment='03-JUL-2018' where cust_id = 2;
update customer_lib set dateOfPayment='20-JAN-2018' where cust_id = 3;
update customer_lib set dateOfPayment='03-OCT-2018' where cust_id = 4;

update customer_lib set status='N' where cust_id = 2;
update customer_lib set status='N' where cust_id = 3;
update customer_lib set status='N' where cust_id = 4;

select * from customer_lib;
select * from fine_lib;

truncate table fine_lib;

MySQL [te3166db]> describe customer_lib;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| cust_id       | smallint(6) | NO   | PRI | NULL    |       |
| cust_name     | varchar(20) | NO   |     | NULL    |       |
| dateOfPayment | date        | NO   |     | NULL    |       |
| nameOfScheme  | varchar(10) | NO   |     | NULL    |       |
| status        | varchar(1)  | NO   |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

MySQL [te3166db]> describe fine_lib;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| cust_id     | smallint(6) | NO   | PRI | NULL    |       |
| cust_name   | varchar(20) | NO   |     | NULL    |       |
| fine_amount | bigint(20)  | NO   |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

DECLARE
    today_date date;
    amount_cal number (5);
    date_diff number(10);
    invalid_id  EXCEPTION;
    
begin
    	today_date:=sysdate;
  	amount_cal:=0;
   	
	for obj in (select cust_id, cust_name, dateOfPayment, nameOfScheme, status from customer_lib)  
   	loop
   		date_diff:=today_date - obj.dateOfPayment;
		if date_diff < 30 and obj.status = 'N' then
   			amount_cal:=5*date_diff;
   			insert into fine_lib(cust_id, cust_name, fine_amount) values (obj.cust_id, obj.cust_name, amount_cal);
   			update customer_lib set status='P' where cust_id = obj.cust_id;
   			amount_cal:=0; 
   		elsif date_diff > 30 and obj.status = 'N' then
   			amount_cal:=50*date_diff;
   			insert into fine_lib(cust_id, cust_name, fine_amount) values (obj.cust_id, obj.cust_name, amount_cal);
   			update customer_lib set status='P' where cust_id = obj.cust_id;
   			amount_cal:=0;
 		end if;      
   	end loop;
exception
  	when others then
  	dbms_output.put_line('Unknown Error');
end;
/
