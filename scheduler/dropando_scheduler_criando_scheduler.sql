SQL> ALTER USER ENPGIA GRANT CONNECT THROUGH UOL_VCALIXTO;

User altered.

SQL> CONNECT UOL_VCALIXTO[ENPGIA]
Enter password:

BEGIN 
dbms_scheduler.STOP_JOB(job_name=>'ENPGIA.JOB_SOL', force=>true);
END;



BEGIN 
  DBMS_SCHEDULER.DISABLE('ENPGIA.JOB_SOL');
END;

BEGIN 
DBMS_SCHEDULER.DROP_JOB (job_name => 'ENPGIA.JOB_SOL');
END;

BEGIN 
  DBMS_SCHEDULER.ENABLE('ENPGIA.JOB_SOL');
END;


begin
  sys.dbms_scheduler.create_job(job_name            => 'ENPGIA.JOB_SOL',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'solicitacao',
                                number_of_arguments => 1,
                                start_date          => to_date('17-08-2014 19:23:43', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=45',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => '');
  sys.dbms_scheduler.set_job_argument_value(job_name          => 'ENPGIA.JOB_SOL',
                                            argument_position => 1,
                                            argument_value    => '1');
  sys.dbms_scheduler.enable(name => 'ENPGIA.JOB_SOL');
end;
/
