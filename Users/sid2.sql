undef sid

set lines 300
col program for a30
col machine for a30
col osuser for a9
col spid for a8
col logon for a30
col LAST_CALL_ET for 99999999
select a.username ,a.sid, a.serial#, b.spid,c.sql_id, a.status, a.osuser, a.machine, a.program, to_char(a.logon_time,'dd-mm-rr hh24:mi:ss') as LOGON, a.last_call_et from v$session a ,v$process b, v$sqltext c where a.sid = '&sid' and a.paddr=b.addr;