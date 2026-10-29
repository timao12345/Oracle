col c1 heading 'Media Waits para|Full Scan Read I/O' format 9999.999
col c2 heading 'Media Waits para|Index Read I/O' format 9999.999
col c3 heading 'Porcentagem de| I/O Waits|para Full Scans' format 99.99
col c4 heading 'Porcentagem de| I/O Waits|para Index Scans' format 99.99
col c5 heading 'Valor|inicial|para|optimizer|index|cost|adj' format 999

select
a.average_wait c1,
b.average_wait c2,
a.total_waits /(a.total_waits + b.total_waits)*100 c3,
b.total_waits /(a.total_waits + b.total_waits)*100 c4,
(b.average_wait / a.average_wait)*100 c5
from
v$system_event a,
v$system_event b
where
a.event = 'db file scattered read'
and
b.event = 'db file sequential read'
;
