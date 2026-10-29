select a.SID, b.username, b.osuser, a.OWNER DONO, a.OBJECT OBJETO, a.TYPE TIPO
from v$access a, v$session b
where a.owner = upper('&&dono')
and a.object = upper('&&objeto')
and a.sid=b.sid
/