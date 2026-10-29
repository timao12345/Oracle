col type for a15
set lines 122
set pages 33
col item for a20
col units for a15

select to_char(start_time, 'DD-MON-RR HH24:MI:SS') start_time, type,
       item, units, sofar, total, timestamp
from v$recovery_progress;
