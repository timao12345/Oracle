----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DO SCHEMA( só tabelas )
----------------------------------------------------------------------------------------
set head off
set pagesize 5555
set linesize 500
undef owner

ACCEPT owner     CHAR PROMPT 'Nome do schema: '

select 'Tamanho do schema '||owner||': '||round(sum(bytes)/1024/1024, 2)||' MB'
from dba_segments
where owner = upper('&&owner')
and segment_type='TABLE'
group by owner
/
set head on