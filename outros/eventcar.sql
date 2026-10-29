col event for a30
col username for a15
undef sid
select a.sid,b.serial#,b.username, a.event,a.seconds_in_wait,a.p1,a.p2,b.last_call_et
 from v$session_wait a, v$session b
 where a.sid=b.sid and a.sid='&&sid'
 and a.event not in('rdbms ipc message','pmon timer','smon timer','SQL*Net message from client');