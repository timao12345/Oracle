col oracle_username heading username for a10 
col owner format a10 
col object_name for a28 
col object_type for a9 
col session_id heading session for 999999 
col locked_mode heading lmode for 999 
break on oracle_username skip 1 on session_id 
ttitle "Who's Locking What?" 
select oracle_username, owner, object_name, object_type, session_id, locked_mode 
from v$locked_object v, dba_objects d where 
v.object_id = d.object_id 
order by oracle_username,session_id 
/ 