col inicio for a15
col final for a15
col status for a15
set colsep |
col SESSION_STAMP for 9999999999
set pages 400
set lines 200
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
prompt Verificar o backup do banco de dados Verificar o backup do banco de dados
SELECT TO_CHAR(start_time,'DD/MM HH24:MI:ss') INICIO, TO_CHAR(end_time,'DD/MM HH24:MI:ss') FINAL, 
operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE,
SESSION_STAMP FROM V$RMAN_STATUS WHERE start_time > SYSDATE -5 AND OPERATION='BACKUP' /*AND OBJECT_TYPE LIKE '%ARC%' */ORDER  BY start_time ASC 
/

set pages 9999
set lines 200
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
col STATUS for a50
col inicio for a15
col final for a15
col status for a15
col begin for a20
col end for a20
prompt Verificar o backup do banco de dados
SELECT TO_CHAR(start_time,'DD/MM HH24:MI dy') BEGIN, TO_CHAR(end_time,'DD/MM HH24:MI dy') END, SESSION_STAMP,operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE
FROM   V$RMAN_STATUS
WHERE  start_time > SYSDATE -10
AND OPERATION='BACKUP'
ORDER  BY END_TIME ASC
/

select output from v$rman_output where session_stamp='987552322';