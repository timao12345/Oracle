BEGIN
    SYS.DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"ENPGIA".""',
            job_type => 'STORED_PROCEDURE',
            job_action => '"solicitacao"."solicitacao"',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2014-08-17 18:23:43 America/Sao_Paulo','YYYY-MM-DD HH24.MI.SS TZR'),
            repeat_interval => 'freq=Minutely; interval=5',
            end_date => NULL,
            job_class => '"SYS"."DEFAULT_JOB_CLASS"',
            enabled => FALSE,
            auto_drop => FALSE,
            comments => '',
            credential_name => NULL,
            destination_name => NULL);

         
     
 
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"ENPGIA".""', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
  
    
    SYS.DBMS_SCHEDULER.enable(
             name => '"ENPGIA".""');
END; 
/