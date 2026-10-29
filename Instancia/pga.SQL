select name, sum(value/1024/1024) "Value - MB"
 from v$statname n,
 v$session s,
 v$sesstat t
 where s.sid=t.sid
 and n.statistic# = t.statistic#
 and s.type = 'USER'
 and s.username is not NULL
 and n.name in ('session pga memory', 'session pga memory max',
 'session uga memory', 'session uga memory max')
 group by name
/
