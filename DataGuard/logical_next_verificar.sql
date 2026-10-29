col sequence# format 99,999 heading Seq#
alter session set nls_date_format='YY/MM/DD HH24:MI:SS';

select thread#, sequence#, first_time, first_change#, 
         next_time, next_change#
     from dba_logstdby_log
     where next_change# > ( select read_scn from dba_logstdby_progress)
     order by first_change#;

