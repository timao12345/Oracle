--Verficia as sessões 
col status for a8
col inst_id for a5 for 999
col sid for a3 for 999999
col serial# for a5 for 999999
col username for a15
col osuser for a8
col machine for a12
col event for a30
col program for a20
col sql_id for a15
col logon_time for a20
col spid for a8
col WAIT_CLASS for a15
set linesize 2500
set pages 2500
set colsep '|'
select s.INST_ID,s.STATUS, 
--s.USER#, 
--s.BLOCKING_SESSION as "BLOCKING",
p.spid, 
s.SID, s.serial#, 
s.USERNAME, s.osuser, 
s.MACHINE, 
s.event, 
s.wait_class,
s.sql_id,
s.program,s.module ,
(last_call_et / 60) "Min_Active",
to_char(s.logon_time,'DD-MM-YY HH24:MI:SS') logon_time
from gv$process p, gv$session s
where s.PADDR = p.ADDR 
and s.type !='BACKGROUND' 
and s.status ='ACTIVE' 
and s.username !='SYS' 
--and s.USERNAME = 'KIPREVWEB'
--and SQL_ID in('9a9qrs746j1r7')
--and s.program like 'rman@%'
--and s.SID= 81    
--and s.OSUSER ='weblogic'
--and last_call_et > 3600
--and s.status= 'KILLED'
--and s.machine like '%lnxhmbolha06%'
--and s.INST_ID = 3
--and p.spid = 2032176 
order by last_call_et;

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY HH24:MI';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR HH24:MI';

alter system kill session '2145,37313' immediate;
alter system kill session '1175,50949' immediate;
alter system kill session '13,21471' immediate;

-- query agrupa por sessão e SQL 
Select username, sql_id, osuser, module,count(1) from gv$session having count(1) >5 and username is not null and sql_id is not null and status ='ACTIVE' group by username, sql_id, osuser, module,status;
Select username, sql_id, osuser, module,count(1) from gv$session having count(1) >10 and username is not null and sql_id is not null group by username, sql_id, osuser, module,status;

Select username, sql_id, osuser, module,status,count(1) from gv$session having count(1) >10 and username is not null  group by username, sql_id, osuser, module,status;

select s.machine, p.USERNAME,p.PID,p.SPID,s.SERIAL#,p.PROGRAM,PGA_USED_MEM,p.PGA_ALLOC_MEM, p.PGA_MAX_MEM
from v$process p, v$session s
where s.PADDR = p.ADDR 
and s.type !='BACKGROUND' ;

Select INST_ID,username, sql_id, osuser, module,machine,count(1) 
from gv$session 
having count(1) >5 
and username is not null 
and sql_id is not null 
and status ='ACTIVE' 
group by INST_ID,username, sql_id, osuser, module,machine,status;

-- verifica a sessão a partir de um SQL ID
col SQL_PROFILE for a35
col SQL_PLAN_BASELINE for a35
SELECT
s.inst_id,
s.sid,
s.serial#,
to_char(s.sql_exec_start,'dd/mm/yyyy hh24:mi:ss') sql_exec_start,
s.sql_hash_value,
s.sql_id,
sq.executions,
sq.plan_hash_value,
to_char(s.logon_time,'dd/mm/yyyy hh24:mi:ss') logon_time,
s.machine,
s.username,
--s.program,
sq.SQL_PLAN_BASELINE,
sq.SQL_PROFILE
--sq.sql_fulltext
--s.event
FROM
gv$session s,
gv$sql sq
WHERE s.sql_id = sq.sql_id
AND s.inst_id = sq.inst_id
AND s.sql_child_number = sq.child_number
--AND sq.SQL_TEXT like '%MOVTO_OS_COMERCIAL%'
--AND s.inst_id = 1
--AND s.sid = 687
AND s.sql_id='7rrdmgstpkgbz'
/


-- sessão pid
select sid,  spid, a.serial#
from v$session a ,v$process b
where spid = 2744658
and a.paddr=b.addr;   
  
--total de sessões ativas no momento agrupando por usuario

select count(*) as "Ativa",s.USERNAME
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status ='ACTIVE'
group by s.username;

select count(*) as "Inativa",s.USERNAME,s.status
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status !='ACTIVE'
group by s.username,s.status;

select  s.USERNAME,s.status, count(*)
from gv$process p, gv$session s
where s.PADDR = p.ADDR 
--and s.type != 'BACKGROUND' 
group by s.status,s.USERNAME,p.inst_Id order by 1;

