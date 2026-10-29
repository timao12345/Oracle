CREATE OR REPLACE EDITIONABLE PROCEDURE "SYS"."PROC_KILL_USER_OCIOSO" AS
BEGIN
  for i in (
SELECT   s.INST_ID
        ,s.sid
        ,s.serial#
        ,s.username
        ,s.osuser
        ,(last_call_et / 60) "Min_Inactive"
        ,s.PROGRAM
  from  gv$session s
  where  s.sql_id is null
  and    s.type !='BACKGROUND' 
  AND    s.STATUS  = 'INACTIVE'
  AND    s.last_call_et > 3600
  AND    S.USERNAME NOT IN ('KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN',
  'USR_DSTAGE','SYSESTUDO','USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','PETERSON','LUCAS','USR_REPLICA_CDC_TESTE','SYSRAC')
ORDER  BY s.last_call_et DESC
)
  LOOP
    execute immediate 'alter system kill session '||''''||i.sid||','||i.serial#||',@'||i.inst_id||''''||' immediate';
  END LOOP;
END;
/

-- SCHEDULER ANTIGO
BEGIN
dbms_scheduler.create_job('"JOB_USER_OCIOSO"',
job_type=>'STORED_PROCEDURE', 
job_action=>'auditoria.VERIFICA_USER_OCIOSO', 
number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('19-APR-2021 11.26.00.000000000 AM -03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'),
repeat_interval=>'Freq=MINUTELY;Interval=15', 
end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', 
enabled=>FALSE, 
auto_drop=>TRUE,
comments=>'Job para cancelamento das sessoes com mais de 3 horas de ociosidade'
);

-- Desabilitar o scheduler AUDITORIA.JOB_USER_OCIOSO, dropar o scheduler AUDITORIA.JOB_USER_OCIOSO apos 1 semana com o novo funcionando.
exec DBMS_SCHEDULER.disable ('AUDITORIA.JOB_USER_OCIOSO');

-- criar novo scheduler.
begin
DBMS_SCHEDULER.create_job (
    job_name        => 'KILL_USER_OCIOSO',
    job_type        => 'PLSQL_BLOCK',
    job_action      =>  'begin 
                         PROC_KILL_USER_OCIOSO;
                         end;',
    start_date      => '27-JUN-24 02.00.00 PM',
    repeat_interval => 'Freq=MINUTELY;Interval=15',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'Rotina para realizar kill em sessoes com status de inatividade a mais de 1h');
end;
/

-- modificar job
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE
  (
   NAME         =>  'sys.KILL_USER_OCIOSO',
   ATTRIBUTE    =>  'start_date',
   VALUE        =>  '27-JUN-24 01.30.00 PM'
  );
END;
/