----------------------------------------------------------------------------------------
-- FAZER BACKUP DE PROCEDURES, PACKAGES E FUNCTIONS 
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
SPOOL &&Arquivo
select TEXT from dba_source
where name like upper('&&Objeto')
and   owner like upper('&&Owner')
/
select status from dba_objects 
where owner like upper('&&Owner')
and object_name like upper('&&Objeto')
/

SPOOL OFF

SET PAGESIZE 400
SET LINESIZE 200
SET FEEDBACK ON



