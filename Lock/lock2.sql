-- Verifica locks no Banco de dados.
select blocking_session, sid, serial#, wait_class,SQL_ID,seconds_in_wait from gv$session where blocking_session is not NULL order by blocking_session;

-- veririca lock a nivel de objeto
set pagesize 5555
set linesize 600
col USER for a60
col OBJECT_NAME for a35
SELECT A.USERNAME , A.SID, A.SERIAL# || CONCAT(' - ', A.OSUSER) || ' ' || A.STATUS "USER", 
DECODE(XIDUSN, 0, 'WAITING', 'BLOCKING') "TRANSACTION STATUS", d.event,
C.OBJECT_NAME, a.sql_id
FROM V$SESSION A, V$LOCKED_OBJECT B, DBA_OBJECTS C , v$session_event d
WHERE A.SID = B.SESSION_ID AND 
B.OBJECT_ID = C.OBJECT_ID 
and a.sid = d.sid
and d.sid=b.session_id
ORDER BY 2
/

-- lock objeto
select 
 c.owner 
,c.object_name
,c.object_type
,b.sid
,b.serial#
,b.status
,b.osuser 
,b.sql_id
--,b.machine
from v$locked_object a , v$session b, dba_objects c
where b.sid = a.session_id and a.object_id = c.object_id;


-- verifica lock a nivel de objeto no RAC
set pagesize 5555
set linesize 500
SELECT A.USERNAME || CONCAT(' - ' || A.SID, ',' || A.SERIAL#) || CONCAT(' - ', A.OSUSER) || ' ' || A.STATUS "USER", 
DECODE(XIDUSN, 0, 'WAITING', 'BLOCKING') "TRANSACTION STATUS", 
C.OBJECT_NAME, C.OBJECT_TYPE , a.inst_id, a.sql_id
FROM gV$SESSION A, gV$LOCKED_OBJECT B, DBA_OBJECTS C 
WHERE A.SID = B.SESSION_ID AND 
B.OBJECT_ID = C.OBJECT_ID 
ORDER BY 2
/


-- RAC
SELECT inst_id, substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,id1,id2,lmode,request,type 
FROM GV$LOCK 
WHERE (id1, id2,type) 
  IN (SELECT id1,id2,type FROM GV$LOCK WHERE request>0) 
ORDER BY id1, request;  

--  Detalhes sobre a sessão bloqueada
col status for a8
col inst_id for a5 for 999
col sid for a5 for 999999
col serial# for a5 for 999999
col username for a15
col osuser for a15
col machine for a12
col event for a30
col program for a20
col sql_id for a15
col logon_time for a20
select s.STATUS, s.inst_id, s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE, s.event, s.sql_id, s.program, to_char(s.logon_time,'DD-MON-YYYY HH24:MI:SS') logon_time
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' 
--and s.sid='' 
order by status;


-- Verificar comando da sessão bloqueadora
set long 999999
select sql_text from v$sql where sql_id='SQL_ID';


--Matar o lock
ALTER SYSTEM KILL SESSION 'sid,serial#,@inst_id';

--Mostrar sessão causadora do lock
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
