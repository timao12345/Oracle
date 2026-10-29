set lines 122
select group#, thread#, sequence#, bytes, used, archived, status, first_change#, first_time, last_change#, last_time
from v$standby_log
order by 1,2,3;

