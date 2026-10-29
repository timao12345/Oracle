COL INICIO FOR A15
COL FINAL FOR A15
COL STATUS FOR A25
COL SESSION_STAMP FOR 9999999999
SET PAGES 400
SET LINES 180
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
SET PAGES 500 LINES 300
COL HOST_NAME FOR A20
COL STARTUP_TIME FOR A20
clear columns
column tablespace format a30
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
column status format a10
compute sum of total_mb on report
compute sum of used_mb on report
compute sum of free_mb on report
break on report
column file_name format a80
col MAXBYTES for 9999999999999
col log_date for a36
col owner for a20
col job_name for a40
col status for a12
col error# 999999
col additional_info for a70


ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI';

SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON

SPOOL check-list-db-&&nome_base
prompt
prompt ===================================================================
prompt DATABASE &&nome_base STATUS
prompt ===================================================================
prompt
SELECT DISTINCT INSTANCE_NAME,I.HOST_NAME,I.STARTUP_TIME,D.LOG_MODE,I.STATUS,I.LOGINS,D.OPEN_MODE,D.DATABASE_ROLE,SYSDATE FROM GV$INSTANCE I,GV$DATABASE D ORDER BY 1;
prompt
prompt
prompt ===================================================================
prompt TABLESPACES
prompt ===================================================================
prompt
select  total.ts tablespace,
        DECODE(total.mb,null,'OFFLINE',dbat.status) status,
	total.mb total_mb,
	NVL(total.mb - free.mb,total.mb) used_mb,
	NVL(free.mb,0) free_mb,
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used
from
	(select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
	(select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
where total.ts=free.ts(+) and
      total.ts=dbat.tablespace_name
UNION ALL
select  sh.tablespace_name,
        'TEMP',
	SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
	SUM(sh.bytes_used)/1024/1024 used_mb,
	SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used
FROM v$temp_space_header sh
GROUP BY tablespace_name
order by 6
/
prompt
prompt
prompt ===================================================================
prompt DATAFILES
prompt ===================================================================
prompt
select tablespace_name,file_id, file_name,status, bytes/1024/1024 "SIZE MB" , AUTOEXTENSIBLE,MAXBYTES,INCREMENT_BY,STATUS
from dba_data_files
order by 1,2
/
prompt
prompt
prompt ===================================================================
prompt TEMPFILES
prompt ===================================================================
prompt
select tablespace_name,file_id, file_name,status, bytes/1024/1024 "SIZE MB" , AUTOEXTENSIBLE,MAXBYTES,INCREMENT_BY,STATUS
FROM DBA_TEMP_FILES
ORDER BY 1,2
/
prompt
prompt
prompt ===================================================================
prompt BACKUPS
prompt ===================================================================
prompt
SELECT TO_CHAR(START_TIME,'DD/MM HH24:MI:SS') INICIO, TO_CHAR(END_TIME,'DD/MM HH24:MI:SS') FINAL,
OPERATION,OBJECT_TYPE, STATUS,OUTPUT_DEVICE_TYPE DEVICE, MBYTES_PROCESSED MB_COPIADOS,
SESSION_STAMP FROM V$RMAN_STATUS WHERE START_TIME > SYSDATE -1 AND OPERATION='BACKUP' ORDER BY START_TIME DESC;
prompt
prompt
prompt ===================================================================
prompt SESSIONS
prompt ===================================================================
prompt
select inst_id,username,max(logon_time) as "LAST LOGIN",count(*) from gv$session where username is not null group by inst_id,username,status order by 1,2,3;
prompt
prompt
prompt ===================================================================
prompt LOCKS
prompt ===================================================================
prompt
set pages 80
SELECT inst_id,
	   substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
       id1, id2, lmode, request, type
FROM GV$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
     ORDER BY id1, request;
prompt
prompt
prompt ===================================================================
prompt JOBS
prompt ===================================================================
prompt
select log_date,owner,job_name,status,error#,additional_info from dba_scheduler_job_run_details where log_Date>sysdate-2 order by log_date;
prompt
spool off
