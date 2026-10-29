----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DO OBJETO
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column OBJETO format a40
undef objeto
undef owner

ACCEPT owner     CHAR PROMPT 'Nome do owner do objeto: '
ACCEPT objeto    CHAR PROMPT 'Nome do objeto ........: '

select owner DONO, segment_name OBJETO , round(sum(bytes)/1024/1024, 2) TAMANHO_MB
from dba_segments
where owner = upper('&&Owner')
and segment_name = upper('&&Objeto')
group by segment_name, owner
/