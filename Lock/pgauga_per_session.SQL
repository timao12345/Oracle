SELECT
    s.sid                sid
  , lpad(s.username,12)  oracle_username
  , lpad(s.osuser,9)     os_username
  , s.program            session_program
  , lpad(s.machine,8)    session_machine
  , (select ss.value/1024/1024 from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory')        session_pga_memory
  , (select ss.value/1024/1024 from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory max')    session_pga_memory_max
  , (select ss.value/1024/1024 from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory')        session_uga_memory
  , (select ss.value/1024/1024 from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory max')    session_uga_memory_max
FROM
    v$session  s
ORDER BY session_pga_memory ASC