select s1.username || '@' || s1.machine
    || ' ( SID=' || s1.sid || ' )  is blocking '
    || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status,
	s2.event, s2.seconds_in_wait, s2.module,
	s.sql_id,
	s.sql_text
  from v$lock l1, 
       v$session s1, 
       v$lock l2, 
       v$session s2,
	   v$sqlarea s
 where s1.sid=l1.sid 
   and s2.sid=l2.sid
   and l1.BLOCK=1 
   and l2.request > 0
   and l1.id1 = l2.id1
   and l2.id2 = l2.id2 
   and s2.sql_id = s.sql_id (+);

