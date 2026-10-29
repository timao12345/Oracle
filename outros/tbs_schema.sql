----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DO SCHEMA POR TABLESPACE
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
undef owner

ACCEPT owner     CHAR PROMPT 'Nome do schema: '

select tablespace_name, round(sum(bytes)/1024/1024, 2) MB
from dba_segments
where owner = upper('&&owner')
group by tablespace_name
/
