col NAME  for a35
col VALUE FOR a80
set lines 600
select * from v$diag_info;

select username, program, terminal, sid, serial#
        , (select spid from v$process where addr=v$session.paddr) AS SPID
  from v$session
where sid=205
/

spid = 239306

select spid from v$process
where addr in (select paddr from v$session
               where sid=sys_context('USERENV', 'SID'));

-- retorna trace mais
set lines 100
column username format a10
column trace_file format a90 
column Trace_file_above_11G format a90 
select b.sid, b.serial#, a.spid, a.pid, b.username,
           (select value||'/diag/rdbms/'||lower(d.DB_UNIQUE_NAME)||'/'||
           (select instance_name from v$instance)||'/trace/'||(select instance_name from v$instance)||'_ora_'||to_char(a.spid)||'.trc' 
           from v$parameter where name = 'diagnostic_dest') "Trace_file_above_11G"
from v$process   a,
     v$session   b, 
     v$parameter c,
     v$database  d
where a.addr = b.paddr
and c.name='user_dump_dest'
and b.sid in (2171);

--
SELECT p.tracefile
FROM   v$session s
       JOIN v$process p ON s.paddr = p.addr
WHERE  s.sid = 635;

TRACEFILE
------------------------------------------------------------------
/u01/app/oracle/diag/rdbms/db11g/db11g/trace/db11g_ora_9699.trc


-- rodar TKPROF organizar para melhor visualização obs(rodar no arquivo com extenção .trc)
tkprof atakarms1_j005_207427.trc atakarms1_j005_207427.txt sys=no
 
--Para quem possui o pacote DBMS_SUPPORT instalado:

--ativa trace nível 1
exec sys.dbms_support.start_trace;

--para incluir wait events e bind variables
exec sys.dbms_support.start_trace(waits => TRUE, binds=> TRUE);

--desativa o trace
exec sys.dbms_support.stop_trace;

--Para quem possui o pacote DBMS_SUPPORT instalado:
--ativa o trace nível 12
exec dbms_support.start_trace_in_session(sid => sid,serial# => serial,waits =>true, binds => true);

--desativa o trace
exec dbms_support.stop_trace_in_session(sid => sid,serial# => serial);

--Utilizando o pacote DBMS_MONITOR:

--ativa o trace nível 12
exec dbms_monitor.session_trace_enable(session_id => sid,serial_num => serial,waits =>true, binds => true);

--desativa o trace
exec dbms_monitor.session_trace_disable(session_id => sid, serial_num => serial); 


-- SQL trace, session LEVEL
--   The 10046 trace is the equivalent of setting SQL_TRACE=TRUE, pode ser usado 1, 4, 8,16, 32, 64

 --ativa o SQL trace nível 8
execute sys.dbms_system.set_ev(SID,SERIAL#,10046,8,'');

--desativa o SQL trace
execute sys.dbms_system.set_ev(SID,SERIAL#,10046,0,'');

--ativa trace nível 1
alter session set sql_trace=true;

--desativa trace
alter session set sql_trace=false;

--Ativa o trace na sessão current
alter session set events '10046 trace name context forever';    <= LEVEL 1 BASIC TRACE
alter session set events '10046 trace name context forever, level 8'; <=  LEVEL 8 (WAITS) TRACE)
alter session set events '10046 trace name context forever,level 12'; <= LEVEL 12 (BINDS & WAITS) TRACE
alter session set events '10046 trace name context off';     <= SWITCH OFF THE TRACE

-- Para habilitar trace 10046 em outra sessao de usuario, execute:
execute dbms_monitor.session_trace_enable(session_id=>&sid,serial_num=>&serial,waits=>true,binds=>true); -- nivel 12

execute dbms_monitor.session_trace_disable(session_id=>&sid,serial_num=>&serial);

-- Gera trace na sessão do usuario
EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>2171, serial#=>35831, sql_trace=>TRUE);

EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>2116, serial#=>35031, sql_trace=>FALSE);

--TRACING AT SQL_ID LEVEL
--In Oracle 11.1 and above trace can be restricteed to a specific SQL ID by specifying a filter:

ALTER SYSTEM SET EVENTS sql_trace [sql: sql_id=4k1jlmn567cr7] bind=true, wait=true;

--Multiplos SQL Id podem ser especificados usando | como separador:
ALTER SYSTEM SET EVENTS sql_trace [sql: sql_id=5t6ygtsa3d356|6fa43fgg0rrtp] bind=true, wait=true';