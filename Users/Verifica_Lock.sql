select s1.username || '@' || s1.machine
|| ' ( SID/Serial# =' || s1.sid ||','||s1.serial#|| ' )'
||'is blocking ' 
|| s2.username || '@' || s2.machine
|| ' ( SID/Serial# =' || s2.sid ||','||s1.serial#|| ' ) ' AS blocking_status
from gv$lock l1, gv$session s1, gv$lock l2, gv$session s2
where s1.sid=l1.sid and s2.sid=l2.sid
and l1.BLOCK=1 and l2.request > 0
and l1.id1 = l2.id1
and l2.id2 = l2.id2 ;



set pagesize 10000
set lines 200
col object_name format a20
col username format a16
col machine format a16
col terminal format a16
col program format a20
col OSUSER form a14
col LOGON_TIME form a16
col spid form a10
col "Lock Mode" form a12
col "Req Mode" form a10
select b.sid, c.serial#, p.spid, to_char(c.logon_time, 'dd/mm/yy hh24:mi') logon_time, 
       substr(c.username,1,15) username, c.osuser, substr(c.machine,1,12) machine, 
       substr(c.program,1,12) program,
       decode(b.id2, 0, a.object_name, 'Trans-'||to_char(b.id1)) object_name, b.type,
       decode(b.lmode, 0, '--Waiting--', 1, 'Null', 2, 'Row Share', 3, 'Row Excl', 4, 'Share',
                       5, 'Sha Row Exc', 6, 'Exclusive', 'Other') "Lock Mode",
       decode(b.request, 0, ' ', 1, 'Null', 2, 'Row Share', 3, 'Row Excl', 4, 'Share',
                         5, 'Sha Row Exc', 6, 'Exclusive', 'Other') "Req Mode"
from dba_objects a, v$lock b, v$session c, v$process p
where a.object_id (+) = b.id1
  and b.sid = c.sid
  and p.addr = c.paddr
  and c.username is not null
order by b.sid, b.id2;
