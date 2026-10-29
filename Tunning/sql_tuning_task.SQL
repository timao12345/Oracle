show parameter control_management


DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          begin_snap  => 1835,
                          end_snap    => 1836,
                          sql_id      => '9a9qrs746j1r7',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          task_name   => 'sql_tuning_g9a9qrs746j1r7',
                          description => 'Tuning_9a9qrs746j1r7');

  DBMS_SQLTUNE.execute_tuning_task(task_name => 'sql_tuning_gt3tm0g3jcd2c');

END;


SET linesize 200
SET LONG 999999999
SET pages 1000
SET longchunksize 20000
SELECT dbms_sqltune.report_tuning_task('TASK_139950', 'TEXT', 'ALL') FROM dual;



execute dbms_sqltune.accept_sql_profile(task_name =>'TASK_139950', task_owner => 'SYS', replace => TRUE,profile_type => DBMS_SQLTUNE.PX_PROFILE);