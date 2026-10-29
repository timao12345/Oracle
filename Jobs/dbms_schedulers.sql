begin
    dbms_scheduler.create_job (
    job_name        => 'IM4238084_KILL_SESSIONS',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 
'BEGIN
  for i in (
select sid, serial#, inst_id
from gv$session
where username='GED_PRD' 
  and machine='LASA-GEDAPP1'
  and status='INACTIVE'
  and last_call_et>600
)
  LOOP
    execute immediate 'alter system kill session '||''''||i.sid||','||i.serial#||',@'||i.inst_id||''''||' immediate';
  END LOOP;
END;
',
    start_date      => to_date('23/01/2015 23:00:00','dd/mm/yyyy hh24:mi:ss'),
    end_date        => NULL,
    repeat_interval => 'freq=MINUTELY; interval=60',
    auto_drop       => FALSE,
    enabled         => TRUE,
    comments        => 'Encerra Inativos por mais de 10 minutos, referente IM4238084');
end;
/


SQL> SELECT OWNER, JOB_NAME, JOB_ACTION FROM dba_scheduler_jobs where JOB_NAME='ANALYZE_FULL'
  2  ;

OWNER                          JOB_NAME                       JOB_ACTION
------------------------------ ------------------------------ --------------------------------------------------
SYSTEM                         ANALYZE_FULL
                                                              begin


                                                              dbms_stats.gather_database_stats(
                                                              granularity=> 'ALL',
                                                              block_sample=> FALSE,
                                                              cascade=> TRUE,
                                                              degree=> 1,
                                                              method_opt=> 'FOR ALL INDEXED COLUMNS SIZE AUTO',
                                                              options=> 'GATHER');

                                                              DBMS_STATS.GATHER_DICTIONARY_STATS (
                                                              estimate_percent =>100,
                                                              block_sample=>FALSE,
                                                              method_opt=>'for all columns size auto',
                                                              degree=>null,
                                                              cascade=>true,
                                                              no_invalidate=>false,
                                                              options=>'GATHER'
                                                              );
                                                              end;



begin 
  sys.dbms_scheduler.run_job('ColetarEstatistica',TRUE); 
end;



exec dbms_scheduler.run_job('CONSINCOMONITOR.ColetarEstatistica',TRUE); 


SELECT LOG_ID,to_char(log_date,'DD/MM/YY HH24:mi:ss') LOG_DATE, OWNER, JOB_NAME, STATUS,ADDITIONAL_INFO FROM DBA_SCHEDULER_JOB_RUN_DETAILS WHERE additional_info IS NOT NULL ORDER BY log_date DESC;

select OWNER,JOB_NAME,to_char(LOG_DATE,'dd/mm/yyyy hh24:mi:ss'),STATUS,RUN_DURATION,ADDITIONAL_INFO from DBA_SCHEDULER_JOB_RUN_DETAILS where JOB_NAME='JOB_SOL' order by 3;

select 
OWNER,
JOB_NAME,
to_char(LOG_DATE,'dd/mm/yyyy hh24:mi:ss'),
STATUS,
RUN_DURATION,
ADDITIONAL_INFO 
from DBA_SCHEDULER_JOB_RUN_DETAILS 
where LOG_DATE BETWEEN TO_DATE('01/02/2015 00:00:00','dd/MM/yyyyHH24:mi:ss') 
AND TO_DATE('25/02/2015 23:59:59','dd/MM/yyyy HH24:mi:ss') 
AND  JOB_NAME='JOB_SOL_AVULSA' 
order by to_char(LOG_DATE,'dd/mm/yyyy hh24:mi:ss') asc;

select owner, job_name, job_type, job_action, start_date, repeat_interval, end_date, enabled, last_start_date, next_run_date from dba_scheduler_jobs 
where JOB_NAME in ('ALUNOS_MENSAL','ALUNOS_DIARIO','CANDIDATO_DIARIO') order by 3;

select owner, job_name, job_action, enabled from dba_scheduler_jobs 
where JOB_NAME in ('ALUNOS_MENSAL','ALUNOS_DIARIO','CANDIDATO_DIARIO') order by 3;

select owner, job_name, job_action, enabled from dba_scheduler_jobs 
where JOB_NAME in ('JOB_SESSION_MANAGER') order by 3;
 
BEGIN 
  DBMS_SCHEDULER.ENABLE('ELMAH.JOB_LIMPEZA_LOGS_ANTIGOS');
END;

BEGIN 
  DBMS_SCHEDULER.DISABLE('ELMAH.JOB_LIMPEZA_LOGS_ANTIGOS');
END;


BEGIN 
  DBMS_SCHEDULER.DISABLE('LEONARDO.EXPURGO_LOG_TAB_IMP');
END;


BEGIN 
  DBMS_SCHEDULER.DISABLE('NICOLAS.JOB_GERA_LOTE');
END;


BEGIN 
  DBMS_SCHEDULER.DISABLE('SIA.ALUNOS_DIARIO');
END;

BEGIN 
  DBMS_SCHEDULER.DISABLE('SIA.ALUNOS_MENSAL');
END;



BEGIN 
  DBMS_SCHEDULER.DISABLE('ENPGIA.JOB_SOL');
END;

BEGIN 
  DBMS_SCHEDULER.ENABLE('ENPGIA.JOB_SOL');
END;
/


BEGIN 
dbms_scheduler.STOP_JOB(job_name=>'ENPGIA.JOB_SOL', force=>true);
END;

BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name => 'ENPGIA.JOB_SOL', attribute => 'repeat_interval', value => 'freq=daily;byday=FRI,SAT;byhour=20;byminute=0; 
bysecond=0');
END;

BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name => 'ENPGIA.JOB_SOL', attribute => 'repeat_interval', value => 'freq=Minutely; interval=5');
END;
/


SQL> BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE ( name => 'ENPGIA.JOB_SOL', attribute => 'repeat_interval', value => 'freq=Minutely; interval=5');
END;
/
  2    3    4
PL/SQL procedure successfully completed.

SQL> SELECT OWNER, JOB_NAME, REPEAT_INTERVAL, LAST_START_DATE, NEXT_RUN_DATE, ENABLED FROM dba_scheduler_jobs WHERE JOB_NAME='JOB_SOL';

OWNER                          JOB_NAME                       REPEAT_INTERVAL                                                                  LAST_START_DATE                                         NEXT_RUN_DATE                                                        ENABL
------------------------------ ------------------------------ -------------------------------------------------------------------------------- --------------------------------------------------------------------------- --------------------------------------------------------------------------- -----
ENPGIA                         JOB_SOL                        freq=Minutely; interval=5                                                        27/02/15 20:34:40,005980 -02:00                         27/02/15 20:35:43,000000 -02:00                                              FALSE

