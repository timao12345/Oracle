----------------------------------------------------------------------------------------
-- EVENTOS DE CONTENÇÃO RAC (TODOS OS NÓS)
----------------------------------------------------------------------------------------
set numwidth 10 
column state format a7 tru 
column event format a25 tru 
column last_sql format a40 tru 
select sw.inst_id, sw.sid, s.serial#, sw.state, sw.event, sw.seconds_in_wait seconds, sw.p1, sw.p2, sw.p3, sa.sql_text last_sql 
from gv$session_wait sw, gv$session s, gv$sqlarea sa 
where sw.event  in  ('enqueue') and 
       seconds_in_wait > 0  and 
       (sw.inst_id = s.inst_id  and sw.sid = s.sid) and 
       (s.inst_id  = sa.inst_id and s.sql_address = sa.address) 
order by seconds desc; 