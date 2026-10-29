-- Verifica o STATUS do BACKUP RMAN

set pages 200
set lines 400
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
col inicio for a15
col final for a15
col status for a26
prompt Verificar o backup do banco de dados
SELECT /*+ rule */  TO_CHAR(start_time,'DD/MM HH24:MI') INICIO, TO_CHAR(end_time,'DD/MM HH24:MI') FINAL, operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE
FROM   V$RMAN_STATUS
WHERE  start_time > SYSDATE -10
AND OPERATION='BACKUP'
ORDER  BY END_TIME DESC
/



