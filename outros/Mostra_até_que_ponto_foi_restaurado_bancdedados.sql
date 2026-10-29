alter session set nls_date_format='dd/mm/yyyy hh24:mi:Ss';
set lines 200
select * from v$recover_file;
