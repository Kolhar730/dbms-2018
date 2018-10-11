CREATE TABLE cust_customer (cust_id number(4) not null,name varchar2(20) not null, date_of_payment date not null, name_of_scheme varchar(10) not null, status varchar(3) not null);
CREATE TABLE cust_fine (cust_id number(4) not null, cur_date date not null, amount number(5) not null);

select * from cust_customer;
select * from cust_fine;

-- Insert into cust_customer
INSERT INTO cust_customer (cust_id, name, date_of_payment, name_of_scheme, status) values (1, 'Sam K', '12-JUL-2018', '15 Days', 'NP');
INSERT INTO cust_customer (cust_id, name, date_of_payment, name_of_scheme, status) values (2, 'Dev B', '27-JUL-2018', '30 Days', 'P');
INSERT INTO cust_customer (cust_id, name, date_of_payment, name_of_scheme, status) values (3, 'Rajat S', '19-JUL-2018', '15 Days', 'NP');

-- DECLARE
--     today_date date;
--     input_from_user_id number;
--     input_from_user_name varchar2(10);
--     amount_cal number (5);
--     date_diff number(10);
--     ex_invalid_id  EXCEPTION; 
-- begin
--     today_date:=sysdate;
--     -- dbms_output.put_line(today_date);
--     amount_cal:=0;
--     -- ACCEPT x number prompt 'Please enter a Customer Id: ';
--     input_from_user_id:=:input_from_user_id;
--     -- ACCEPT y varchar2(10) prompt 'Please Enter the Name of Scheme: ';
--     input_from_user_name:=:input_from_user_name;
--     if input_from_user_id <= 0 then
--         RAISE ex_invalid_id;
--     else
--     for o in (select cust_id, name, date_of_payment, name_of_scheme, status from cust_customer)
--     loop
--         date_diff = today_date - o.date_of_payment;    
--         if date_diff > 15 and date_diff <= 30 then
--             amount_cal:=5*date_diff;
--             insert into cust_fine (cust_id, cur_date, amount) values (o.id, today_date, amount_cal);
--             update cust_customer set status = 'P' where cust_id:=o.id;
--         elsif date_diff > 30 then
--             amount:=50*(date_diff-30);
--             insert into cust_fine (cust_id, cur_date, amount) values (o.id, today_date, amount_cal);
--             update cust_customer set status = 'P' where cust_id:=o.id;
--         end if; 
--     end loop;
--     end if;
-- exception
--     when no_data_found then
--         dbms_output.put_line('No such customer!');
--     WHEN others THEN 
--         dbms_output.put_line('Unknown Error!');
-- end;
-- /

DECLARE
    today_date date;
    amount_cal number (5);
    date_diff number(10);
    ex_invalid_id  EXCEPTION; 
begin
    today_date:=sysdate;
    amount_cal:=0;
    for o in (select cust_id, name, date_of_payment, name_of_scheme, status from cust_customer)
    loop
        date_diff := today_date - o.date_of_payment;    
        if date_diff > 15 and date_diff <= 30 and o.status='NP' then
            amount_cal:=5*date_diff;
            insert into cust_fine (cust_id, cur_date, amount) values (o.cust_id, today_date, amount_cal);
            update cust_customer set status = 'P' where cust_id=o.cust_id;
        elsif date_diff > 30 and o.status='NP' then
            amount_cal:=50*(date_diff-30);
            insert into cust_fine (cust_id, cur_date, amount) values (o.cust_id, today_date, amount_cal);
            update cust_customer set status = 'P' where cust_id=o.cust_id;
        end if; 
    end loop;
exception
    when no_data_found then
        dbms_output.put_line('No such customer!');
    WHEN others THEN 
        dbms_output.put_line('Unknown Error!');
end;
/

update cust_customer set date_of_payment='12-JAN-2018' where cust_id=3;