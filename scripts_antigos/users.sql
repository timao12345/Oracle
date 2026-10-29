----------------------------------------------------------------------------------------
-- VERIFICAR USUARIO DO BANCO
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column username for a30
column default_tablespace for a40
column temporary_tablespace for a40

select username, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
from dba_users 
order by username
/



