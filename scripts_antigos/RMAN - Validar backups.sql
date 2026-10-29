-- Validar backups RMAN --

col start_time for a30
col end_time for a30
col OUTPUT_BYTES_DISPLAY for a30
col TIME_TAKEN_DISPLAY for a30
set lines 300
set pages 500
select session_key,
       input_type,
       status,
       to_char(start_time,'yyyy-mm-dd hh24:mi') start_time,
       to_char(end_time,'yyyy-mm-dd hh24:mi')   end_time,
       output_bytes_display,
       time_taken_display
from v$rman_backup_job_details
where start_time > SYSDATE -5
order by session_key asc;



-- Versão 8i e 9i
set linesize 150
set pagesize 1000
col device_type for a15
col handle for a40
col tag for a20
col status for a10
col media for a10
col comments for a30
select recid, device_type, handle, tag, status,media, deleted,start_time, completion_time, elapsed_seconds from V$BACKUP_PIECE where start_time > SYSDATE -2;



 select owner, sum(bytes) from dba_segments where owner like '%DBIWMATRIZDATA%' group by owner;