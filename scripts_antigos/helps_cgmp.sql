--liberar sessões presas no SO
select 'orakill cgmpsca '||spid
from v$session a ,v$process b
where sid in ( select sid from v$session where status='KILLED')
and a.paddr=b.addr;


--Verificar sessões gerando lock
SELECT A.USERNAME,A.SID, A.MACHINE, A.STATUS, A.LOGON_TIME , E.EVENT,
DECODE(XIDUSN, 0, 'WAITING', 'BLOCKING') "TRANSACTION STATUS", 
C.OBJECT_NAME, C.OBJECT_TYPE, D.sql_text
FROM V$SESSION A, V$LOCKED_OBJECT B, DBA_OBJECTS C, V$sqlarea D , V$SESSION_WAIT E
WHERE A.SID = B.SESSION_ID  
AND A.SID = E.SID AND
B.OBJECT_ID = C.OBJECT_ID and
d.address = a.sql_address
ORDER BY 2