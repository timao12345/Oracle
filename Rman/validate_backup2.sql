set lines 220
set pages 1000

col cf for 9,999
col df for 9,999
col i0 for 9,999
col i1 for 9,999
col l for 9,999
col elapsed_seconds heading "ELAPSED|SECONDS"
col output_mbytes for 9,999,999 heading "OUTPUT|MBYTES"
col session_recid for 999999 heading "SESSION|RECID"
col session_stamp for 99999999999 heading "SESSION|STAMP"
col status for a10 trunc
col time_taken_display for a10 heading "TIME|TAKEN"
col output_instance for 9999 heading "OUT|AVAILABLE?"
col start_time for a20
col end_time for a20

select
  j.session_recid, 
  j.session_stamp,
  to_char(j.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
  to_char(j.end_time, 'yyyy-mm-dd hh24:mi:ss') end_time,
  (j.output_bytes/1024/1024) output_mbytes, 
  j.status, 
  j.input_type,
  decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
                                     3, 'Tuesday', 4, 'Wednesday',
                                     5, 'Thursday', 6, 'Friday',
                                     7, 'Saturday') dow,
  j.elapsed_seconds, 
  j.time_taken_display,
  x.cf, x.df, x.i0, x.i1, x.l,
  ro.inst_id output_instance
from V$RMAN_BACKUP_JOB_DETAILS j
  left outer join (select
                     d.session_recid, d.session_stamp,
                     sum(case when d.controlfile_included = 'YES' then d.pieces else 0 end) CF,
                     sum(case when d.controlfile_included = 'NO'
                               and d.backup_type||d.incremental_level = 'D' then d.pieces else 0 end) DF,
                     sum(case when d.backup_type||d.incremental_level = 'D0' then d.pieces else 0 end) I0,
                     sum(case when d.backup_type||d.incremental_level = 'I1' then d.pieces else 0 end) I1,
                     sum(case when d.backup_type = 'L' then d.pieces else 0 end) L
                   from
                     V$BACKUP_SET_DETAILS d
                     join V$BACKUP_SET s on s.set_stamp = d.set_stamp and s.set_count = d.set_count
                   where s.input_file_scan_only = 'NO'
                   group by d.session_recid, d.session_stamp) x
    on x.session_recid = j.session_recid and x.session_stamp = j.session_stamp
  left outer join (select o.session_recid, o.session_stamp, min(inst_id) inst_id
                   from GV$RMAN_OUTPUT o
                   group by o.session_recid, o.session_stamp)
    ro on ro.session_recid = j.session_recid and ro.session_stamp = j.session_stamp
where j.start_time > trunc(sysdate)-&NUMBER_OF_DAYS
order by j.start_time desc;


-- Query para monitorar bkp no zabbix.
-- Essa query retorna um valor que convertido no zabbix ele trata esse valor, a partir disso é criado a trigger para alarmar quando um bkp n for executado a x horas ou dias.
-- Alerta: "Last Oracle Backup LV1 INC Day > 24h" 
SELECT
    CAST(((CAST(MAX(BSD.COMPLETION_TIME) AS DATE) - DATE '1970-01-01') * 86400) AS NUMERIC) AS LAST_INC0,
    ROUND((SYSDATE - CAST(MAX(BSD.COMPLETION_TIME) AS DATE)) * 24, 1) AS HOURS_SINCE_LAST_BACKUP_LV0_SUCCESS
FROM
    V$BACKUP_SET_DETAILS BSD
JOIN
    V$RMAN_BACKUP_JOB_DETAILS R
        ON BSD.SESSION_KEY = R.SESSION_KEY
WHERE
    BSD.BACKUP_TYPE = 'I'
    AND BSD.INCREMENTAL_LEVEL = 1
    AND BSD.STATUS = 'A'
    AND R.STATUS = 'COMPLETED';
    

-- Para bkp full level 0 (semanal)
-- Colocar o Alerta: Last Oracle Backup Full Week > 7 Day 
-- Deve alarmar quando valor retornado for maior que 172 (valor retornado pela query em horas)

