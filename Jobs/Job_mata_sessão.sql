-- Encerra Inativos por mais de 10 minutos

BEGIN
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
/


--Encerra Inativos por mais de 10 minutos

begin
    dbms_scheduler.create_job (
    job_name        => 'IM4238084_KILL_SESSIONS',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 
'BEGIN
  for i in (
select sid, serial#, inst_id
from gv$session
where username=''GED_PRD'' 
  and machine=''LASA-GEDAPP1''
  and status=''INACTIVE''
  and last_call_et>600
)
  LOOP
    execute immediate ''alter system kill session ''||''''||i.sid||'',''||i.serial#||'',@''||i.inst_id||''''||'' immediate'';
  END LOOP;
END;
',
    start_date      => to_date('23/01/2015 23:00:00','dd/mm/yyyy hh24:mi:ss'),
    end_date        => NULL,
    repeat_interval => 'freq=MINUTELY; interval=10',
    auto_drop       => FALSE,
    enabled         => TRUE,
    comments        => 'Encerra Inativos por mais de 10 minutos');
end;
/
