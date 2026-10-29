----------------------------------------------------------------------------------------
-- FAZER BACKUP TRIGGERS
----------------------------------------------------------------------------------------

SET LONG 30000
SET LINE 200
SET TRIMSPOOL On
SET HEAD OFF
SET FEED OFF

undef objeto
undef owner
undef arquivo

ACCEPT arquivo   CHAR PROMPT 'Nome do arquivo a ser criado :  '
ACCEPT owner     CHAR PROMPT 'Nome do owner do objeto..... :  '
ACCEPT objeto    CHAR PROMPT 'Nome do objeto a ser criado. :  '

SPOOL C:\sc\scripts\bkp\&&Arquivo

SELECT description,TRIGGER_BODY
FROM dba_TRIGGERS
WHERE TRIGGER_NAME = upper('&objeto')
and   owner like upper('&Owner')
/

SPOOL OFF
SET LINE 80
SET HEAD ON
SET FEEDBACK ON
