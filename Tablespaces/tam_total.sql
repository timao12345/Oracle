----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO TOTAL DOS DATAFILES
----------------------------------------------------------------------------------------
set head off
set pagesize 5555
set linesize 500

select 'Tamanho Total: '||round(sum(bytes)/1024/1024, 2)||' MB'
from dba_data_files;