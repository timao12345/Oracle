show parameter control_management

-- Set the value CONTROL_MANAGEMENT_PACK_ACCESS = { DIAGNOSTIC | DIAGNOSTIC+TUNING }

-- Enable diagnostic pack only
ALTER SYSTEM SET CONTROL_MANAGEMENT_PACK_ACCESS = "DIAGNOSTIC";

-- Enable diagnostic and tuning pack
ALTER SYSTEM SET CONTROL_MANAGEMENT_PACK_ACCESS= "DIAGNOSTIC+TUNING" ;

-- Para desativar
ALTER SYSTEM SET CONTROL_MANAGEMENT_PACK_ACCESS = "NONE";

-- 
declare
 r varchar2(4000);
 t varchar2(100) := '&TUNE_TASK_NAME';
begin
  r := dbms_sqltune.create_tuning_task (
    sql_id => '&SQL_ID',
    time_limit => &__time_limit_seconds___,
    task_name => t,
    description => t
  );
  dbms_sqltune.execute_tuning_task (t);
end;


select dbms_sqltune.report_tuning_task ('8hzc04m8vuvw9_tune_now') from dual;

--
SELECT task_name, status 
  FROM dba_advisor_log 
 WHERE owner = 'MARCUS_SOARES';

-- cria o sqltunning
declare
 r varchar2(4000);
 t varchar2(100) :='7rrdmgstpkgbz_sqltune_CVP1';
begin
  r := dbms_sqltune.create_tuning_task (
    sql_id => '7rrdmgstpkgbz',
    task_name => t,
    time_limit => 10200,
    description => t
  );
  dbms_sqltune.execute_tuning_task (t);
end;
/

-- mostra o resultado
SET linesize 200
SET LONG 999999999
SET pages 1000
SET longchunksize 20000
SELECT dbms_sqltune.report_tuning_task('7rrdmgstpkgbz_sqltune_CVP1', 'TEXT', 'ALL') FROM dual;


declare
 r varchar2(4000);
 t varchar2(100) :='cka1mgd2szr8u_sqltune_CVP2';
begin
  r := dbms_sqltune.create_tuning_task (
    sql_id => 'cka1mgd2szr8u',
    task_name => t,
    time_limit => 10200,
    description => t
  );
  dbms_sqltune.execute_tuning_task (t);
end;
/

SET linesize 200
SET LONG 999999999
SET pages 1000
SET longchunksize 20000
SELECT dbms_sqltune.report_tuning_task('cka1mgd2szr8u_sqltune_CVP2', 'TEXT', 'ALL') FROM dual;

execute dbms_sqltune.accept_sql_profile(task_name =>'cka1mgd2szr8u_sqltune_CVP2', task_owner => 'SYS', replace =>TRUE);


execute dbms_sqltune.accept_sql_profile(task_name =>'9a9qrs746j1r7_sqltune_CVP', task_owner => 'SYS', replace =>TRUE);

-- forçar a query a usar um plano diferente
execute dbms_sqltune.create_sql_plan_baseline(task_name =>'TASK_12442', owner_name => 'sys', plan_hash_value => 4141515112);

execute dbms_sqltune.create_sql_plan_baseline(task_name =>'9s81kfs18ynkv_sqltune_now', owner_name => 'SYS', plan_hash_value=> 2309574508);