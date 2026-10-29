begin

  dbms_sqltune.accept_sql_profile(task_name => 'sql_tuning_qr1', replace => TRUE);
  commit ;

end;