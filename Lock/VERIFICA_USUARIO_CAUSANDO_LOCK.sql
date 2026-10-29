select distinct 'O usuario '|| s1.username || '@' || s1.machine || ' (INST=' || s1.inst_id || ' SID=' || s1.sid || ')  esta causando lock no usuario '
|| s2.username || '@' || s2.machine || ' (INST=' || s1.inst_id || ' SID=' || s2.sid || ') ' AS blocking_status, count(*) as Valor
from gv$lock l1, gv$session s1, gv$lock l2, gv$session s2
where s1.sid=l1.sid and s2.sid=l2.sid and l1.BLOCK=1 and l2.request > 0
and l1.id1 = l2.id1 and l2.id2 = l2.id2 and l1.inst_id = s1.inst_id
group by s1.username,s1.machine,s1.inst_id,s1.sid,s2.username,s2.machine,s1.inst_id,s2.sid ;