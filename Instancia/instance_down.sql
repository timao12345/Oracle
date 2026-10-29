prompt ******************INFORMACOES DA INSTANCIA ******************
alter session set nls_date_format='dd/mm/yy:hh24:mi:ss';
set pagesize 5555
set linesize 500
col host_name for a20
select sysdate, startup_time, host_name, instance_name, status, a.open_mode, v.sessions_current, v.sessions_highwater
from v$instance, v$license v, v$database a
/


prompt ****************** VERIFICAR SE O DATAFILE SE ENCONTRA EM RECOVER ******************
select * from v$recover_file;

prompt VERIFICAR O HEADER DOS DATAFILES
select fuzzy, status, error, recover, checkpoint_change#, checkpoint_time from v$datafile_header;

prompt STATUS DATAFILES
col file_name for a63
select file_id, file_name, tablespace_name, status, autoextensible, increment_by, user_bytes, user_blocks 
from dba_data_files
order by file_id
/
 