----------------------------------------------------------------------------------------
-- FAZER BACKUP DE VIEWS
----------------------------------------------------------------------------------------

undef objeto
undef owner
undef arquivo

ACCEPT arquivo   CHAR PROMPT 'Nome do arquivo a ser criado :  '
ACCEPT owner     CHAR PROMPT 'Nome do owner do objeto..... :  '
ACCEPT objeto    CHAR PROMPT 'Nome do objeto a ser criado. :  '


set head off
SET TRIMSPOOL ON
SET FEEDBACK OFF
SET LINESIZE 1000
SET LONG 10000
SPOOL C:\scripts\spool\&&Arquivo
select Query from dba_MVIEWS
where MVIEW_NAME  like upper('&Objeto')
and   owner like upper('&Owner')
/

SPOOL OFF

SET PAGESIZE 400
SET LINESIZE 200
SET FEEDBACK ON



