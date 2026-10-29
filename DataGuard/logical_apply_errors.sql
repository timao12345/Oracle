select xidusn, xidslt, xidsqn, status, status_code
     from dba_logstdby_events
     where event_time =
           (select max(event_time)
            from dba_logstdby_events)
/
