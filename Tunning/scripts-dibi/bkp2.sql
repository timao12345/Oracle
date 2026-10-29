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
   SQL> @bkp2.sql 7

   Observação:
   O script deve ser executado em um ambiente Oracle com acesso à view V$RMAN_STATUS.

*/
col start_time for a30
col end_time for a30
col OUTPUT_BYTES_DISPLAY for a30
col TIME_TAKEN_DISPLAY for a30
set lines 300
set pages 500
set colsep '|' 
select session_key,
       input_type,
       status,
       to_char(start_time,'yyyy-mm-dd hh24:mi') start_time,
       to_char(end_time,'yyyy-mm-dd hh24:mi')   end_time,
       output_bytes_display,
       time_taken_display
from v$rman_backup_job_details
where start_time > SYSDATE - &1
order by session_key asc; 