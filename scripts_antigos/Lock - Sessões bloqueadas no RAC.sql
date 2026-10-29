--http://yong321.freeshell.org/oranotes/BlockingSessionInRAC.txt

-- Gera a Arvore dos Bloqueios de Sessoes no Banco de Dados...
set lines 120
set pages 500
with lk as (select  'INST_ID:'||blocking_instance||' SID:'||blocking_session||' -  USERNAME:'||username||'  PROGRAM:'||program blocker, 
					'INST_ID:'||inst_id||' SID:'||sid waiter  
from gv$session where blocking_instance is not null and blocking_session is not null)
select lpad('  ',3*(level-1))||waiter "lock_tree" from
 (select * from lk
  union all
  select distinct 'root', blocker from lk
  where blocker not in (select waiter from lk))
connect by prior waiter=blocker start with blocker='root';



-- Gera o Comando para "MATAR" as Sessoes que estao Bloqueando outras Sessoes...
set serverout on
break on username skip 1
declare
  sess varchar2(20);
  sessinfo varchar2(50);
begin
  for i in 
    (with lk as (select blocking_instance||'.'||blocking_session blocker, inst_id||'.'||sid waiter
       from gv$session where blocking_instance is not null and blocking_session is not null)
     select distinct blocker from lk where blocker not in (select waiter from lk)
    )
  loop
	select regexp_substr(i.blocker,'[0-9]+$')||','||serial# ||',@' || regexp_substr(i.blocker,'[0-9]+'), 
      substr(username||' - '||program,1,50) into sess, sessinfo
    from gv$session where inst_id = regexp_substr(i.blocker,'[0-9]+') and sid = regexp_substr(i.blocker,'[0-9]+$');
    dbms_output.put_line(sessinfo || '  [' || 'alter system kill session ''' || sess || ''' immediate;'|| ']');
  end loop;
end;
/


-- Gera o Comando para "MATAR" as Sessoes que estao Bloqueando outras Sessoes - COMANDO DIRETO
set serverout on
break on username skip 1
declare
  sess varchar2(20);
  sessinfo varchar2(50);
begin
  for i in 
    (with lk as (select blocking_instance||'.'||blocking_session blocker, inst_id||'.'||sid waiter
       from gv$session where blocking_instance is not null and blocking_session is not null)
     select distinct blocker from lk where blocker not in (select waiter from lk)
    )
  loop
	select regexp_substr(i.blocker,'[0-9]+$')||','||serial# ||',@' || regexp_substr(i.blocker,'[0-9]+'), 
      substr(username||' - '||program,1,50) into sess, sessinfo
    from gv$session where inst_id = regexp_substr(i.blocker,'[0-9]+') and sid = regexp_substr(i.blocker,'[0-9]+$');
    dbms_output.put_line(' alter system kill session ''' || sess || ''' immediate;');
  end loop;
end;
/



-- Gera uma Lista de Todos os Objetos Bloqueados por alguma Sessao no Banco de Dados..
set lines 300
set pages 80
col username for a30
col owner for a20
col OBJETO_TRAVADO for a30
SELECT  	c.inst_id "INST_TRAVADA", 
			c.sid "SID_TRAVADO", 
			c.blocking_instance "INST_TRAVANDO", 
			c.blocking_session "SID_TRAVANDO", 
			b.OBJECT_TYPE, 
			b.OWNER "OBJECT_OWNER", 
			b.OBJECT_NAME "OBJETO_TRAVADO",  
			DECODE(A.locked_mode,
				1, 'No Lock',
				2, 'Row Share',
				3, 'Row Exclusive',
				4, 'Shared Table',
				5, 'Shared Row Exclusive',
				6, 'Exclusive') MODO_TRAVAMENTO
FROM    gV$LOCKED_OBJECT a, DBA_OBJECTS b, gv$session c
WHERE   a.OBJECT_ID = b.OBJECT_ID
and  	a.SESSION_ID = c.SID
and		a.INST_ID = c.INST_ID
and		c.blocking_instance is not null 
and 	c.blocking_session is not null
/




-- Oracle WAIT Event de todas as Sessoes com Bloqueios
set lines 300
set pages 200
col inst_id for 9999999
col sid for 9999
col serial# for 99999
col event for a50
col p1text for a20
col p1 for 999999999999999
col p2text for a20
col p3text for a20
col state for a30
select s.inst_id,
	   w.sid,
       s.serial#,
	   s.username,
       w.event,
       w.p1text,
       w.p1,
	   w.p2,
	   w.p3,
       w.seconds_in_wait "S.I.W"
 from gv$session_wait w, gv$session s
 where w.sid=s.sid
   and w.event not in ('dispatcher timer',
                       'io done',
                       'lock element cleanup',
                       'Null event',
                       'parallel query dequeue wait',
                       'parallel query idle wait - Slaves',
                       'pipe get',
                       'PL/SQL lock timer',
                       'pmon timer',
                       'rdbms ipc message',
                       'slave wait',
                       'smon timer',
                       'SQL*Net break/reset to client',
                       'SQL*Net message from client',
                       'SQL*Net message to client',
                       'SQL*Net more data from client',
                       'SQL*Net more data to client',
                       'virtual circuit status',
                       'wakeup time manager',
                       'WMON goes to sleep')
and		s.blocking_instance is not null 
and 	s.blocking_session is not null					   
order by w.seconds_in_wait
/

