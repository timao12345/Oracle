select pname, tracefile
from v$process p
inner join v$session s on p.addr = s.paddr
where s.sid = &n ;