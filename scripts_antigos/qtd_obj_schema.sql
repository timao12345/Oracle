----------------------------------------------------------------------------------------
-- VERIFICAR QUANTIDADE DOS OBJETOS DE UM SCHEMA
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column TIPO format a30
undef owner
BREAK ON REPORT
compute sum of QUANTIDADE on report

ACCEPT owner     CHAR PROMPT 'Nome do owner do objeto: '

select owner DONO, object_type TIPO , count(*)QUANTIDADE
from dba_Objects
where owner = upper('&&Owner')
group by object_type, owner
/


