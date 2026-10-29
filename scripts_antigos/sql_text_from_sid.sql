select a.inst_id, a.sid, a.serial#, b.sql_fulltext
from   gv$session a, gv$sql b
where  decode(a.sql_id,null,a.prev_sql_id, a.sql_id)=b.sql_id
and    decode(a.sql_id,null,a.prev_child_number, a.sql_child_number)=b.child_number
and    a.sid=&sid
and    a.serial#=&serial;