-- Status Datafiles

set pagesize 5555
set linesize 500
col file_name for a63
select file_id, file_name, tablespace_name, status, online_status, autoextensible, increment_by, user_bytes, user_blocks 
from dba_data_files
order by file_id
/