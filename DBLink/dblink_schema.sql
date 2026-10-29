----------------------------------------------------------------------------------------
-- VERIFICAR OS DATABASE LINKS DO SCHEMA
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
undef owner
col db_link for a30
col host for a20

ACCEPT owner     CHAR PROMPT 'Nome do schema: '

select *
from dba_db_links
where owner = upper('&&OWNER')
order by db_link
/
