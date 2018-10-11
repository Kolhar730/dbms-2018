CREATE TABLE customers(customer_id number(10) NOT NULL, customer_name varchar2(50) NOT NULL, total_purchase number(6) NOT NULL);
CREATE TABLE cust_category(customer_id number(10) NOT NULL, customer_name varchar2(50) NOT NULL, cust_class varchar2(20) NOT NULL);

INSERT INTO customers (customer_id, customer_name, total_purchase) values (1, 'DEV', 19900);
INSERT INTO customers (customer_id, customer_name, total_purchase) values (2, 'VED', 17000);
INSERT INTO customers (customer_id, customer_name, total_purchase) values (3, 'RAM', 18700);
INSERT INTO customers (customer_id, customer_name, total_purchase) values (4, 'TOM', 1900);
INSERT INTO customers (customer_id, customer_name, total_purchase) values (5, 'LUCY', 30000);

SELECT * FROM customers;

update customers set total_purchase=12000 where customer_id=5;

CREATE OR REPLACE PROCEDURE proc_grade 
is
begin
for cust in (select customer_id, customer_name, total_purchase from customers)
    loop
        if cust.total_purchase<=20000 and cust.total_purchase>=10000 then
            insert into cust_category (customer_id, customer_name, cust_class) values (cust.customer_id, cust.customer_name, 'Platinum');
        elsif cust.total_purchase<10000 and cust.total_purchase>=5000 then
            insert into cust_category (customer_id, customer_name, cust_class) values (cust.customer_id, cust.customer_name, 'Gold');
        else
            insert into cust_category (customer_id, customer_name, cust_class) values (cust.customer_id, cust.customer_name, 'Silver');
        end if;
    end loop;
end proc_grade;
/

execute proc_grade;

select * from cust_category;