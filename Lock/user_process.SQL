select p.SPID,a.SID, a.SERIAL#, a.OSUSER, a.USERNAME, s.EXECUTIONS, s.SQL_TEXT
  from v$session a,
       v$process p,
       v$sqlarea s
where a.PADDR = p.ADDR
  and a.SQL_HASH_VALUE = s.HASH_VALUE
  and p.SPID in (27697,27879)
