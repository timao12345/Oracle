-- listar os backups via RMAN organizado.

rman> list backup summary;


CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 8 DAYS;
CONFIGURE RETENTION POLICY TO REDUNDANCY 120;

DELETE ARCHIVELOG UNTIL time "SYSDATE - interval '1' hour" BACKED UP 1 TIMES to DEVICE TYPE sbt;

-- Verifica todos os backups e o STATUS dos BACKUP RMAN
col inicio for a15
col final for a15a
col status for a24
set colsep '|'
col SESSION_STAMP for 99999999990
set pagesize 50000
set lines 200
col DEVICE for a11
col STATUS for a35
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
SELECT TO_CHAR(start_time,'DD/MM HH24:MI:ss') INICIO, TO_CHAR(end_time,'DD/MM HH24:MI:ss') FINAL, 
      operation,OBJECT_TYPE, 
      status,
      OUTPUT_DEVICE_TYPE DEVICE, 
      mbytes_processed/1024 GB_COPIADOS,    
      SESSION_STAMP,
      SESSION_RECID,
      SID
FROM V$RMAN_STATUS 
WHERE start_time > sysdate - 3
and OPERATION='BACKUP' 
AND OBJECT_TYPE ='DB INCR' 
--AND OBJECT_TYPE LIKE '%CONTROLFILE%' 
ORDER  BY start_time ASC;

--Verifica todos backups
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
where start_time > SYSDATE - 30
and INPUT_TYPE like 'DB%'
order by session_key asc; 

-- verifica porcentagem do backup completado calculando pelo tamanho total do banco de dados.
COL DBSIZE_GB          FOR A10     HEAD "DBSIZE"
COL INPUT_GB           FOR A9     HEAD "READ"
COL OUTPUT_GB          FOR A9     HEAD "WRITTEN"
COL OUTPUT_DEVICE_TYPE FOR A16     HEAD "DEVICE"
COL COMPLETE           FOR A9     HEAD "COMPLETE"
COL COMPRESSION        FOR A9     HEAD "COMPRESS" JUSTIFY RIGHT
COL EST_COMPLETE       FOR A20    HEAD "ESTIMATED_FINISH"
COL STATUS             FOR A8     HEAD "STATUS"
SELECT OUTPUT_DEVICE_TYPE
, STATUS
, FLOOR(DBSIZE_GB)||'G' DBSIZE_GB
, FLOOR(INPUT_BYTES/1024/1024/1024)||'G' INPUT_GB
, FLOOR(OUTPUT_BYTES/1024/1024/1024)||'G' OUTPUT_GB
, ROUND(OUTPUT_BYTES/INPUT_BYTES*100,2)||'%' COMPRESSION
, ROUND((MBYTES_PROCESSED/1024)/DBSIZE_GB*100,2)||'%' COMPLETE
, TO_CHAR(START_TIME + (SYSDATE-START_TIME)/((MBYTES_PROCESSED/1024)/DBSIZE_GB),'DD-MON-YYYY HH24:MI:SS') EST_COMPLETE
FROM V$RMAN_STATUS RS
, (SELECT SUM(BYTES)/1024/1024/1024 DBSIZE_GB FROM V$DATAFILE)
WHERE STATUS='RUNNING'
AND OUTPUT_DEVICE_TYPE IS NOT NULL
/

-- Estima tempo de restore 
COL DBSIZE_GB          FOR A10     HEAD "DBSIZE"
COL INPUT_GB           FOR A9     HEAD "READ"
COL OUTPUT_GB          FOR A9     HEAD "WRITTEN"
COL OUTPUT_DEVICE_TYPE FOR A16     HEAD "DEVICE"
COL COMPLETE           FOR A9     HEAD "COMPLETE"
COL COMPRESSION        FOR A9     HEAD "COMPRESS" JUSTIFY RIGHT
COL EST_COMPLETE       FOR A20    HEAD "ESTIMATED_FINISH"
COL STATUS             FOR A8     HEAD "STATUS"
SELECT OUTPUT_DEVICE_TYPE
, STATUS
, FLOOR(INPUT_BYTES/1024/1024/1024)||'G' BKP_LIDO
, FLOOR(OUTPUT_BYTES/1024/1024/1024)||'G' OUTPUT_GB
, ROUND((MBYTES_PROCESSED/1024)/42417*100,2)||'%' COMPLETE
, TO_CHAR(START_TIME + (SYSDATE-START_TIME)/((MBYTES_PROCESSED/1024)/42417),'DD-MON-YYYY HH24:MI:SS') EST_COMPLETE
FROM V$RMAN_STATUS RS
WHERE STATUS='RUNNING'
AND OUTPUT_DEVICE_TYPE IS NOT NULL
/

