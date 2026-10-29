--run this as sys in SQL worksheet
create table full_sql (sql_text varchar2(1000), executions number);
create or replace procedure sys.p_findfullsql as

v_csr number;
v_rc number;
v_string varchar2(2000);

v_count number;


cursor c1 is select sql_text,executions from sys.v_$sqlarea where lower(sql_text) like '%select%';

begin

for x1 in c1 loop

delete from plan_table ;
Begin
v_Csr := DBMS_SQL.OPEN_CURSOR; 
v_string := 'explain plan for ' ;
v_string := v_string||x1.sql_text ;
DBMS_SQL.PARSE(v_csr, v_string, DBMS_SQL.V7);
v_rc := DBMS_SQL.EXECUTE(v_csr);
DBMS_SQL.CLOSE_CURSOR(v_csr); 
Exception
when others then 
null; 
End ;

select count(*) into v_count from plan_table where options like '%FULL%' and operation like '%TABLE%' ;
if v_count > 0 then
insert into full_sql(sql_text,executions) values (x1.sql_text, x1.executions) ;
end if;
end loop ;
commit;
end ;
/
execute p_findfullsql ;
select * from full_sql;
--drop table full_sql; 