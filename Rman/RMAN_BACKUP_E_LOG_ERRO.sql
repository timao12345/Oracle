-- VERIFICAR OS BACKUPS

-- VER STATUS DOS BACKUP
col inicio for a15
col final for a15
col status for a25
col SESSION_STAMP for 9999999999
set pages 400
set lines 180
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
SELECT TO_CHAR(start_time,'DD/MM HH24:MI:ss') INICIO, TO_CHAR(end_time,'DD/MM HH24:MI:ss') FINAL,
operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,
SESSION_STAMP FROM V$RMAN_STATUS WHERE start_time > SYSDATE -&days AND OPERATION='BACKUP' AND OBJECT_TYPE LIKE upper('&object_type%') ORDER  BY start_time DESC;


-- VER O LOG DO BACKUP
select output from v$rman_output where session_stamp = '972832201';

--VERIFICAR A PORCENTAGEM COPIADO
select 1258778.88/1655915 from dual;
