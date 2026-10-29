ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
select a.thread#,
b.last_seq,
a.applied_seq,
a.last_app_timestamp,
b.last_seq - a.applied_seq arc_diff
from ( select thread#,max (sequence#) applied_seq, max (next_time) last_app_timestamp from gv$archived_log where applied = 'YES' group by thread#) a,
( select thread#, max (sequence#) last_seq from gv$archived_log group by thread#) b
where a.thread# = b.thread#;