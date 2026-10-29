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
col spid for a6
col WAIT_CLASS for a15
set linesize 2500
set pages 2500
set colsep '|'
select s.INST_ID,s.STATUS, 
--s.USER#, 
s.BLOCKING_SESSION as "BLOCKING",
p.spid, 
s.SID, s.serial#, 
s.USERNAME, s.osuser, 
s.MACHINE, 
s.event, 
s.wait_class,
s.sql_id,
s.program, (last_call_et / 60) "Min_Active", 
to_char(s.logon_time,'DD-MM-YY HH24:MI:SS') logon_time
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type !='BACKGROUND' 
and s.status ='ACTIVE' 
and s.username <> 'SYS' 
--and s.USERNAME = 'PRODUCAO'
--and SQL_ID in('fs75282hsf2m7')
--and s.program like 'python.exe%'
--and s.SID=7315
--and s.OSUSER ='SISBF'
--and last_call_et > 10000
--and s.status= 'KILLED'
--and s.machine like 'LNXSPRINGMTZ0%'
--and s.INST_ID = 4 and p.spid = 59581 
order by last_call_et;