and s.last_call_et > 1440

-- Retorna sessões agrupadas por machine username 
compute sum of Inativa on report
compute sum of Ativa on report
break on report
select s.machine, s.USERNAME, s.sql_id,count(DECODE(s.status,'INACTIVE',s.status)) Inativa, count(DECODE(s.status,'ACTIVE',s.status)) Ativa
from v$process p, v$session s
where s.PADDR = p.ADDR 
and s.type !='BACKGROUND' 
group by s.machine, s.USERNAME,s.sql_id order by 4 desc;

-- KILL sessões em massa
select 'alter system kill session '||''''||a.sid||','||a.serial#||''''||' immediate;' as comando
from v$session a WHERE  a.USERNAME = 'KIPREWEB';

-- Kill sessões em RAC
select 'ALTER SYSTEM KILL SESSION '''||b.SID||','||b.SERIAL#||',@'||b.INST_ID||''' immediate;' as comando
from gv$session b WHERE  b.SQL_ID ='as9jhrmxmwr5g';

-- KILL sessões em massa innativas com mais de 10 minutos (last_call_et > 600)
select 'alter system kill session '||'''' || a.sid||','||a.serial#||',@' || a.inst_id ||''''||' immediate;'
from gv$session a 
WHERE 
and a.last_call_et > 1200
and a.status='INACTIVE';

A.USERNAME ='KIPREVWEB' 

and a.sql_id='cqmb5vq96ta0f';

select 'alter system kill session '||'''' || a.sid||','||a.serial#||''''||' immediate;'
from gv$session a 
WHERE A.USERNAME ='OWCSC'
and a.type !='BACKGROUND';
and a.last_call_et > 1200;

select 'alter system kill session '||'''' || a.sid||','||a.serial#||',@' || a.inst_id ||''''||' immediate;'
from gv$session a 
WHERE A.USERNAME ='KIPREVWEB';

select 'alter system kill session '||'''' || a.sid||','||a.serial#||',@' || a.inst_id ||''''||' immediate;'
from gv$session a 
WHERE A.OSUSER ='TER07250';


-- Kill sessões na AWS
begin
rdsadmin.rdsadmin_util.kill(sid => &1,serial => &2);
end;
/ 

SELECT 'begin rdsadmin.rdsadmin_util.kill(sid =>'||sid||', serial =>' || s.SERIAL# || ');' || 'end;'
FROM v$session s, v$process p
WHERE s.paddr = p.addr
AND s.SQL_ID ='cqmb5vq96ta0f';

-- 10 sessões com maior tempo em execução no banco de dados
col MACHINE for a30
select STATUS, SID, serial#, USERNAME, osuser, MACHINE, sql_id, (last_call_et/60) as "Minutes since active"
from (select s.STATUS, s.inst_id,s.USER#, s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE, s.event, s.sql_id, s.program, last_call_et
      from gv$process p, gv$session s 
      where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status='ACTIVE'
      order by last_call_et desc)
where rownum <11;

-- gera plano de execução a partir de um SQL_ID
set long 99999
set lines 600
set pages 5000
SELECT * FROM TABLE(dbms_xplan.display_cursor('7rrdmgstpkgbz',format => 'ADVANCED'));
select * from table(dbms_xplan.display_cursor('7rrdmgstpkgbz',2));

set lines 400
set long 999999999
select sql_fulltext from gv$sql where sql_id='4qunbapkzpu7m' and rownum=1;


SELECT DBMS_SQLTUNE.REPORT_SQL_MONITOR(sql_id => 'cka1mgd2szr8u',  report_level=>'ALL', type => 'TEXT') as report FROM dual;


-- Gera plano com opçao avançada
set long 99999
set lines 600
set pages 5000
select * from table (dbms_xplan.display_cursor('as9jhrmxmwr5g',format => 'ADVANCED'));  

set long 99999
set lines 600
set pages 5000
select * from table (dbms_xplan.display_cursor('as9jhrmxmwr5g',report_level=>'ALL'));

-- Gera plano com estatisticas da query, buffers, etc...
set long 99999;
set lines 600
set pages 5000
SELECT * FROM   TABLE (DBMS_XPLAN.display_cursor (sql_id=>'4c59b7uxucnxz',format=>'ALLSTATS LAST ALL +OUTLINE'));

