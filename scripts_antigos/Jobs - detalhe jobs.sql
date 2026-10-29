ALTER SESSION SET NLS_DATE_FORMAT='DD:MM:YYYY:HH24:MI:SS';
col OWNER for a20
col JOB_NAME for a20
col START_DATE for a20
col END_DATE for a20
col ENABLED  for a20
col RUN_COUNT for a15
col RUN_DURATION for a30
col ADDITIONAL_INFO for a30
col ACTUAL_START_DATE for a35 
col STATUS for a8
SELECT JOB_NAME,OWNER,STATUS,ERROR#,RUN_DURATION,ACTUAL_START_DATE,ADDITIONAL_INFO
FROM DBA_SCHEDULER_JOB_RUN_DETAILS 
where status!='SUCCEEDED' 
and JOB_NAME LIKE 'JOB_REPESC_CAMPUS_8705%' 
and ACTUAL_START_DATE > SYSDATE -1
order by ACTUAL_START_DATE;


begin
    dbms_scheduler.run_job(
        JOB_NAME=>'SIA.JOB_REPESC_CAMPUS_8705_1017');
end;
/

/*
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'SYS.CHECK_GAP_DR',
    USE_CURRENT_SESSION => FALSE);
END;
*/

select JOB_NAME from DBA_SCHEDULER_JOBS; 

ALL_SCHEDULER_JOB_RUN_DETAILS


select object_name,object_type,owner from dba_objects where object_type ='TABLE' and object_name like '%JOB%';

select object_name,object_type,owner from dba_objects where object_name like '%JOB_REPESC_CAMPUS%';



select owner,object_name,object_type,owner from dba_objects where owner='SIA' and object_name= '%JOB%';

-- Verifica quais jobs estão rodando atualmente.

select * from DBA_JOBS_RUNNING;

-- // --

select log_date,owner,job_name,status,error#,additional_info from dba_scheduler_job_run_details where log_Date>sysdate-1 order by log_date;

select log_date,owner,job_name,status,error#,additional_info,SESSION_ID from dba_scheduler_job_run_details where log_Date>sysdate-2 and status <> 'SUCCEEDED' order by log_date;

select log_date,owner,job_name,status,error#,additional_info,SESSION_ID from dba_scheduler_job_run_details where log_Date>sysdate-2 and status= 'STOPPED' order by log_date;

select log_date,owner,job_name,status,error#,additional_info, count(4) from dba_scheduler_job_run_details where log_Date>sysdate-1 and status like '%SUCCEEDED%' 
group by log_date,owner,job_name,status,error#,additional_info 
order by log_date,owner,job_name,status,error#,additional_info;



--OBS 
-- A Package DBMS_METADATA não pode ser usada para capturar o DDL dos jobs agendados(scheduled) usando DBMS_JOB
select dbms_metadata.get_ddl('PROCOBJ','CHECK_GAP_DR') from dual;

SELECT dbms_metadata.get_ddl('PROCOBJ','CHECK_GAP_DR','SYS') from dual;


Currently DBMS_METADATA does not support the new 'job' type created by DBMS_SCHEDULER.

To Workaround this,

Use As SELECT dbms_metadata.get_ddl('PROCOBJ','YOURJOBNAME', 'YOURJOBOWNER') from dual;

Example:
SQL> select dbms_metadata.get_ddl('PROCOBJ','SCHED_EV_CTX$7','Scott') ddl_text from dual;

Note: This workaround will not work for SYS owned job because by using PROCOBJ the package is using similar functionality as which datapump export would use and as known SYS objects are marked as non-exportable
hence the error will occur
ORA-31603: object "<job_name>" of type PROCOBJ not found in schema "SYS"
 

Please note:  The DBMS_METADATA package cannot be used to capture the DDL of jobs scheduled using DBMS_JOB. We can use the following workaround to capture the DDL of jobs scheduled using DBMS_JOB.

spool on

select 'exec dbms_job.isubmit(job=>'||job||',what=>'''||what||''',next_date=>'''||next_date||''',interval=>'''||interval||''',no_parse=>TRUE);' from dba_jobs;

spool off