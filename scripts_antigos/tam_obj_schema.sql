----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DOS OBJETOS DE UM SCHEMA
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column OBJETO format a40
undef owner
BREAK ON REPORT
compute sum of tamanho_mb on report

ACCEPT owner     CHAR PROMPT 'Nome do owner do objeto: '

select owner DONO, segment_name OBJETO , round(sum(bytes)/1024/1024, 2) TAMANHO_MB
from dba_segments
where owner = upper('&&Owner')
group by segment_name, owner
/