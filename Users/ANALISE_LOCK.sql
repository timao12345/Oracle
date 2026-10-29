--LOCK EM INSTANCIA SIGLE

--SINGLE
SET PAGES 80
SELECT SUBSTR(DECODE(REQUEST,0,'BLOQUEADOR: ','BLOQUEADO: ')||SID,1,20) SESSAO,
       ID1, ID2, LMODE, REQUEST, TYPE
FROM V$LOCK
WHERE (ID1, ID2, TYPE) IN
   (SELECT ID1, ID2, TYPE FROM V$LOCK WHERE REQUEST>0)
     ORDER BY ID1, REQUEST;

--LOCK EM INSTANCIA RAC

--RAC
SET PAGES 80
SELECT INST_ID,
	   SUBSTR(DECODE(REQUEST,0,'BLOQUEADOR: ','BLOQUEADO: ')||SID,1,20) SESSAO,
       ID1, ID2, LMODE, REQUEST, TYPE
FROM GV$LOCK
WHERE (ID1, ID2, TYPE) IN
   (SELECT ID1, ID2, TYPE FROM GV$LOCK WHERE REQUEST>0)
     ORDER BY ID1, REQUEST; 

	 
-- PESQUISAR PELO SID
	 
set lines 180
set pages 5000
set long 3000
undef sid
select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from v$session a, v$sqltext b
where a.SQL_HASH_VALUE=b.hash_value
and sid=&sid
order by piece
/
 

 
 
 --Mostra se há locks no ambiente
select blocking_session, sid, serial#, wait_class, seconds_in_wait
from v$session
where blocking_session is not NULL
order by blocking_session;




select blocking_session, sid, serial#, wait_class, seconds_in_wait
from gv$session
where blocking_session is not NULL
order by blocking_session;



-- VER
 
set pages 500 lines 500
col machine for a40;
col inst for 9999
col sid for 99999
col serial# for 9999999
col spid for a7
col program for a45
col wait_class for a15
col username for a20
col event for a35
col LC for 99999999
alter session set nls_date_format='DD/MM HH24:MI';
select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr order by sid; 

--FILTRANDO POR USUÁRIO
select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr and s.USERNAME='HCP_SRV' order by sid;
 

 
 --VER O STATUS DO SESSION

 
SELECT s.inst_id, s.sid, s.SERIAL#, s.STATUS, s.USERNAME, s.MACHINE FROM gv$session s
WHERE s.status = 'INACTIVE';




select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr and s.USERNAME='247488' order by sid;



select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr and s.USERNAME='304164' order by sid;


select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr and s.USERNAME='313894' order by sid;



select s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from v$session s,v$process p where s.paddr=p.addr and s.USERNAME='247166' order by sid;
247166


  1462    29291 16715                 rman@UC-VM-BD-ORACLE (TNS V1-V3)              SYS                  ACTIVE                    20/02 08:36        16 System I/O      RMAN backup & recovery I/O

alter system kill session '252,15845,@2' IMMEDIATE;



-- MATAR SESSÕES BLOQUEADAS OU BLOQUEADORAS COM OPÇÕES DE FILTRO   

select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where sql_id='304164' and wait_class='User I/O' and sid = 1230 and username='M4U_PROD';

select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where wait_class='System I/O' and sid = 1462 and username='SYS';





set pages 500 lines 500
col machine for a40;
col inst for 9999
col sid for 99999
col serial# for 9999999
col spid for a7
col program for a45
col wait_class for a15
col username for a20
col event for a35
col LC for 99999999
alter session set nls_date_format='DD/MM HH24:MI';
select s.inst_id, s.sid,s.serial#,p.spid,s.sql_id,s.program,nvl(s.username,'(oracle)') username,s.status,s.logon_time,trunc(s.last_call_et/60,0) LC,s.wait_class,s.event
from gv$session s,gv$process p where s.paddr=p.addr order by 1,2;





select sid, serial#, username, status, program, osuser, logon_time, action, module from v$session where sid='705'; OSUSER like '%Paulo%' or username like 'MSAF%'; 







