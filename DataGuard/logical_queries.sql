select ls.serial# "Apply Process"
         , sas.state "State"
         , sas.sid SID
         , s.sql_address "SQL Address"
         , s.sql_hash_value "SQL Hash Value"
         , sa.sql_text "SQL Text"
     from v$logstdby ls
       , v$streams_apply_server sas
       , v$session s
      , v$sqlarea sa
    where ls.type = 'APPLIER'
    and sas.state != 'IDLE'
    and sas.serial# = ls.serial#
    and s.sid = sas.sid
    and sa.address (+) = s.sql_address
    and sa.hash_value (+) = s.sql_hash_value;

