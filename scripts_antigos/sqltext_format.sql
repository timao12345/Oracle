-- Formata o sql_text
SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON

begin
DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform,'SQLTERMINATOR',true);
end;
/


begin
DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform,'PRETTY',true);
end;
/