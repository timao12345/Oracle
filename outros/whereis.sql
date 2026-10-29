clear col
select osuser, a.inst_id, a.sid, a.serial#, module, spid,
  to_char(logon_time, 'dd/mm/yyyy hh24:mi:ss'), a.username
from gv$session a, gv$process b 
where upper(osuser) like upper('&1%')
  and a.paddr = b.addr
  and a.inst_id = b.Inst_id
/
