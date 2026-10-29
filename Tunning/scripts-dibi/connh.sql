conn lucas@&1

set sqlprompt "_user '@' _connect_identifier > "

col con_name new_value _container_name noprint
select sys_context('userenv', 'con_name') as con_name
from dual;

set lines 2000;
set long 5000;
set pages 400;
set timing on;
 alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS'; 
select instance_number,instance_name,host_name,logins,version,to_char(startup_time, 'DD/MM/YYYY HH24:MI:SS') as startup_time,status from gv$instance;