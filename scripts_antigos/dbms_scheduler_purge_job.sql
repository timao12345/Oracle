--PURGE JOB
begin
dbms_scheduler.purge_log (
log_history => 10,
which_log => 'JOB_AND_WINDOW_LOG',
job_name => 'SUR.GERACAO_ARQUIVO_COB_REG');
end;
/ 