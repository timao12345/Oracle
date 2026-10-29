col OWNER for a20
col NAME for a20;
set lines 9999
set pages 9999
select a.OWNER, a.NAME, a.EXECUTIONS, a.LOCKS, a.LOCK_MODE, a.STATUS, b.sid, b.serial#, b.SCHEMANAME 
from GV$DB_OBJECT_CACHE a, gv$session b where NAME='OLIMPO_BENEFICIO' and a.LOCKS='1'; 


select 'alter system kill session ' || '''' || b.sid || ',' || b.serial# || ',@' || b.inst_id || '''' || ' immediate;' 
from GV$DB_OBJECT_CACHE a, gv$session b where NAME='OLIMPO_BENEFICIO' and a.LOCKS='1'; 