DECLARE
  l_sql_tune_task_id  VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
                          begin_snap  => 3221,
                          end_snap    => 3224,
                          sql_id      => 'gf4sbgtf053u7',
                          scope       => DBMS_SQLTUNE.scope_comprehensive,
                          time_limit  => 600,
                          task_name   => 'sql_tuning_qr1',
                          description => 'Tuning task for prod1');

  DBMS_SQLTUNE.execute_tuning_task(task_name => 'sql_tuning_qr1');

END;
