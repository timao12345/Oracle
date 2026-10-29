declare
    m_job   number;
    m_inst  number;
    m_date  date;
    m_jqs   number;
 
begin
    select  instance_number
    into    m_inst
    from    v$instance;
 
    dbms_job.submit(
        job     => m_job,
        what        => 'statspack.snap;',
        next_date   => trunc(sysdate + 1 / 24,'HH'),
        interval    => 'trunc(SYSDATE + 1 / 24,''HH'')',
        no_parse    => TRUE,
        instance    => m_inst,
        force       => true
    );
    commit;
 
    select
        next_date
    into    m_date
    from    dba_jobs
    where   job = m_job
    ;
 
    select
        value
    into    m_jqs
    from    v$parameter
    where   name = 'job_queue_processes'
    ;
 
    dbms_output.put_line('Job number: ' || m_job);
    dbms_output.put_line('Next run time: ' || to_char(m_date,'dd-Mon-yyyy hh24:mi:ss'));
    dbms_output.put_line('Current Job Queues: ' || m_jqs || ' (must be greater than zero)');
 
end;
/