-- Gera plano a partir de um sql_id
select t.* from v$sql s, table(dbms_xplan.display_cursor(s.sql_id,s.child_number)) t where s.sql_id = '7rrdmgstpkgbz';

select t.* from v$sql s, table(dbms_xplan.display_cursor(s.sql_id,s.child_number,format => 'ADVANCED')) t where s.sql_id = 'cka1mgd2szr8u' ;

-- Gera plano a partir de um hash value
select t.* from v$sql s, table(dbms_xplan.display_cursor(s.sql_id,s.child_number)) t where s.PLAN_HASH_VALUE=852183547;  

-- verifica valor das variaveis bind.

select ADDRESS,HASH_VALUE,SQL_ID,CHILD_ADDRESS,CHILD_NUMBER,NAME,POSITION,DUP_POSITION,DATATYPE,DATATYPE_STRING,CHARACTER_SID,PRECISION,SCALE,MAX_LENGTH,WAS_CAPTURED,LAST_CAPTURED,VALUE_STRING,CON_ID from gv$sql_bind_capture where sql_id='fzm4zu4d9qpdn';

-- pega o sql_text full da memoria
col SQL_TEXT for a125
set long 999999999999
col sql_text for a1000
select SQL_TEXT from v$sqltext where  sql_id='&query' order by Piece;

-- Retorna o objeto executor a partir de um SQL_ID
-- Em alguns casos uma package é a execução inicial
col module format a30
col program_id format 999999999
col object_name format a40
col program_line format 9999999
select a.module module, a.program_id program_id, b.object_name object_name, a.program_line# program_line 
from gv$sql a, dba_objects b
where a.sql_id = '&sqlid'
and b.object_id(+) = a.program_id;

-- Verificar o que está sendo executado a partir do SQL_ID 
col SQL_TEXT for a60
set linesize 1000
set pagesize 1000
set long 999999999999
select INST_ID,SQL_TEXT,ROWS_PROCESSED,USERS_EXECUTING,CPU_TIME,SQLTYPE
from gv$sql 
where SQL_ID='&query';   
-- // --

04ggfkwqaupmb

set long 2000000000 
set lines 99999 
set lines 9999 
select DBMS_LOB.substr(sql_fulltext, 4000 ) 
from v$sql where sql_id = '66dt9mh13hhu8'; 

-- verifica tempo de execução da query em milisegundos
set lines 750 pages 5000
col MODULE for a35
col SQL_TEXT for a65
select * from (
  select LAST_LOAD_TIME, executions, to_char(ELAPSED_TIME/1000, '999,999,999.000') || ' ms' as TIME,MODULE, HASH_VALUE,SQL_TEXT from V$SQL
    where sql_id ='&query'
    order by LAST_LOAD_TIME desc
  ) where ROWNUM <= 10;

-- em minutos
set lines 750 pages 5000
col MODULE for a30
select * from (
  select INST_ID,LAST_LOAD_TIME,executions,
  to_char((ELAPSED_TIME/1000)/60, '999,999')  || ' min' as TIME,
  (ELAPSED_TIME / executions)/1000/60/60 as MEDIA_EXEC,MODULE, HASH_VALUE,PLAN_HASH_VALUE, SQL_TEXT, SQL_ID from gV$SQL
    where sql_id ='2yzsu5j300dta'
    order by LAST_LOAD_TIME desc
  ) where ROWNUM <= 100;

set lines 750 pages 5000
col MODULE for a35
select distinct * from (
select INST_ID,LAST_LOAD_TIME, to_char((ELAPSED_TIME/1000)/60, '999,999')  || ' min' as TIME,MODULE, HASH_VALUE,SQL_TEXT,SQL_ID from gV$SQL
  where   SQL_TEXT like  '%when status%'
  order by LAST_LOAD_TIME desc
) where ROWNUM <= 100;

PCK_DB_OPE_APORTES.P_REGISTRA_APORTE



6czfu5y59qpnd - 4043845457
5m9xkdqgjq57c - 4043845457
asfqqsa1127bs - 3345129411


