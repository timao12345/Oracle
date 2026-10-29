select sql_text from v$sqlarea 
where sql_id in (SELECT sql_id 
from v$session
where sid in (select sid from v$session_wait 
where event = 'buffer busy waits'));
