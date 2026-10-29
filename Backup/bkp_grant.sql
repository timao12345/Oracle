----------------------------------------------------------------------------------------
-- FAZER BACKUP DE GRANTS DE OBJETOS
----------------------------------------------------------------------------------------

SET VERIFY OFF
SET HEAD OFF
SET FEED OFF

SPOOL C:\BACKUP\&Arquivo

ACCEPT  1 CHAR PROMPT 'Digite o OBJETO : '

SELECT 'GRANT '||PRIVILEGE||' ON '||TABLE_NAME||' TO '||GRANTEE||';'
FROM USER_TAB_PRIVS WHERE TABLE_NAME = '&1'
/

SPOOL OFF

SET HEAD ON
SET FEED ON
