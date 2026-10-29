----------------------------------------------------------------------------------------
-- GERAR SCRIPT PARA DAR GRANT AO UAU�RIO NOS OBJETOS DE UM SCHEMA
----------------------------------------------------------------------------------------

SET HEAD OFF
set pagesize 5555
set linesize 90
undef owner
undef priv
undef arquivo
undef grantee
undef tipo

ACCEPT arquivo CHAR PROMPT 'Nome do arquivo...: '
ACCEPT grantee CHAR PROMPT 'Nome do grantee...: '
ACCEPT owner   CHAR PROMPT 'Nome do schema....: '
ACCEPT priv    CHAR PROMPT 'Tipo de privilegio: '
ACCEPT tipo    CHAR PROMPT 'Tipo de objeto....: '

SPOOL '&arquivo'

SELECT 'GRANT &&priv ON '||owner||'.'||OBJECT_NAME||' TO &&grantee ;'
FROM DBA_OBJECTS
WHERE OWNER = upper('&&owner')
and object_type  IN upper('&&tipo')
/

SPOOL OFF


