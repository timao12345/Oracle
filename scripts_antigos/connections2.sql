-- NUMERO DE CONEXOES

select a.status, b.thread#, count(*) sessions from v$session a, gv$instance b where a.username is not null and a.status='ACTIVE' group by a.status, b.thread#;
	