create table log_report_adm.job_history(
  job number not null,
  start_time date not null,
  finish_time date null,
  status varchar2(4000) null,
  constraint jobhist_pk primary key (job, start_time)
    using index tablespace tsilogreport01)
tablespace tsdlogreport01;

create index log_report_adm.jobhist_idx01 on log_report_adm.job_history (start_time) tablespace tsilogreport01;

create table log_report_adm.job_status(
  job number not null,
  last_start_time date not null,
  last_finish_time date null,
  last_status varchar2(1) not null,
  executions number(10,0) not null,
  last_call date null,
  call_interval number(6,4) null,
  call_wait_time number(6,4) null,
  constraint jobstat_pk primary key (job)
    using index tablespace tsilogreport01)
tablespace tsdlogreport01;

create or replace package log_report_adm.pkg_job as
/*******************************************************************************
*  este package contem rotinas para rastrear a execução de jobs via DBA_JOBS.  *
*******************************************************************************/

  -- Variables
  message varchar2(32000);

  procedure set_message(msg varchar2);
  function get_message return varchar2;

  function f_get_sid return number;
  /*****************************************************************************
  *  This function returns SID from current session                            *
  *****************************************************************************/

  function f_get_job return number;
  /*****************************************************************************
  *  This function returns JOBID from current session                          *
  *****************************************************************************/

  procedure check_jobs;
  /*****************************************************************************
  * Generate report for jobs with schedule or running errors (send by e-mail)  *
  *****************************************************************************/
end;
/