--s.USER#, 
--s.BLOCKING_SESSION as "BLOCKING",
p.spid, 
s.SID, s.serial#, 
s.USERNAME, s.osuser, 
s.MACHINE, 
s.event, 
s.wait_class,
s.sql_id,
s.program, (last_call_et / 60) "Min_Active", 
to_char(s.logon_time,'DD-MM-YY HH24:MI:SS') logon_time
from gv$process p, gv$session s, GV$SQL sq
where s.PADDR = p.ADDR and sq.SQL_ID=s.SQL_ID
and s.type !='BACKGROUND' 
--and s.status ='ACTIVE' 
--and s.username <> 'SYS' 
--and sq.SQL_TEXT like  '123%'
and s.USERNAME in ('USR_APP_APPS_MOB_SERV','USR_APP_AUT_TRANSF_EAR')
--and SQL_ID in('fs75282hsf2m7')
--and s.program like 'python.exe%'
--and s.SID=7269
--and s.OSUSER ='SISBF'
--and last_call_et > 10000
--and s.status= 'KILLED'
--and s.machine like '%LNCCTR%'
--and s.INST_ID = 4 and p.spid = 59581 
order by last_call_et;

USR_APP_APPS_MOB_SERV e USR_APP_AUT_TRANSF_EAR

-- verifica profile pelo sql_id
select SQL_ID,SQL_PROFILE from V$SQL where sql_id ='&query';


-- Verificar consumo de CPU por sessão
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
WHERE p.addr= s.paddr 
AND s.sid= sstat.sid
AND statname.statistic# = sstat.statistic# 
AND statname.name= 'CPU used by this session'
ORDER BY cpu_value ASC;

-- retorna consumidor de PGA
SELECT s.sid,
         username,
         ROUND(value/1024/1024,2) value_mb
    FROM v$statname n,
         v$session s,
         v$sesstat t
   WHERE s.sid = t.sid
     AND n.statistic#=t.statistic#
     AND s.type     = 'USER'
     AND s.username is not null 
     AND n.name     = 'session pga memory'
     AND t.value    > 200000
ORDER BY 3 DESC
/

-- consumo de cpu dos usuarios
set pages 1000
set lines 1000
col OSPID for a06
col SID for 99999
col SERIAL# for 999999
col SQL_ID for a14
col USERNAME for a15
col PROGRAM for a23
col MODULE for a18
col OSUSER for a10
col MACHINE for a25
select * from (
select p.spid "ospid",
(se.SID),ss.serial#,ss.SQL_ID,ss.username,substr(ss.program,1,22) "program",ss.module,ss.osuser,ss.MACHINE,ss.status,
se.VALUE/100 cpu_usage_sec
from
v$session ss,
v$sesstat se,
v$statname sn,
v$process p
where
se.STATISTIC# = sn.STATISTIC#
and
NAME like '%CPU used by this session%'
and
se.SID = ss.SID and
ss.status='ACTIVE'
and ss.username is not null
and ss.paddr=p.addr and value > 0
order by se.VALUE asc);

-- top CPU/IO Consuming SQLs
col CPU_TIME_DELTA for 999999999999999
select
SQL_ID,
sum(CPU_TIME_DELTA) CPU_TIME_DELTA,
sum(DISK_READS_DELTA) DISK_READS_DELTA,
count(*) as QTD
from
DBA_HIST_SQLSTAT
group by
SQL_ID
order by CPU_TIME_DELTA asc


--RODAR PARA VERIFICAR O QUAL O USUARIO E O QUE QUAL AÇÃO ESTA SENDO EFETUADA 
select sql_text, object_status, first_load_time, username, sid,s.serial#
from gv$session s, gv$sql sql 
where sql.sql_id = s.sql_id  and sid=3085; 

-- Transações não commitadas.
SELECT username,S.SID,s.serial#,t.STATUS,t.NAME FROM V$TRANSACTION T, V$SESSION S WHERE S.SADDR = T.SES_ADDR;



-- Gera comando para matar as sessões
SELECT 'alter system kill session ' || '''' || s.SID || ',' || s.serial# || ',@' || s.inst_id || '''' || ' immediate;' 
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status !='INACTIVE' and s.username = 'T15613';

select 'alter system kill session ' || ''''|| s.SID ||',' ||s.serial# || ',@'||s.INST_ID || '''' || ' immediate;'
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type !='BACKGROUND' 
and s.status !='ACTIVE' 
and s.username <> 'SYS'
and last_call_et > 1800;

order by last_call_et;

and SQL_ID  in('9dd0dy3k5p4v2')

select 'alter system kill session ' || ''''|| s.SID ||',' ||s.serial# || ',@'||s.INST_ID || '''' || ' immediate;'
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type !='BACKGROUND' 
and s.status !='ACTIVE' 
and last_call_et > 1200
;

