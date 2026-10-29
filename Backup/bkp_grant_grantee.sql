----------------------------------------------------------------------------------------
-- FAZER BACKUP DE GRANTS DE OBJETOS
----------------------------------------------------------------------------------------

SET VERIFY OFF
SET HEAD OFF
SET FEED OFF
SET PAGESIZE 5555
SET LINESIZE 500

SPOOL C:\scripts\spool\&Arquivo

ACCEPT  1 CHAR PROMPT 'Digite o GRANTEE : '

SELECT 'GRANT '||PRIVILEGE||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||';'
FROM DBA_TAB_PRIVS 
WHERE GRANTEE = '&1'
ORDER BY OWNER
/

SPOOL OFF

SET HEAD ON
SET FEED ON
