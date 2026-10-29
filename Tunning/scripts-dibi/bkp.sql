/* 
Script para gerar relatório de backup do banco de dados Oracle.
   Autor: Lucas de Souza Melo
   Data: 23/04/2025
   Descrição: 
   Script para gerar relatório de backup do banco de dados Oracle.
   O script gera um relatório com as informações de backup, como data/hora de início e fim, 
   status, tipo de dispositivo, quantidade de dados copiados, entre outros.

   Uso:
   Para executar o script, basta rodar a consulta e informar o número de dias que deseja 
   verificar os backups. Exemplo: 7 para verificar os backups dos últimos 7 dias.

   Exemplo de execução:
   SQL> @bkp.sql 7

   Observação:
   O script deve ser executado em um ambiente Oracle com acesso à view V$RMAN_STATUS.

*/

col inicio for a15
col final for a15
col status for a24
set colsep '|'
col SESSION_STAMP for 9999999999
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
WHERE start_time > sysdate - &1
and OPERATION='BACKUP' 
ORDER  BY start_time ASC;