and s.username = 'MSAF_DFE'

-- verifica sessão em killed
SELECT s.inst_id, s.sid, s.SERIAL#, s.STATUS, s.USERNAME, s.MACHINE
FROM gv$session s
WHERE s.status = 'KILLED'
/

-- Caso a consulta acima retornar alguma sessão com status killed podemos matar seu processo no SO.
select t.INST_ID
       , s.sid
       , s.program
       , t.status as transaction_status
       , s.status as session_status
       , s.lockwait
       , s.pq_status
       , t.used_ublk as undo_blocks_used
       , decode(bitand(t.flag, 128), 0, 'NO', 'YES') rolling_back
from
    gv$session s
    , gv$transaction t
where s.taddr = t.addr
and s.inst_id = t.inst_id
and s.STATUS = 'KILLED'
order by t.inst_id;

-- verificar na gv$process 
SELECT s.username, s.osuser, s.machine, s.sid, s.serial#, p.spid
FROM gv$session s, gv$process p
WHERE s.inst_id = p.inst_id
AND s.paddr = p.addr
--AND s.username IS NOT NULL
AND s.STATUS = 'KILLED'
/

-- verifica na session_wait para ver se a sessão não está esperando alguma resposta, verificar o wait event
SELECT sw.INST_ID, SW.SID, SW.SEQ#, SW.EVENT, SW.STATE, sw.WAIT_TIME
FROM gv$session_wait sw
WHERE sw.sid IN (SELECT sid FROM gv$session s WHERE s.status = 'KILLED' AND s.inst_id = sw.INST_ID)
ORDER BY sw.inst_id
/

SELECT p.INST_ID, p.pid, p.serial#, p.spid, p.program
FROM gv$process p
WHERE p.spid is not null
AND NOT EXISTS (SELECT 1 FROM gv$session s WHERE s.inst_id = p.inst_id and s.paddr = p.addr)
AND p.pname is null
ORDER BY p.inst_id
/

-- informações de sessões ativas, execuções, query, modulo, sqlid, rows processadas
column ID format 9;
column username format ADMDB01P_LOG;
column sid format 9999;
column serial# format 999999;
column spid format a8;
column buffer_gets format 9999999999;
column sorts format 99999999999;
column rows format 99999999999999999;
column horario for a19;
column address for a30;
column module for a35;
col EXECUTIONS for 9999999999999

select b.inst_id id,
a.username,
a.sid,
a.serial#,
b.spid,
c.buffer_gets,
c.EXECUTIONS,
c.DISK_READS,
c.sorts,
c.rows_processed as ROWSS,
to_char(a.logon_time,'DD-MM-RR HH24:MI:SS') as HORARIO,
c.sql_id,
a.module
from gv$session a,
gv$process b,
gv$sqlarea c
where a.paddr=b.addr
and a.sql_address=c.address
and b.inst_id = a.inst_id
and type != 'BACKGROUND'
and status = 'ACTIVE'
and a.username is not null
order by c.DISK_READS desc

/

-- consumo de CPU por sessão.
COLUMN username FORMAT A30
COLUMN sid FORMAT 999999999
COLUMN serial# FORMAT 999999999
COLUMN "cpu usage (seconds)"  FORMAT 999,999,999.0000
 
SELECT
   s.username,
   t.sid,
   s.sql_id,
   s.serial#,
   SUM(VALUE/100) as "cpu usage (seconds)"
FROM
   gv$session s,
   gv$sesstat t,
   gv$statname n
WHERE
   t.STATISTIC# = n.STATISTIC#
AND   NAME like '%CPU used by this session%'
AND   t.SID = s.SID
AND   s.status='ACTIVE'
AND   s.username is not null
GROUP BY username,t.sid,s.sql_id, s.serial#
order by 5 asc
/

-- Retorna SQL_ID maior consumidor, tempo usado de 1h ( 1/24 )
select activity_pct, db_time, sql_id, MACHINE, program, action, parsing_schema_name
from (
  select round(106 * ratio_to_report(count(*)) OVER (), 1) as activity_pct,count (*) as db_time,sql_id,MACHINE, program, s.parsing_schema_name,h.action
  from v$active_session_history h join v$sql s using(sql_id)
where sample_time >= trunc(sysdate)- 3/24
-- between to_timestamp('18-09-2023 00:00:00', 'dd-mm-yyyy HH24') and  to_timestamp('18-09-2023 10:30:60', 'dd-mm-yyyy HH24:mi:ss')
and sql_id is not null
group by sql_id, sql_text,MACHINE, program, s.parsing_schema_name,h.action
order by count(*) desc
)
where rownum <= 10
/


