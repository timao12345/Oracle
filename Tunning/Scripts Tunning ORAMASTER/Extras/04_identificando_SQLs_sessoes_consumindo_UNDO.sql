-- ver SQL consumindo mais tempo de undo:
select s.sql_text from v$sql s join v$undostat u on u.maxqueryid=s.sql_id;

-- ver sessoes consumindo mais undo em transacoes atuais:
select s.sid, s.username, t.used_urec, t.used_ublk
from	v$session as s
join	v$transaction t
  on	s.saddr = t.ses_addr
where s.sid= 786
ORDER BY t.used_ublk asc;

-- ver sessao usando mais undo na instancia:
select s.sid, t.name, s.value
from 	v$sesstat s
cross join	v$statname t
where	t.name = 'undo change vector size'
order by s.value desc;

-- 
select sql.sql_text, t.used_urec Records,
		t.USED_UBLK Blocks,
		(t.USED_UBLK*8192/1024) Kbytes, s.SID
from 	v$transaction t
join	v$session s
  on	t.addr = s.taddr
join	v$sql sql
  on	s.sql_id = sql.sql_id
where	s.username = '&USERNAME';