SELECT
    CAST(((CAST(MAX(BSD.COMPLETION_TIME) AS DATE) - DATE '1970-01-01') * 86400) AS NUMERIC) AS LAST_INC0,
    ROUND((SYSDATE - CAST(MAX(BSD.COMPLETION_TIME) AS DATE)) * 24, 1) AS HOURS_SINCE_LAST_BACKUP_LV0_SUCCESS
FROM
    V$BACKUP_SET_DETAILS BSD
JOIN
    V$RMAN_BACKUP_JOB_DETAILS R
        ON BSD.SESSION_KEY = R.SESSION_KEY
WHERE
    BSD.BACKUP_TYPE = 'I'
    AND BSD.INCREMENTAL_LEVEL = 0
    AND BSD.STATUS = 'A'
    AND R.STATUS = 'COMPLETED';


-- Para archive
-- Colocar o Alerta: "Last Backup Archive > 1h" 
-- Deve alarmar quando o valor for maior que 1h
-- Como o archive roda de hora em hora, precia validar a cada 2h
SELECT
    --CAST(((CAST(BS.COMPLETION_TIME AS DATE) - DATE '1970-01-01') * 86400) AS NUMERIC) AS LAST_ARCH,
    ((SYSDATE - CAST(BS.COMPLETION_TIME AS DATE)) * 24) AS HOURS_SINCE_LAST_BACKUP_ARH
FROM
    V$BACKUP_SET BS
WHERE
    BS.BACKUP_TYPE = 'L'
ORDER BY
    BS.COMPLETION_TIME DESC
FETCH FIRST 1 ROWS ONLY;


SELECT
    ROUND((SYSDATE - CAST(MAX(BSD.COMPLETION_TIME) AS DATE)) * 24, 1) AS HOURS_SINCE_LAST_BACKUP_LV0_SUCCESS
FROM
    V$BACKUP_SET_DETAILS BSD
JOIN
    V$RMAN_BACKUP_JOB_DETAILS R
        ON BSD.SESSION_KEY = R.SESSION_KEY
WHERE
    BSD.BACKUP_TYPE = 'L'
    AND BSD.STATUS = 'A'
    AND R.STATUS = 'COMPLETED';


    SELECT
    CAST(((CAST(MAX(BSD.COMPLETION_TIME) AS DATE) - DATE '1970-01-01') * 86400) AS NUMERIC) AS LAST_INC0,
    ROUND((SYSDATE - CAST(MAX(BSD.COMPLETION_TIME) AS DATE)) * 24, 1) AS HOURS_SINCE_LAST_BACKUP_LV0_SUCCESS
FROM
    V$BACKUP_SET_DETAILS BSD
JOIN
    V$RMAN_BACKUP_JOB_DETAILS R
        ON BSD.COMPLETION_TIME BETWEEN R.START_TIME AND R.END_TIME
WHERE
    BSD.BACKUP_TYPE = 'I'
    AND BSD.INCREMENTAL_LEVEL = 0
    AND BSD.STATUS = 'AVAILABLE'
    AND R.STATUS = 'COMPLETED';
    
    ---
    
    
SELECT
    CAST(((CAST(MAX(BSD.COMPLETION_TIME) AS DATE) - DATE '1970-01-01') * 86400) AS NUMERIC) AS LAST_INC0,
    ROUND((SYSDATE - CAST(MAX(BSD.COMPLETION_TIME) AS DATE)) * 24, 1) AS HOURS_SINCE_LAST_BACKUP_LV0_SUCCESS
FROM
    V$BACKUP_SET_DETAILS BSD
JOIN
    V$RMAN_BACKUP_JOB_DETAILS R
        ON BSD.SESSION_KEY = R.SESSION_KEY
WHERE
    BSD.BACKUP_TYPE = 'I'
    AND BSD.INCREMENTAL_LEVEL = 0
    AND BSD.STATUS = 'A'
    AND R.STATUS = 'COMPLETED';
    
    
--- // ---

select * from (
select case
    when status = 'COMPLETED' then 1
    when status = 'FAILED' then -1
    when status like 'WITH WARNINGS'  then 2
    when status like 'WITH ERRORS'  then 3
    else 0 end
from v$rman_status
where trunc(start_time) = trunc(sysdate-{$ORACLE_BACKUP_HOUR}/24) and operation = 'BACKUP' and (object_type='DB INCR' or object_type='INCR')
order by start_time asc)
Where rownum=1;