compute sum of Inativa on report
compute sum of Ativa on report
break on report
select s.machine, s.USERNAME, s.sql_id,count(DECODE(s.status,'INACTIVE',s.status)) Inativa, count(DECODE(s.status,'ACTIVE',s.status)) Ativa
from v$process p, v$session s
where s.PADDR = p.ADDR 
and s.type !='BACKGROUND' 
group by s.machine, s.USERNAME,s.sql_id order by 4 desc;

--Top sql_id's that consumed PGA: 
select *
from (select instance_number, sql_id, max(pga_sum_mb) pga_max
        from (select instance_number, sample_time, sql_id, round(sum(nvl(pga_allocated, 0))/1024/1024) pga_sum_mb
                from dba_hist_active_sess_history
               where sample_time between to_timestamp('&begin_timestamp', 'yyyy/mm/dd hh24:mi') and to_timestamp('&end_timestamp', 'yyyy/mm/dd hh24:mi')
            group by instance_number, sample_time, sql_id)
       group by instance_number, sql_id
       order by pga_max desc)
where rownum <= 10;

--Top sql_id's that consumed temporary segments: 
select *
from (select instance_number, sql_id, max(temp_sum_mb) temp_max
        from (select instance_number, sample_time, sql_id, round(sum(nvl(temp_space_allocated, 0))/1024/1024) temp_sum_mb
                from dba_hist_active_sess_history
               where sample_time between to_timestamp('&begin_timestamp', 'yyyy/mm/dd hh24:mi') and to_timestamp('&end_timestamp', 'yyyy/mm/dd hh24:mi')
            group by instance_number, sample_time, sql_id)
       group by instance_number, sql_id
       order by temp_max desc)
where rownum <= 10;  


--- // ---
DEF days_of_history_accessed = '31';
DEF captured_at_least_x_times = '10';
DEF captured_at_least_x_days_apart = '5';
DEF med_elap_microsecs_threshold = '1e4';
DEF min_slope_threshold = '0.1';
DEF max_num_rows = '60';
 
SET lin 200 ver OFF;
COL row_n FOR A2 HEA '#';
COL med_secs_per_exec HEA 'Median Secs|Per Exec';
COL std_secs_per_exec HEA 'Std Dev Secs|Per Exec';
COL avg_secs_per_exec HEA 'Avg Secs|Per Exec';
COL min_secs_per_exec HEA 'Min Secs|Per Exec';
COL max_secs_per_exec HEA 'Max Secs|Per Exec';
COL plans FOR 9999;
COL sql_text_80 FOR A80;
 
PRO SQL Statements with "Elapsed Time per Execution" changing over time
 
