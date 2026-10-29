-- VERIFICA SE OS ARCHIVES ENTÃO SENDO  COPIADOS PARA O STANB-BY

set pages 9999
 select
thread#,
dest_id,
sequence#,
first_time,
next_time
from v$archived_log
where resetlogs_change# = (select resetlogs_change# from v$database)
order by thread#, sequence#, dest_id;