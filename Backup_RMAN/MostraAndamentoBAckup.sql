col inicio for a15
col final for a15
col status for a20 word_w
set pages 200
set lines 200
COL OPERATION FORMAT A10 TRUNC
COL GB_COPIADOS FORMAT 9,999,999.99
col global_name head "Verificar o backup do banco de dados" for a40 word_w
select * from global_name ;
SELECT TO_CHAR(start_time,'DD/MM/YY HH24:MI') INICIO, TO_CHAR(end_time,'DD/MM/YY HH24:MI') FINAL, operation,OBJECT_TYPE, status,OUTPUT_DEVICE_TYPE DEVICE, mbytes_processed MB_COPIADOS,OUTPUT_DEVICE_TYPE
FROM   V$RMAN_STATUS
WHERE  start_time > SYSDATE -5
AND OPERATION='BACKUP'
AND object_type like '%FULL%'
ORDER  BY TO_CHAR(start_time,'DD/MM HH24:MI') DESC;