select * from V$RMAN_STATUS where STATUS='RUNNING';

alter session set nls_date_format='dd/mm/yy hh24:mi:ss';
set lines 900
col osuser format a15
col machine format a30
col message for a40
col opname for a35
col DONE format a7
col sid format 999999
col ETA for 9999999999
col Min for 9999999999
select l.SID, l.SERIAL#, s.osuser,s.machine
,l.OPNAME
, trunc(( l.sofar / l.totalwork ) * 100,2)||'%' DONE
,trunc(l.elapsed_seconds/60) "Min"
,trunc(l.time_remaining/60) "ETA"
,sysdate + TIME_REMAINING/3600/24 end_at
from gV$SESSION_LONGOPS l,
gv$session s
where l.SOFAR < l.TOTALWORK
and l.sid = s.sid and l.inst_id=s.inst_id
and l.serial# = s.serial# and upper(l.opname) like '%RMAN%'
-- and s.osuser <> 'delphix_os'
order by l.username
;

set pages 200
set lines 200
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
col inicio for a15
col final for a15
col status for a10
SELECT TO_CHAR(start_time,'DD/MM HH24:MI') INICIO, TO_CHAR(end_time,'DD/MM HH24:MI') FINAL, operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE
FROM   V$RMAN_STATUS
WHERE STATUS='RUNNING'
ORDER  BY END_TIME DESC
/

-- Backups de Archived Redo Logs
SET PAGES 1000
SET LINES 210
COL STATUS FORMAT A30
COL HRS FORMAT 999.99

SELECT
INPUT_TYPE, STATUS,
TO_CHAR(START_TIME,'DD/MM/YYYY HH24:MI') START_TIME,
TO_CHAR(END_TIME,'DD/MM/YYYY HH24:MI') END_TIME,
ELAPSED_SECONDS/3600 HRS,
SESSION_RECID,
SESSION_STAMP
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE INPUT_TYPE='ARCHIVELOG'
ORDER BY SESSION_KEY;


-- Ver o log:
select output from gv$rman_output where session_stamp = '1247695308';
select * from v$rman_output where session_stamp = '1196805646';

309768

--like '&session_stamp%'

select SESSION_RECID from v$rman_output where SESSION_RECID='24625';


SELECT FILE#, INCREMENTAL_LEVEL, COMPLETION_TIME, BLOCKS, DATAFILE_BLOCKS 
FROM V$BACKUP_DATAFILE 
WHERE INCREMENTAL_LEVEL > 0 
AND BLOCKS / DATAFILE_BLOCKS > 5 
ORDER BY COMPLETION_TIME;

-- Alternativa verifica backups
set lines 300
set pages 1000
col start_time for a20
col end_time for a20
col dow for a10
col output_mbytes for 9,999,999 heading "OUTPUT|MBYTES"
col elapsed_seconds heading "ELAPSED|SECONDS"
col time_taken_display for a10 heading "TIME|TAKEN"
select
  j.session_recid,
  j.session_stamp,
  to_char(j.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
  to_char(j.end_time, 'yyyy-mm-dd hh24:mi:ss') end_time,
  (j.output_bytes / 1024 / 1024) output_mbytes,
  j.status,
  j.input_type,
  decode(
    to_char(j.start_time, 'd'),
    1, 'Sunday',
    2, 'Monday',
    3, 'Tuesday',
    4, 'Wednesday',
    5, 'Thursday',
    6, 'Friday',
    7, 'Saturday'
  ) dow,
  j.elapsed_seconds,
  j.time_taken_display
from
  V$RMAN_BACKUP_JOB_DETAILS j
where
  j.start_time > trunc(sysdate) - &NUMBER_OF_DAYS
  and j.input_type like 'DB%'
order by
  j.start_time;


LIST BACKUP OF ARCHIVELOG FROM TIME '2026-05-09' UNTIL TIME '2026-05-15';
list backup of archivelog all summary completed between "05-09-2026" and "05-15-2026";