select b.SID, b.USERNAME, b.OSUSER, b.PROGRAM, round(a.VALUE / 1024 / 1024) mBytes
  from v$sesstat a, v$session b
where a.SID = b.SID
  and a.STATISTIC# = 169 -- 169 para 11g
order by 5 ;
