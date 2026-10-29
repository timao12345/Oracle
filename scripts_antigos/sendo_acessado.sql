----------------------------------------------------------------------------------------
-- VERIFICAR SE O OBJETO ESTA SENDO ACESSADO NO MOMENTO
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
COLUMN DONO FOR A20
COLUMN OBJETO FOR A40
COLUMN TIPO FOR A30

undef objeto
undef dono

ACCEPT dono     CHAR PROMPT 'Nome do owner do objeto: '
ACCEPT objeto   CHAR PROMPT 'Nome do objeto ........: '

select SID, OWNER DONO, OBJECT OBJETO, TYPE TIPO
from v$access
where owner = upper('&&dono')
and object = upper('&&objeto')
/