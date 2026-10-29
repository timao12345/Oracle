----------------------------------------------------------------------------------------
-- GERAR SCRIPT PARA DAR GRANT AO UAUÁRIO NOS OBJETOS DE UM SCHEMA
----------------------------------------------------------------------------------------

SET HEAD OFF
set pagesize 5555
set linesize 90
undef owner
undef objeto

ACCEPT objeto CHAR PROMPT 'Nome do objeto...: '
ACCEPT owner   CHAR PROMPT 'Nome do owner....: '

SELECT grantee, privilege, owner, table_name
FROM DBA_tab_privs
WHERE OWNER = upper('&&owner')
and table_name  IN upper('&&objeto')
order by grantee
/



