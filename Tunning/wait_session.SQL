select
   b.sid                                     SystemID,
   decode(b.username,NULL,c.name,b.username) Prcs,
   a.event                                     Event,
   a.total_waits                             "Total Waits",
   round((a.time_waited / 100),2)            "Time Waited (in secs)",
   a.total_timeouts                             "Total Timeouts",
   round((average_wait / 100),2)             "Avg Wait secs",
   round((a.max_wait / 100),2)               "Max Wait (in secs)"
from
   sys.v_$session_event a,
   sys.v_$session       b,
   sys.v_$bgprocess     c
 where
   a.event NOT LIKE 'DFS%'
and
   a.event NOT LIKE 'KXFX%'
and
   a.sid = b.sid
and
   b.paddr = c.paddr (+)
and
   a.event NOT IN
   (
   'lock element cleanup',
   'pmon timer',
   'rdbms ipc message',
   'smon timer',
   'SQL*Net message from client',
   'SQL*Net break/reset to client',
   'SQL*Net message to client',
   'SQL*Net more data to client',
   'dispatcher timer',
   'Null event',
   'io done',
   'parallel query dequeue wait',
   'parallel query idle wait - Slaves',
   'pipe get',
   'PL/SQL lock timer',
   'slave wait',
   'virtual circuit status',
   'WMON goes to sleep'
          )
Order by 4 Asc