-- criar scheduler job para criar snaphots de hora em hora (a partir da proxima hora):
begin
    dbms_scheduler.create_job(
    job_name => 'PERFSTAT.JOB_STATSPACK_SNAPSHOT',
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin statspack.snap; end;',
    start_date => TO_TIMESTAMP_TZ(trunc(sysdate)),
    repeat_interval => 'FREQ=hourly; INTERVAL=1;',
    comments => 'Job para criar snapshots de hora em hora',
    enabled => TRUE);
end;
/

-- Apagar job:
EXEC dbms_scheduler.DROP_job(job_name => 'PERFSTAT.JOB_STATSPACK_SNAPSHOT');


-- Criar job para apagar snapshots mais velhos que 30 dias:
begin
    dbms_scheduler.create_job(
    job_name => 'PERFSTAT.JOB_STATSPACK_PURGE',
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin statspack.purge(30); end;',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=daily; byhour=23;',
    comments => 'Job para apagar snapshots mais velhos que 30 dias',
    enabled => TRUE);
end;
/


-- Alterando o nivel de informacoes na coleta (valor padrao igual a 5):
execute statspack.snap(i_snap_level=>7);


-- Ver informacoes sobre os niveis de coleta:
SELECT * FROM stats$level_description ORDER BY snap_level;
/*
Overview of the SNAP level
    4 General Performance Statistics
    5 Same as Level 4 but including performance-intensive SQL statements
    6 Same as Level 5 but with SQL plans
    7 Same as Level 6 but with Segment Statistics
    10 Same as Level 7 but with Parent and Child Latches
*/