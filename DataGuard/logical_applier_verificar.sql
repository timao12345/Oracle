col event format a50 trunc
select ls.status_code, s.event, count(1) No_Of_Appliers
  from v$logstdby_process ls
      , v$streams_apply_server sas
      , v$session s
  where ls.type = 'APPLIER'
   and ls.status_code in ( 16124, 16123 )
   and ls.logstdby_id = sas.server_id
   and s.sid = sas.sid
 group by ls.status_code, s.event;

