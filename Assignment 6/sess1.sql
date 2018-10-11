CREATE TABLE emp_table1(emp_id number(10) not null, emp_name varchar2(30) not null);
CREATE TABLE emp_table2(emp_id number(10) not null, emp_name varchar2(30) not null);

insert into emp_table1 (emp_id, emp_name) values (1, 'RAM');
insert into emp_table1 (emp_id, emp_name) values (2, 'MARS');
insert into emp_table1 (emp_id, emp_name) values (3, 'SAM');

insert into emp_table2 (emp_id, emp_name) values (4, 'MARS');
insert into emp_table2 (emp_id, emp_name) values (6, 'SER');
insert into emp_table2 (emp_id, emp_name) values (7, 'PICO');

select * from emp_table1;
select * from emp_table2;

-- Cursor definition

DECLARE
  cursor c(no number) is select * from emp_information
  where emp_no = no;
  tmp emp_information%rowtype;
BEGIN 
  OPEN c(4);
  FOR tmp IN c(4) LOOP
  dbms_output.put_line('EMP_No:    '||tmp.emp_no);
  dbms_output.put_line('EMP_Name:  '||tmp.emp_name);
  dbms_output.put_line('EMP_Dept:  '||tmp.emp_dept);
  dbms_output.put_line('EMP_Salary:'||tmp.emp_salary);      
  END Loop;
CLOSE c;
END;  
/

-- SECOND TYPE


DECLARE
    my_record emp%ROWTYPE;
    CURSOR c1 (max_wage NUMBER) IS
        SELECT * FROM emp WHERE sal < max_wage;
BEGIN
    OPEN c1(2000);
    LOOP
        FETCH c1 INTO my_record;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Name = ' || my_record.ename || ', salary = '
            || my_record.sal);
    END LOOP;
    CLOSE c1;
END;


-- Dev's Code


DECLARE
	rec newEmp%rowtype;
	rec2 newEmp%rowtype;
	flag number;

cursor newt is select * from newEmp;
cursor oldt (eid number) is select * from oldEmp where oldEmp.empid=eid;
BEGIN
	open newt;
	loop
		fetch newt into rec ;
		flag:=0;
		EXIT WHEN newt%NOTFOUND;
		open oldt(rec.empid);
		loop
			fetch  oldt into rec2 ;
			EXIT WHEN oldt%NOTFOUND;		
			if rec2.empid=rec.empid then
				flag:=1;
			end if;	
			if flag=1 then
				EXIT;
			end if;		
		end loop;
		if flag<>1 then
			insert into oldEmp values (rec.empid,rec.name);
		end if;
		close oldt;
	
	end loop;
	close newt;

END;
/

