select sql_text, object_status, first_load_time, username, sid, lockwait 
  from v$session s, v$sql sql 
where s.sql_id = sql.sql_id 
and sid='313'; 