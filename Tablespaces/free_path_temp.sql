----------------------------------------------------------------------------------------
-- VERIFICAR tempfiles DA TABLESPACE
----------------------------------------------------------------------------------------

set pagesize 5555
set linesize 500
column file_name format a50
undef tablespace

select file_id, file_name, bytes/1024/1024,autoextensible,status
from dba_temp_files
where tablespace_name = '&&tablespace'
/
