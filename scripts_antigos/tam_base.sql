----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DO BASE
----------------------------------------------------------------------------------------
set head off
set pagesize 5555
set linesize 500


select 'Tamanho da base: '||round(sum(bytes)/1024/1024, 2)||' MB'
from dba_segments
/