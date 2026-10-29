-- ver processo usando cursores abertos:
select 	a.value, s.username, s.sid, s.serial#, s.program, s.inst_id
from gv$sesstat a
join	gv$statname b
  on	a.statistic# = b.statistic#
join 	gv$session s
  on 	s.sid = a.sid
where	b.name = 'opened cursors current';  

-- ver sessoes com alto numero de cursores abertos, parsed ou cached:
select 	saddr, sid, user_name, address, hash_value, sql_id, sql_text
from	gv$open_cursor
where 	sid in ( select	sid	
				 from v$open_cursor
				 group by sid having count(*) > &threhold);
				 
-- ver maximo de cursores cacheados por sessao:]
select max(value) from v$sesstat
where statistic# in (select statistic# from v$statname
					 where name = 'session cursor cache count');
					 
					 

select
	sid
	||','||
	serial# sessao
from
v$session
where
sid in ( 
SELECT a.SESSION_ID      
FROM V$LOCKED_OBJECT A, ALL_OBJECTS B      
WHERE A.OBJECT_ID = B.OBJECT_ID   
);