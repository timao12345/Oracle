set head off
prompt qtd
select count(*) from dba_tablespaces;

prompt total_mb
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_data_files;
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_temp_files;
       
prompt free%
select ((nvl(mbytes_free,0))/mbytes_alloc)*100 pct_free
from ( select sum(bytes)/1024/1024 mbytes_free
       from  sys.dba_free_space) a,
     ( select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_data_files)b;

prompt temp
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_temp_files;
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_data_files
       WHERE TABLESPACE_NAME IN (
       SELECT TABLESPACE_NAME FROM DBA_TABLESPACES
       WHERE CONTENTS='TEMPORARY');
       
prompt undo
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_data_files
       WHERE TABLESPACE_NAME IN (
       SELECT TABLESPACE_NAME FROM DBA_TABLESPACES
       WHERE CONTENTS='UNDO');
select sum(bytes)/1024/1024 mbytes_alloc
       from sys.dba_data_files
       WHERE TABLESPACE_NAME ='RBS';
@version