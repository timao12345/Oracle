undef pid

select a.username, sid,  spid, a.serial#, a.status, a.last_call_et
from v$session a ,v$process b
where sid = 49061
and a.paddr=b.addr;
