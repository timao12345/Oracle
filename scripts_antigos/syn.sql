----------------------------------------------------------------------------------------
-- GERAR SCRIPT PARA DAR GRANT AO UAUÁRIO NOS OBJETOS DE UM SCHEMA
----------------------------------------------------------------------------------------

SET HEAD ON
set pagesize 5555
set linesize 5555
undef owner



ACCEPT owner   CHAR PROMPT 'Nome do synonm....: '



SELECT *
FROM DBA_synonyms
WHERE synonym_name = upper('&&owner')

/




