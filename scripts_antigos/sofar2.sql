----------------------------------------------------------------------------------------
-- ANDAMENTO DA ATIVIDADE
----------------------------------------------------------------------------------------

set lines 132
column ttc format a10 heading "TIME TO |COMPLETE"
column elapsed_min format 9999.99 heading "ELAPSED|MIN"
column sid format 999999
column username format a12
column osuser format a10
column opname format a20

select l.sid, l.serial#, substr(s.username,1,12) username, substr(s.osuser,1,10) osuser,
substr(l.opname,1,10) opname,
round((l.sofar/l.totalwork) * 100,2) "% FINISH",
to_char(round(l.time_remaining/60,2))||' min' ttc,
round(l.elapsed_seconds/60,2) elapsed_min,
l.start_time, l.last_update_time
from v$session_longops l,
v$session s
where l.sofar < l.totalwork
and l.sid = s.sid
and l.serial# = s.serial#;
