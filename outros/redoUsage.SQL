select b.SID, b.USERNAME, b.OSUSER, b.PROGRAM, round(a.VALUE / 1024 / 1024) mBytes
  from v$sesstat a, v$session b
where a.SID = b.SID
  and a.STATISTIC# = 134 -- 169 para 11g
order by 5 desc;


SELECT a.group#, a.member, b.bytes/1014/1024
FROM v$logfile a, v$log b 
WHERE a.group# = b.group# 
order by 1;