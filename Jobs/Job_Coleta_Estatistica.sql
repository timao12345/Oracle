BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
               job_name => 'COLETA_STATS_FULL'
              ,job_type => 'PLSQL_BLOCK'
               ,job_action => 'BEGIN DBMS_STATS.GATHER_DATABASE_STATS(ESTIMATE_PERCENT=>100, CASCADE => TRUE, degree => 8, GATHER_SYS => TRUE);END;'
               ,start_date => TO_TIMESTAMP_TZ('2015-06-11 22:35:00 America/Sao_Paulo','YYYY-MM-DD HH24.MI.SS TZR')
               ,repeat_interval => 'FREQ=WEEKLY;BYDAY=SUN;BYHOUR=3'
               ,enabled => FALSE
               ,comments => 'Coleta de Estatistica Full');
END;
/