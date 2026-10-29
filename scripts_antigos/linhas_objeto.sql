----------------------------------------------------------------------------------------
-- VERIFICAR QUANT. DE LINHAS OBJETOS
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column OBJETO format a40
undef arquivo

ACCEPT arquivo   CHAR PROMPT 'Nome do arquivo a ser criado :  '

spo c:\scripts\spool\cgmp\&&arquivo

SELECT OWNER DONO, TYPE TIPO, count(distinct name) NUMERO ,  COUNT(LINE) LINHAS
FROM DBA_SOURCE
WHERE OWNER NOT IN ('SYS', 'SYSTEM', 'WKSYS', 'CTXSYS', 'MDSYS', 'OE', 'OUTLN', 'OLAPDBA', 'OLAPSYS', 'ORDSYS', 'QS_ADM')
group by type, owner
order by owner

/

spo off;





