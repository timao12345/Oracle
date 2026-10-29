USUARIO CRIADO: JBPM_HIST
PASSWORD: JBPMNOVO


$ sqlplus / AS SYSDBA
SQL> @$ORACLE_HOME/rdbms/admin/spcreate.sql
Enter value for perfstat_password: Nerv2014
Enter value for default_tablespace: SYSAUX
Enter value for temporary_tablespace: TEMP

Job de Coleta de Snapshots
$ sqlplus PERFSTAT/Nerv2014
SQL> @$ORACLE_HOME/rdbms/admin/spauto.sql

$ sqlplus PERFSTAT/Nerv2014
SQL> EXECUTE STATSPACK.SNAP;


SQL> @$ORACLE_HOME/rdbms/admin/spreport.sql
Enter value for begin_snap: 3
Enter value for end_snap: 4
Enter value for report_name: Teste01
Criando statspack


SQL> create tablespace PERSTATS datafile '+DATA' size 5g;

Tablespace created.

@spcreate
Choose the PERFSTAT user's password
-----------------------------------
Not specifying a password will result in the installation FAILING
Enter value for perfstat_password:
...
Alguns perguntas serão feitas como:

Senha do usuário PERSTATS
Tablespace Default do usuário PERSTATS
Tablespace Temporário do usuário PERFSTATS

Dropnado statspack
spdrop.sql


***execução manual
exec statspack.purge(to_date('21-AUG-2014','DD-MON-YYYY'));

ou 

SQL> connect perfstat/perfstat
Connected.
SQL> set transaction use rollback segment big_rbs;

Transaction set.

SQL> @$ORACLE_HOME/rdbms/admin/sppurge.sql





***validação de snapshots
select SNAP_ID, SNAP_TIME from STATS$SNAPSHOT order by 2 desc; 
select SNAP_ID, SNAP_TIME from STATS$SNAPSHOT order by 2 ;

ALTER TABLE PERFSTAT.STATS$SQLTEXT SHRINK SPACE;


SELECT OWNER, SEGMENT_NAME, TABLESPACE_NAME, BYTES/1024/1024/1024 FROM DBA_SEGMENTS WHERE TABLESPACE_NAME='TBS_STASPACK' ORDER BY BYTES;


SELECT TABLESPACE_NAME, FILE_ID, BYTES, BLOCKS FROM DBA_FREE_SPACE WHERE TABLESPACE_NAME='TBS_STASPACK';


***
----Create the procedure which will purge statspack snapshot after 30 days gap---------
conn perfstat

create or replace procedure statspackpurge is
var_lo_snap number;
var_hi_snap number;
var_db_id number;
var_instance_no number;
noofsnapshot number;
n_count number ;
begin
n_count := 0;
select count(*) into n_count from stats$snapshot where snap_time < sysdate-30;
if n_count > 0 then
select min(s.snap_id) , max(s.snap_id),max(di.dbid),max(di.instance_number) into  var_lo_snap, var_hi_snap,var_db_id,var_instance_no
  from stats$snapshot s
     , stats$database_instance di
where s.dbid              = di.dbid
   and s.instance_number   = di.instance_number
   and di.startup_time     = s.startup_time
   and s.snap_time < sysdate-3;
  noofsnapshot := statspack.purge( i_begin_snap      => var_lo_snap
                                      , i_end_snap        => var_hi_snap
                                      , i_snap_range      => true
                                      , i_extended_purge  => false
                                      , i_dbid            => var_db_id
                                      , i_instance_number => var_instance_no);
dbms_output.Put_line('snapshot deleted'||to_char(noofsnapshot));
end if;
end;
/



--Para criar o job com sysdba

BEGIN
sys.dbms_scheduler.create_job(
job_name => '"PERFSTAT"."PURGE_STATS"',
job_type => 'STORED_PROCEDURE',
job_action => '"PERFSTAT"."STATSPACKPURGE"',
repeat_interval => 'FREQ=DAILY',
start_date => systimestamp at time zone 'America/Sao_Paulo',
job_class => '"DEFAULT_JOB_CLASS"',
comments => 'Limpeza de STATSPACK',
auto_drop => FALSE,
enabled => TRUE);
END;
/

execute PERFSTAT.STATSPACKPURGE;


Criando o job de STATSPACK
	
declare
v_jobid pls_integer;
begin
dbms_job.submit(v_jobid,
'statspack.snap;', sysdate, 'sysdate+1/24');
commit;
end;
/




1)	Verifica o nível de snap
conn perfstat/perfstat
set lines 300 long 100000
col description form a130
select snap_level, substr(description,1,130) description from stats$level_description order by snap_level;
select distinct snap_level from stats$snapshot;

2)	Altera nível de snap
exec statspack.snap(i_snap_level => 7, i_modify_parameter => 'true');

SELECT JOB_NAME FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME = 'SCOTT.SPLITSMS';
SELECT JOB_NAME FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME = 'SCOTT.SPLITSMS'



select OWNER,JOB_NAME,to_char(LOG_DATE,'dd/mm/yyyy hh24:mi:ss'),STATUS,RUN_DURATION,ADDITIONAL_INFO from DBA_SCHEDULER_JOB_RUN_DETAILS where JOB_NAME='AUTO_SPACE_ADVISOR_JOB' order by 3

set lines 100
col operation form a40 wrap head 'operation(on)'
col target form a1
spool show_auto_stat_runs.lst
select operation||decode(target,null,null,'-'||target) operation
,to_char(start_time,'YYMMDD HH24:MI:SS.FF4') start_time
,to_char(  end_time,'YYMMDD HH24:MI:SS.FF4') end_time
from dba_optstat_operations
order by start_time desc
/


SELECT LOG_ID,to_char(log_date,'DD/MM/YY HH24:mi:ss') LOG_DATE, OWNER, JOB_NAME, STATUS,ADDITIONAL_INFO FROM DBA_SCHEDULER_JOB_RUN_DETAILS WHERE job_name ='MGMT_STATS_CONFIG_JOB_1'
AND additional_info IS NOT NULL
ORDER BY log_date DESC;


col LOG_DATE form a25
col OWNER form a20
col JOB_NAME form a20
col STATUS form a20
col ADDITIONAL_INFO form a50

SELECT LOG_ID,to_char(log_date,'DD/MM/YY HH24:mi:ss') LOG_DATE, OWNER, JOB_NAME, STATUS,ADDITIONAL_INFO FROM DBA_SCHEDULER_JOB_RUN_DETAILS WHERE additional_info IS NOT NULL
ORDER BY log_date DESC;



Este Select mostra o tempo exato que o schedule esta programado.

SELECT JOB, SUBSTR(WHAT,1,30) , INTERVAL FROM DBA_JOBS

SQL> select to_char(sysdate+1/24/2,'dd-mm-yyyy HH24:mi') from dual;

TO_CHAR(SYSDATE+
----------------
18-09-2014 20:21




select to_char(sysdate+1/24,'dd-mm-yyyy HH24:mi') from dual;
select to_char(SYSDATE+1/24,'dd-mm-yyyy HH24:mi') from dual;
select to_char(SYSDATE+1/24,'dd-mm-yyyy HH24:mi') from dual;

	  4 statspack.snap;                sysdate+1/24
        64 statspack.snap;                trunc(SYSDATE+1/24,'HH')
        63 statspack.snap;                trunc(SYSDATE+1/24,'HH')