WITH
per_time AS (
SELECT h.dbid,
       h.sql_id,
       SYSDATE - CAST(s.end_interval_time AS DATE) days_ago,
       SUM(h.elapsed_time_total) / SUM(h.executions_total) time_per_exec
  FROM dba_hist_sqlstat h, 
       dba_hist_snapshot s
 WHERE h.executions_total > 0 
   AND s.snap_id = h.snap_id
   AND s.dbid = h.dbid
   AND s.instance_number = h.instance_number
   AND CAST(s.end_interval_time AS DATE) > SYSDATE - &&days_of_history_accessed. 
 GROUP BY
       h.dbid,
       h.sql_id,
       SYSDATE - CAST(s.end_interval_time AS DATE)
),
avg_time AS (
SELECT dbid,
       sql_id, 
       MEDIAN(time_per_exec) med_time_per_exec,
       STDDEV(time_per_exec) std_time_per_exec,
       AVG(time_per_exec)    avg_time_per_exec,
       MIN(time_per_exec)    min_time_per_exec,
       MAX(time_per_exec)    max_time_per_exec       
  FROM per_time
 GROUP BY
       dbid,
       sql_id
HAVING COUNT(*) >= &&captured_at_least_x_times. 
   AND MAX(days_ago) - MIN(days_ago) >= &&captured_at_least_x_days_apart.
   AND MEDIAN(time_per_exec) > &&med_elap_microsecs_threshold.
),
time_over_median AS (
SELECT h.dbid,
       h.sql_id,
       h.days_ago,
       (h.time_per_exec / a.med_time_per_exec) time_per_exec_over_med,
       a.med_time_per_exec,
       a.std_time_per_exec,
       a.avg_time_per_exec,
       a.min_time_per_exec,
       a.max_time_per_exec
  FROM per_time h, avg_time a
 WHERE a.sql_id = h.sql_id
),
ranked AS (
SELECT RANK () OVER (ORDER BY ABS(REGR_SLOPE(t.time_per_exec_over_med, t.days_ago)) DESC) rank_num,
       t.dbid,
       t.sql_id,
       CASE WHEN REGR_SLOPE(t.time_per_exec_over_med, t.days_ago) > 0 THEN 'IMPROVING' ELSE 'REGRESSING' END change,
       ROUND(REGR_SLOPE(t.time_per_exec_over_med, t.days_ago), 3) slope,
       ROUND(AVG(t.med_time_per_exec)/1e6, 3) med_secs_per_exec,
       ROUND(AVG(t.std_time_per_exec)/1e6, 3) std_secs_per_exec,
       ROUND(AVG(t.avg_time_per_exec)/1e6, 3) avg_secs_per_exec,
       ROUND(MIN(t.min_time_per_exec)/1e6, 3) min_secs_per_exec,
       ROUND(MAX(t.max_time_per_exec)/1e6, 3) max_secs_per_exec
  FROM time_over_median t
 GROUP BY
       t.dbid,
       t.sql_id
HAVING ABS(REGR_SLOPE(t.time_per_exec_over_med, t.days_ago)) > &&min_slope_threshold.
)
SELECT LPAD(ROWNUM, 2) row_n,
       r.sql_id,
       r.change,
       TO_CHAR(r.slope, '990.000MI') slope,
       TO_CHAR(r.med_secs_per_exec, '999,990.000') med_secs_per_exec,
       TO_CHAR(r.std_secs_per_exec, '999,990.000') std_secs_per_exec,
       TO_CHAR(r.avg_secs_per_exec, '999,990.000') avg_secs_per_exec,
       TO_CHAR(r.min_secs_per_exec, '999,990.000') min_secs_per_exec,
       TO_CHAR(r.max_secs_per_exec, '999,990.000') max_secs_per_exec,
       (SELECT COUNT(DISTINCT p.plan_hash_value) FROM dba_hist_sql_plan p WHERE p.dbid = r.dbid AND p.sql_id = r.sql_id) plans,
       REPLACE((SELECT DBMS_LOB.SUBSTR(s.sql_text, 80) FROM dba_hist_sqltext s WHERE s.dbid = r.dbid AND s.sql_id = r.sql_id), CHR(10)) sql_text_80
  FROM ranked r
 WHERE r.rank_num <= &&max_num_rows.
 ORDER BY
       r.rank_num
/


COL USERNAME FORMAT A13
COL OPNAME FORMAT A20
COL TARGET FORMAT A32
COL MESSAGE FORMAT A80
COL Executado FORMAT A11
COL Total  FORMAT A11
COL Falta FORMAT A11
select inst_id, sid, username
,      trunc((sofar/totalwork)*100, 2) "%_complete"
,      opname
,      lpad(trim(to_char(floor((time_remaining)/(3600)), 900)) ||':'|| trim(to_char(floor((((time_remaining)) - (floor(((time_remaining))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((time_remaining)) - (floor(((time_remaining))/(3600))*3600)),60), 900)), 10, ' ') "Falta"
,      lpad(trim(to_char(floor((elapsed_seconds)/(3600)), 900)) ||':'|| trim(to_char(floor((((elapsed_seconds)) - (floor(((elapsed_seconds))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((elapsed_seconds)) - (floor(((elapsed_seconds))/(3600))*3600)),60), 900)), 10, ' ') "Executado"
,      lpad(trim(to_char(floor((time_remaining+elapsed_seconds)/(3600)), 900)) ||':'|| trim(to_char(floor((((time_remaining+elapsed_seconds)) - (floor(((time_remaining+elapsed_seconds))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((time_remaining+elapsed_seconds)) - (floor(((time_remaining+elapsed_seconds))/(3600))*3600)),60), 900)), 10, ' ') "Total"
,      target
,      sql_id
,      message
from   gv$session_longops
where  (sofar/totalwork)*100 <> 100
and    totalwork <> 0
order  by  sql_id,3
/