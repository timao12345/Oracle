--VERIFICA O QUE É EXECUTADO NO scheduler

select log_date, owner, job_name, status, error#, additional_info
from dba_scheduler_job_run_details
where job_name like '%GERA_ZIP%'
and actual_start_date like '%%' 

--Ver o Status

select object_type, owner, object_name, status from dba_objects
where object_name ='GERA_ZIP' and owner = 'OWNER'; 