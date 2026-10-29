-- insert em uma tabela de log usando um dblink para homolog
create or replace procedure proc_kill_lock_inativa_5min
is
  sess varchar2(20);
  sessinfo varchar2(60);
  serialinfo number;
  machineinfo varchar2(60);
  usernameinfo varchar2(50);
  osuserinfo varchar2(50);
begin
  for i in
    (with lk as 
      (select blocking_instance||'.'||blocking_session blocker, inst_id||'.'||sid waiter,type,sql_id,status,seconds_in_wait
       from gv$session 
       where blocking_instance is not null 
       and blocking_session is not null and seconds_in_wait >300)
     select distinct blocker from lk where blocker not in (select waiter from lk)
    )
  loop
    select regexp_substr(i.blocker,'[0-9]+$')||','||serial# ||',@' || regexp_substr(i.blocker,'[0-9]+'),      
           substr(username||' - '||program,1,50),
           machine,
           username,
           osuser,
           serial#
    into sess, 
         sessinfo,
         machineinfo,
         usernameinfo,
         osuserinfo,
         serialinfo
    from gv$session where inst_id = regexp_substr(i.blocker,'[0-9]+') and sid = regexp_substr(i.blocker,'[0-9]+$')
    and type !='BACKGROUND' 
    and sql_id is null 
    and status='INACTIVE'
    and SECONDS_IN_WAIT > 300
    and username not in ('PETERSON','KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN','USR_DSTAGE','SYSESTUDO','USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','USR_REPLICA_CDC_TESTE','SYSRAC');


    execute immediate 'alter system kill session ''' || sess || ''' immediate';
    
  end loop;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    sess := NULL;
    sessinfo := NULL;

end;
/


--criar tabela em homolog que irá receber o log. (já criado)
create table lucas.kill_lock_log (
  inst_bloqueador number,
  sid_bloqueador number,
  serial_bloqueador number,
  machine_bloqueador varchar2 (200),
  username_bloqueador varchar2 (200),
  osuser_bloqueador varchar2 (200),
  data_kill date
);

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY HH24:MI';
select * from lucas.kill_lock_log@LOG_KILL;

create table lucas.kill_lock_teste (
  nome varchar2(10)
);

create table lucas.kill_lock_teste2 (
  nome2 varchar2(10)
);


insert into lucas.kill_lock_teste values ('teste1');
insert into lucas.kill_lock_teste values ('teste2');

update lucas.kill_lock_teste set nome = 'teste3' where nome = 'teste1';
commit;
-- scheduler kill sessão inativa causando lock no BD
--nome do scheduler de teste KILL_LOCK_INATIVA

begin
DBMS_SCHEDULER.create_job (
    job_name        => 'KILL_LOCK_INATIVA',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'begin 
                        proc_kill_lock_inativa_5min;
                        end;',
    start_date      => '27-JUL-24 01.50.00 PM',
    repeat_interval => 'freq=MINUTELY; interval=10',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'Job mata sessoo causadora de lock com status de inativo a mais de 5 minutos');
end;
/

-- modificar job
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE
  (
   NAME         =>  'KILL_LOCK_INATIVA',
   ATTRIBUTE    =>  'repeat_interval',
   VALUE        =>  'freq=MINUTELY; interval=5'
  );
END;
/

BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE
  (
   NAME         =>  'KILL_LOCK_INATIVA',
   ATTRIBUTE    =>  'start_date',
   VALUE        =>  '29-JUL-24 05.20.00 PM'
  );
END;
/

