--Limpa log schedulers.

BEGIN

  DBMS_SCHEDULER.purge_log (
    log_history => 5,
    which_log   => 'JOB_AND_WINDOW_LOG',
    job_name    => 'my_text_job');

  DBMS_SCHEDULER.purge_log (
    log_history => 15,
    which_log   => 'JOB_LOG',
    job_name    => 'my_text_job_class');

  DBMS_SCHEDULER.purge_log (
    log_history => 0,
    which_log   => 'WINDOW_LOG',
    job_name    => 'my_text_job');

END;

/