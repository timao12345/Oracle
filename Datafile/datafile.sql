----------------------------------------------------------------------------------------
-- VERIFICAR DATAFILES DA TABLESPACE
----------------------------------------------------------------------------------------

set pagesize 5555
set linesize 500
column file_name format a70
undef tablespace

select file_id, file_name, bytes/1024/1024 TAMANHO_MB
from dba_data_files
where tablespace_name = '&tablespace'
/

select STATUS from dba_data_files;


select FILE_ID,FILE_NAME,TABLESPACE_NAME,STATUS,ONLINE_STATUS from dba_data_files where status !='ONLINE';