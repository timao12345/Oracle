col name for a20
set lines 1000 pages 5000
SELECT 
       b.last_seq - a.applied_seq ARC_DIFF
FROM   (SELECT thread#,
               Max(sequence#) applied_seq,
               Max(next_time) last_app_timestamp
        FROM   gv$archived_log
        WHERE  applied = 'YES'
        GROUP  BY thread#) a,
       (SELECT thread#,
               Max (sequence#) last_seq
        FROM   gv$archived_log
        GROUP  BY thread#) b
WHERE  a.thread# = b.thread#
  order by a.thread#;