create or replace package body log_report_adm.pkg_job as
/*******************************************************************************
*  este package contem rotinas para rastrear a execução de jobs via DBA_JOBS.  *
*******************************************************************************/

  procedure set_message(msg varchar2) as
  begin
    message:=msg;
  end;

  function get_message return varchar2 as
  begin
    return message;
  end;

  function f_get_sid return number as
  /*****************************************************************************
  *  This function returns SID from current session                            *
  *****************************************************************************/
  -- Variables
    v_sid number;
  begin
    begin
      select sid
      into v_sid
      from v$mystat
      where
        rownum <= 1;
    exception
      when others then
        v_sid:=null;
    end;
    return v_sid;
  end;

  function f_get_job return number as
  /*****************************************************************************
  *  This function returns JOBID from current session                          *
  *****************************************************************************/
  -- Variables
    v_job number;
  begin
    begin
      select job
      into v_job
      from dba_jobs_running
      where
        sid = f_get_sid and
        rownum <= 1;
    exception
      when others then
        v_job:=null;
    end;
    return v_job;
  end;

  procedure check_jobs as
  /*****************************************************************************
  * Generate report for jobs with schedule or running errors (send by e-mail)  *
  *****************************************************************************/
  type
    ttable is table of varchar(10000);
  
    tab ttable := ttable();
    i binary_integer;
    n binary_integer := 0;
    v_qtde_err number(10,0) := 0;
    v_status varchar2(1);
    v_instance varchar2(30);  
    v_host varchar2(30);  
    
    procedure print(str varchar2) as
    begin
      n:=n+1;
      tab.extend;
      tab(n):=str;
    end;
  
    procedure check_run_job as
      v_first boolean := true;
    begin
      for row in (select job, log_user, what
                  from dba_jobs
                  where
                    interval <> 'null' and
                    lower(ltrim(what)) not like 'run_job(%') loop
        if v_first then
          print('Jobs que não utilizam a procedure RUN_JOB():');
          print(' ');
          v_first:=false;
        end if;
        print('JOB     : '||row.job);
        print('LOG_USER: '||row.log_user);
        print('WHAT    : '||row.what);
        print(' ');
        v_qtde_err:=v_qtde_err+1;
      end loop;
    end;

    procedure check_running_jobs as
      v_first boolean := true;
    begin
      for row in (with
                    hist as
                     (select
                        job, count(1) qtde, avg(finish_time-start_time) avg_exec_time, stddev(finish_time-start_time) stddev_exec_time,
                        max(finish_time-start_time) max_exec_time_5d, max(decode(sign(sysdate-start_time-1),-1,finish_time-start_time)) max_exec_time_1d,
                        nvl(greatest(2, decode(avg(finish_time-start_time), 0, 0, stddev(finish_time-start_time)/avg(finish_time-start_time))),1) stddev_factor
                      from log_report_adm.job_history
                      where
                        start_time >= sysdate-5
                      group by job)
                  select j.job, j.log_user, j.what, j.broken, j.this_date, h.qtde, h.avg_exec_time, h.stddev_exec_time, h.max_exec_time_5d, h.max_exec_time_1d, h.stddev_factor
                  from
                    hist h,
                    dba_jobs j
                  where
                    h.job (+) = j.job and
                    (j.broken = 'Y' or
                     (j.this_date is not null and
                      j.this_date < sysdate-30/24/60/60 and
                      h.job is not null and
                      (sysdate-j.this_date) > (h.avg_exec_time+h.stddev_exec_time*h.stddev_factor)))) loop
        if v_first then
          print('Jobs com status BROKEN ou rodando a mais tempo que o esperado:');
          print(' ');
          v_first:=false;
        end if;
        print('JOB     : '||row.job);
        print('LOG_USER: '||row.log_user);
        print('WHAT    : '||row.what);
        if (row.broken = 'Y') then
          print('STATUS  : BROKEN');
        else
          print('STATUS  : ACTIVE');
          print('INICIADO : '||to_char(row.this_date,'dd/mm/yyyy hh24:mi:ss')||'('||to_char(round((sysdate-row.this_date)*24*60*60,0))||' s)');
          print('EXECUCOES: '||row.qtde||' (em 5 dias)');
          print('MEDIA    : '||to_char(round(row.avg_exec_time*24*60*60,0))||' s');
          print('DESVIO   : '||to_char(round(row.stddev_exec_time*24*60*60,0))||' s');
          print('MAX 24H  : '||to_char(round(row.max_exec_time_1d*24*60*60,0))||' s');
          print('MAX 5D   : '||to_char(round(row.max_exec_time_5d*24*60*60,0))||' s');
        end if;
        print(' ');
        v_qtde_err:=v_qtde_err+1;
      end loop;
    end;

  begin
    -- Procedure de monitoração dos processos da octopus
  
    print('Inicio da analise '||TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss'));
    print('-------------------------------------');
    print(' ');
    check_run_job;
    check_running_jobs;
    print('----------------------------------');
    print('Fim da analise '||TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss'));
    print(' ');
    print('Relatorio gerado pela procedure LOG_REPORT_ADM.PKG_JOB.CHECK_JOBS.');
  
    -- Verificar se é necessário o envio do e-mail
    if (v_qtde_err > 0) then
      select host_name, instance_name
      into v_host, v_instance
      from v$instance;  
  
      pkg_email.open_connection;
      pkg_email.mail_from('< '||pkg_db_info.owner_email||' >');
      pkg_email.rcpt_to('< '||pkg_db_info.owner_email||' >');
      pkg_email.open_data;
      pkg_email.send_header('From','"'||upper(v_host)||' ('||upper(v_instance)||') - Monitoracao" <'||pkg_db_info.owner_email||'>');
      pkg_email.send_header('To','"Equipe de '||pkg_db_info.owner_group_name||'" <'||pkg_db_info.owner_email||'>');
      pkg_email.send_header('Subject','Monitoracao: '||upper(v_host)||' ('||upper(v_instance)||') - Verificacao de JOBs');
  
      i:=1;
      while (i<=n) loop
        pkg_email.write_data(tab(i));
        i:=i+1;
      end loop;
  
      pkg_email.close_mail;
      pkg_email.close_connection;
    end if;
  end; 
end;
/

create or replace trigger log_report_adm.trg_job_history_au
after update on log_report_adm.job_history
referencing new as new old as old
for each row
begin
  pkg_job.set_message(:new.status);
  update log_report_adm.job_status set
    last_start_time = :new.start_time,
    last_finish_time = :new.finish_time,
    last_status = decode(:new.status,'OK','O','E')
  where
    job = :new.job;
  if (sql%rowcount = 0) then
    insert into log_report_adm.job_status
     (job, last_start_time, last_finish_time, last_status, executions)
    values
     (:new.job, :new.start_time, :new.finish_time, decode(:new.status,'OK','O','E'), 1);
  end if;
end;
/

-- select * from dba_errors where name = 'TRG_JOB_HISTORY_AU';

create or replace trigger log_report_adm.trg_job_status_bu
before update on log_report_adm.job_status
referencing new as new old as old
for each row
declare
  -- Variables
  v_call_msg varchar2(32000);
begin
  -- If status change, reset counter.
  if (:old.last_status = :new.last_status) then
    :new.executions := :new.executions+1;
  else
    :new.executions := 1;
    :new.last_call := null;
  end if;
  -- Check call condition
  if (:new.last_status = 'E' and
      (:new.executions >= 3 or
       (:new.last_start_time - :old.last_start_time)*:new.executions > nvl(:new.call_wait_time,1/24)/3) and
      (:new.last_call is null or
       :new.last_call < (sysdate-nvl(:new.call_interval,4/24)))) then
    :new.last_call := sysdate;

    for row in (select j.log_user, j.what
                from
                  dba_jobs j
                where
                  j.job = :new.job) loop
      v_call_msg :=
        'JOB: '||:new.job||' - '||row.log_user||chr(10)||
        'WHAT: '||row.what||chr(10)||
        'LAST_DATE: '||to_char(:new.last_start_time,'dd/mm/yyyy hh24:mi:ss')||chr(10)||
        'ERROR: '||pkg_job.message;
    end loop;

    pkg_service_center.create_call(
      'infra-estrutura',
      'banco de dados',
      pkg_db_info.product_type,
      pkg_db_info.host_name,
      'oracle',
      'Monitoramento de '||pkg_db_info.owner_group_name,
      pkg_db_info.owner_email,
      pkg_db_info.owner_group,
      'Equipe de '||pkg_db_info.owner_group_name,
      pkg_db_info.owner_email,
      '2 - Medium',
      '2 - Medium',
      v_call_msg);
  end if;
end;
/

create or replace procedure log_report_adm.run_job(p_statement varchar2) authid current_user as
/*****************************************************************************
*  This procedure execute a statement and, if its a job, save job execution  *
*  info in table job_history                                                 *
*****************************************************************************/
-- Variables
  v_job number;
  v_start_time date;
  v_status varchar2(4000);
begin
  v_job:=pkg_job.f_get_job;
  if (v_job is not null) then
    v_start_time:=sysdate;
    begin
      insert into log_report_adm.job_history (job, start_time, status)
      values(v_job, v_start_time, 'Running');
      commit;
    exception
      when others then
        v_job:=null;
    end;
  end if;
  execute immediate 'begin '||p_statement||' end;';
  if (v_job is not null) then
    begin
      update log_report_adm.job_history set
        finish_time = sysdate,
        status = 'OK'
      where
        job = v_job and
        start_time = v_start_time;
      commit;
    exception
      when others then
        null;
    end;
  end if;
exception
  when others then
    if (v_job is not null) then
      begin
        v_status:=substr(sqlerrm,1,4000);
        update log_report_adm.job_history set
          finish_time = sysdate,
          status = v_status
        where
          job = v_job and
          start_time = v_start_time;
        log_report_adm.pkg_log.write('JOBHISTORY','E',0,substr('JOB: '||v_job||' ERROR: '||v_status,1,1024));
        commit;
      exception
        when others then
          null;
      end;
    end if;
end;
/

grant select, insert, update on log_report_adm.job_history to public;
grant execute on log_report_adm.pkg_job to public;
grant execute on log_report_adm.run_job to public;
create public synonym run_job for log_report_adm.run_job;
