-- Last_call_et

set lines 900
SELECT /*+ rule */ 
b.USERNAME,
CASE 
WHEN trunc((b.last_call_et/60),2) > 60 AND trunc((b.last_call_et/60),2) < 1440
  THEN  trunc((b.last_call_et/60/60),2)|| ' HORA(S)'
WHEN trunc((b.last_call_et/60),2) >= 1440
  THEN trunc((b.last_call_et/60/1440),0)|| ' DIA(S)'
ELSE '0'||trunc((b.last_call_et/60),2)|| ' MINUTO(S)' 
END PERIODO, 
b.INST_ID,
b.SID, 
b.SERIAL#, 
a.spid,
b.INST_ID,
b.STATUS, 
b.OSUSER, 
b.LOGON_TIME,
b.MACHINE, 
b.program, 
b.module,
a.SPID SO_PROC, 
b.LOCKWAIT,
b.SQL_ADDRESS,
b.SQL_HASH_VALUE
from gv$process a, gv$session b
where a.ADDR = b.PADDR
and b.STATUS in ('ACTIVE','INACTIVE')
and b.USERNAME is not null
ORDER by 2
/
