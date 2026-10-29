-- Monitoring Datapump --

select
   round(sofar/totalwork*100,2)  percent_completed, 
   v$session_longops.* 
from 
   v$session_longops 
where
   sofar <> totalwork 
order by
   target, 
   sid;