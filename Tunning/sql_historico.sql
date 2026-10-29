BREAK ON sql_hist_plan_hash ON sql_id
set lines 250
set pages 100
set verify off

COLUMN sql_hist_plan_hash        HEADING PLAN_HASH_VALUE
COLUMN sql_hist_sample_time      FORMAT A21               HEADING SAMPLE_END_TIME
COLUMN sql_hist_execs            FORMAT 9999990           HEADING EXECS
COLUMN sql_hist_pio_1exec        FORMAT 999,999,990.0     HEADING "1EXEC|PIO|DISK READS"
COLUMN sql_hist_lio_1exec        FORMAT 999,999,990.0     HEADING "1EXEC|LIO|BUFFER GETS"
COLUMN sql_hist_lio_1exec        FORMAT 999,999,990.0     HEADING "1EXEC|LIO|BUFFER GETS"
COLUMN sql_hist_etime_sec_1exec  FORMAT 999,999,990.0     HEADING "1EXEC|ELAPSED TIME(s)"
COLUMN sql_hist_etime_msec_1exec FORMAT 999,999,990.0     HEADING "1EXEC|ELAPSED TIME(ms)"
COLUMN sql_hist_ctime_sec_1exec  FORMAT 999,999,990.0     HEADING "1EXEC|CPU TIME(s)"
COLUMN sql_hist_ctime_msec_1exec FORMAT 999,999,990.0     HEADING "1EXEC|CPU TIME(ms)"
COLUMN sql_hist_rows_1exec       FORMAT 999,999,990.0     HEADING "1EXEC|ROWS PROCESSED"

SELECT 
	s.snap_id
	, to_char(min(s.end_interval_time),'DD/MM/YYYY HH24:MI DY') sql_hist_sample_time
--	, q.sql_id
	, q.plan_hash_value sql_hist_plan_hash
	, SUM(q.executions_delta) sql_hist_execs
	, ROUND(SUM(disk_reads_delta)/greatest(sum(executions_delta),1),1)  sql_hist_pio_1exec
	, ROUND(SUM(buffer_gets_delta)/greatest(sum(executions_delta),1),1) sql_hist_lio_1exec
	, ROUND((SUM(elapsed_time_delta)/greatest(sum(executions_delta),1)/1000000),1) sql_hist_etime_sec_1exec
	, ROUND((SUM(elapsed_time_delta)/greatest(sum(executions_delta),1)/1000),1) sql_hist_etime_msec_1exec
	, ROUND((SUM(cpu_time_delta)/greatest(sum(executions_delta),1)/1000000),1) sql_hist_ctime_sec_1exec
	, ROUND((SUM(cpu_time_delta)/greatest(sum(executions_delta),1)/1000),1)    sql_hist_ctime_msec_1exec
	, ROUND(SUM(rows_processed_delta)/greatest(sum(executions_delta),1),1)     sql_hist_rows_1exec
FROM dba_hist_sqlstat q, dba_hist_snapshot s
WHERE q.sql_id = TRIM('&1')
AND s.snap_id = q.snap_id
AND s.dbid = q.dbid
AND s.instance_number = q.instance_number
AND s.end_interval_time  >= trunc(sysdate) - &2
AND executions_delta > 0
GROUP BY s.snap_id, q.sql_id, q.plan_hash_value
ORDER BY s.snap_id, q.sql_id, q.plan_hash_value
;
