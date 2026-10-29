SELECT a.OSUSER,
       substr(a.sid,1,5) "Sid",
       substr(a.process,1,7) "Process",
       substr(a.username,1,20) "User",
       v.value "CPU used by this session"
  FROM v$statname s, v$sesstat v, v$session a
 WHERE s.name = 'CPU used by this session'
   and v.statistic#=s.statistic#
   AND v.sid = a.sid
   and v.value > 1000
ORDER BY v.value DESC;


SELECT s.sid, s.serial#, p.spid as "OS PID",s.username, s.module, st.value/100 as "CPU sec"
FROM v$sesstat st, v$statname sn, v$session s, v$process p
WHERE sn.name = 'CPU used by this session' -- CPU
AND st.statistic# = sn.statistic#
AND st.sid = s.sid
AND s.paddr = p.addr
AND s.last_call_et < 1800 -- active within last 1/2 hour
AND s.logon_time > (SYSDATE - 240/1440) -- sessions logged on within 4 hours
ORDER BY st.value;