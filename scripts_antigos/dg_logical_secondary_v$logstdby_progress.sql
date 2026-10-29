-- Verificar a data aplicada no banco através do SCN
-- Executar Standby database 
col "PROXIMO SCN SER APLICADO" for 99999999999999999999999
col "SCN APLICADO" for 99999999999999999999999
Alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SELECT APPLIED_SCN as "SCN APLICADO", APPLIED_TIME as "DATA APLICADA", LATEST_SCN as "PROXIMO SCN SER APLICADO" FROM V$LOGSTDBY_PROGRESS;
