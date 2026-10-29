-- Verifica o STATUS do BACKUP RMAN

set pages 9999
set lines 200
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
col STATUS for a50
col inicio for a15
col final for a15
prompt Verificar o backup do banco de dados
SELECT TO_CHAR(start_time,'DD/MM HH24:MI dy') BEGIN, TO_CHAR(end_time,'DD/MM HH24:MI dy') END, operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE
FROM   V$RMAN_STATUS
WHERE  start_time > SYSDATE -1
AND OPERATION='BACKUP'
ORDER  BY END_TIME DESC;
/