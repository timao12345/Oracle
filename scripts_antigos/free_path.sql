-- Free_Path

set pagesize 5555
set linesize 500
column file_name format a60
undef tablespace

select file_id, file_name,status, bytes/1024/1024 , AUTOEXTENSIBLE,BLOCKS, MAXBYTES, MAXBLOCKS
from dba_data_files
where tablespace_name = '&&tablespace'
/