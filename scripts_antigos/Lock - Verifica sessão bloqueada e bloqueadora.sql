-- SINGLE INSTANCE
SELECT substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
       id1, id2, lmode, request, type
FROM V$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM V$LOCK WHERE request>0)
     ORDER BY id1, request;

-- RAC
SELECT inst_id,
	   substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
       id1, id2, lmode, request, type
FROM GV$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
     ORDER BY inst_id; 
 
-- Verificar o que está sendo executado
select SQL_TEXT,ROWS_PROCESSED,USERS_EXECUTING,CPU_TIME,SQLTYPE from v$sql where SQL_ID='59cxcm78kcggf';

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
  where s.PADDR = p.ADDR 
  --and s.type != 'BACKGROUND' 
  and s.sid=5433 order by status;

