SELECT s.sid, s.serial#, p.spid as "OS PID", s.username, s.module, se.event, se.time_waited
 FROM v$session_event se, v$session s, v$process p
WHERE lower(se.event) like '%&1%' 
  AND s.last_call_et < 1800 -- active within last 1/2 hour
  AND s.logon_time > (SYSDATE - 240/1440) -- sessions logged on within 4 hours
  AND se.sid = s.sid
  AND s.paddr = p.addr
ORDER BY se.time_waited;


