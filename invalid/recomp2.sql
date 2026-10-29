----------------------------------------------------------------------------------------
-- VERIFICAR OBJETOS INVALIDOS - GERAR SCRIPT PARA RECOMPILACAO
----------------------------------------------------------------------------------------
set head off
set trimsp on
col y format a10 fold_a 
col x format a70 fold_a
col z format a10
undef arquivo

ACCEPT arquivo   CHAR PROMPT 'Nome do arquivo a ser criado :  '

SPOOL C:\scripts\spool\&&arquivo

select 'alter ' || decode (object_type,'PACKAGE BODY','package',object_type) ||
' ' || owner || '.' ||  object_name || ' compile ' || 
decode (object_type,'PACKAGE BODY',' body ;', ' ; ') 
from dba_objects
where status = 'INVALID'
/
spo off
