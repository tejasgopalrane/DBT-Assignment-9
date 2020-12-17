create database whitewalker7;
use whitewalker7;
use whitewalker3;
-- 1.Write a Procedure that displays names and salaries of all Analysts recorded in the “emp” table by making use of a cursor.
delimiter $$
create procedure proc111()
begin 
declare done int default 0;
declare current_sal int(7);
declare current_name varchar(30);
declare empcur cursor for select ename,sal from emp;
declare continue handler for not found set done=1;
open empcur;
repeat
fetch empcur into current_name,current_sal;
select current_name,current_sal from emp where ename=current_name and emp.job='ANALYST';
until done
end repeat;
close empcur;
end $$
delimiter ;
call proc111();

drop procedure proc111;

-- 2.	Write a Procedure to display top 5 employees based on highest salary and display employee number, employee name and salary using Cursor.
delimiter %%
create procedure proc112() 
begin 
declare done int default 0;
declare current_empno int(4);
declare current_ename varchar(30);
declare current_salary int(7);
declare empcur1 cursor for select empno,ename,sal from emp;
declare continue handler for not found set done=1;
open empcur1;
repeat
fetch empcur1 into current_empno,current_ename,current_salary;
select current_empno,current_ename,current_salary  from emp where empno = current_empno order by sal desc;
until done
end repeat;
end %%
delimiter ;
call proc112();
drop procedure proc112;
-- 3.	Write  a procedure to display the concatenated first_name and last_name from “emp” table using cursors handle the  errors with Exit handler.
DELIMITER $$
CREATE PROCEDURE CONCAT_NM_JOB()
BEGIN
DECLARE LOCALNM VARCHAR(20);
DECLARE LOCALJOB VARCHAR(20);
DECLARE ERR VARCHAR(20);

DECLARE NM_JOB CURSOR FOR SELECT ENAME,JOB FROM EMP;
DECLARE EXIT HANDLER FOR NOT FOUND SET ERR="ERROR OCCURED";

OPEN NM_JOB;
        TEST:LOOP
            FETCH NM_JOB INTO LOCALNM,LOCALJOB;
            IF(ERR="ERROR OCCURED") THEN
              LEAVE TEST;
            END IF;  
            SELECT CONCAT(LOCALNM,' ',LOCALJOB);
        END LOOP TEST;
CLOSE NM_JOB; 
END $$
CALL CONCAT_NM_JOB();

-- 4.	Write a procedure which select all the data from 
-- employee table and display the data of employee where employee name is ‘Manish’ using cursors.
DELIMITER $$
CREATE PROCEDURE IND_ALL_DATA()
BEGIN
DECLARE LLEMPNO numeric(4) DEFAULT 0;
DECLARE LLENAME  varchar(30);
DECLARE LLJOB varchar(10);
DECLARE LLMGR numeric(4)  DEFAULT 0; 
DECLARE LLHIREDATE DATE;
DECLARE LLSAL numeric(7,2)  DEFAULT 0;
DECLARE LLDNO numeric(2)  DEFAULT 0;
DECLARE ERR INT  DEFAULT 0;

DECLARE ALL_DATA CURSOR FOR SELECT * FROM EMP WHERE ENAME="Manish";
DECLARE CONTINUE HANDLER FOR NOT FOUND SET ERR=1;

OPEN ALL_DATA;
     TEST:LOOP
        FETCH ALL_DATA INTO LLEMPNO,LLENAME,LLJOB,LLMGR,LLHIREDATE,LLSAL,LLDNO;
        IF(ERR=1) THEN 
           LEAVE TEST;
		END IF;
        SELECT CONCAT(LLEMPNO," ",LLENAME," ",LLJOB," ",LLMGR," ",LLHIREDATE," ",LLSAL," ",LLDNO);
     END LOOP TEST;
CLOSE ALL_DATA;
END $$
CALL IND_ALL_DATA();

-- QUE5 5.	Write a procedure which select delete the data from employee table if emp sal is less than 10000  
-- using cursor and handle the  Sqlexception with continue handler
DELIMITER $$
CREATE PROCEDURE DELEMPNO_DATA()
BEGIN
DECLARE LLEMPNO numeric(4) DEFAULT 0;
DECLARE ERR INT  DEFAULT 0;

DECLARE DELEMPNO CURSOR FOR SELECT EMPNO FROM EMP WHERE SAL<10000;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET ERR=1;

OPEN DELEMPNO;
     TEST:LOOP
        FETCH DELEMPNO  INTO LLEMPNO;
        IF(ERR=1) THEN 
           LEAVE TEST;
		END IF;
       DELETE FROM EMP WHERE EMPNO=LLEMPNO;
    END LOOP TEST;
CLOSE DELEMPNO;
END $$
CALL DELEMPNO_DATA();    -- DELETED ALL RECORDS BCZ ALL EMP HAVING SALARY LESS THAN 10000
SELECT * FROM EMP;
