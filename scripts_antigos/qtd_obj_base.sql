----------------------------------------------------------------------------------------
-- VERIFICAR QUANTIDADE DOS OBJETOS DA BASE
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column TIPO format a30
BREAK ON REPORT
compute sum of QUANTIDADE on report


select object_type TIPO , count(*)QUANTIDADE
from dba_Objects
group by object_type
/


