########## MATAR SESSÂO NA MÃO, CASO QUERY QUE GERA COMANDO NÃO FUNCIONE ##########
select 'alter system kill session'||''''||sid||','||serial#||''''||';'from gv$session where sid in ('COLOCAR SESSION ID DE TODAS AS SESSÕES');

########## Gera a Arvore dos Bloqueios de Sessoes no Banco de Dados ##########
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

########## Gera o Comando para "MATAR" as Sessoes que estao Bloqueando outras Sessoes ##########
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

########## Gera o Comando para "MATAR" as Sessoes que estao Bloqueando outras Sessoes - COMANDO DIRETO ##########
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

########## Gera uma Lista de Todos os Objetos Bloqueados por alguma Sessao no Banco de Dados ##########
set lines 300
set pages 80
col username for a30
col owner for a20
col OBJETO_TRAVADO for a30
SELECT          c.inst_id "INST_TRAVADA",
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
and     a.SESSION_ID = c.SID
and             a.INST_ID = c.INST_ID
and             c.blocking_instance is not null
and     c.blocking_session is not null
/

########## Oracle WAIT Event de todas as Sessoes com Bloqueios ##########
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
and             s.blocking_instance is not null
and     s.blocking_session is not null
order by w.seconds_in_wait
/

########## Verificar sessão alta de Memoria ##########
select
   sid,
   username,
   round(total_user_mem/1024,2) mem_used_in_kb,
   round(100 * total_user_mem/total_mem,2) mem_percent
from
   (select
      b.sid sid,
      nvl(b.username,p.name) username,
      sum(value) total_user_mem
   from
      sys.v_$statname c,
      sys.v_$sesstat a,
      sys.v_$session b,
      sys.v_$bgprocess p
   where
      a.statistic#=c.statistic# and
      p.paddr (+) = b.paddr and
      b.sid=a.sid and
      c.name in ('session pga memory','session uga memory')
   group by
      b.sid, nvl(b.username,p.name)),
   (select
      sum(value) total_mem
   from
      sys.v_$statname c,
      sys.v_$sesstat a
   where
      a.statistic#=c.statistic# and
      c.name in ('session pga memory','session uga memory'))
order by
   3 desc;

########## Verificar sessão alta de CPU ##########
SELECT
    s.sid                sid
  , s.serial#            serial_id
  , lpad(s.status,9)     session_status
  , lpad(s.username,12)  oracle_username
  , lpad(s.osuser,9)     os_username
  , lpad(p.spid,7)       os_pid
  , s.program            session_program
  , lpad(s.machine,14)   session_machine
  , sstat.value          cpu_value
FROM v$process p
  , v$session  s
  , v$sesstat  sstat
  , v$statname statname
WHERE p.addr              = s.paddr AND s.sid               = sstat.sid AND statname.statistic# = sstat.statistic# AND statname.name       = 'CPU used by this session'
ORDER BY cpu_value DESC;