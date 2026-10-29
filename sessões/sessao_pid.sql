select sid,  spid, a.serial#
from gv$session a ,gv$process b
where spid = 389316 
and a.paddr=b.addr;