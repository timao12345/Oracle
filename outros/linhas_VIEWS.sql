----------------------------------------------------------------------------------------
-- VERIFICAR QUANT. DE LINHAS DAS VIEWS
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column OBJETO format a40
undef arquivo

ACCEPT arquivo   CHAR PROMPT 'Nome do arquivo a ser criado :  '

spo c:\scripts\spool\cgmp\&&arquivo

SELECT OWNER, COUNT(DISTINCT VIEW_NAME)
FROM DBA_VIEWS
WHERE OWNER NOT IN ('SYS', 'SYSTEM', 'WKSYS', 'CTXSYS', 'MDSYS', 'OE', 'OUTLN', 'OLAPDBA', 'OLAPSYS', 'ORDSYS', 'QS_ADM')
GROUP BY OWNER
/
SELECT OWNER, COUNT(DISTINCT TRIGGER_NAME)
FROM DBA_TRIGGERS
WHERE OWNER NOT IN ('SYS', 'SYSTEM', 'WKSYS', 'CTXSYS', 'MDSYS', 'OE', 'OUTLN', 'OLAPDBA', 'OLAPSYS', 'ORDSYS', 'QS_ADM')
GROUP BY OWNER
/

spo off;





