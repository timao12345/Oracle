########## Verificar Sessões ##########

set pages 50000
set lines 220
col machine for a20
col OSUSER for a20
col USERNAME for a20
col SPID for a15
col STATUS for a10

select s.STATUS,s.inst_id,s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE, s.sql_id, p.PID, p.SPID
 from gv$process p, gv$session s
  where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.USERNAME='HELIO_SOUZA' order by status;
  
  
select s.STATUS,s.inst_id,s.SID, s.serial#, s.USERNAME, s.osuser, s.SQL_HASH_VALUE, s.sql_id, p.PID, p.SPID
 from gv$process p, gv$session s
  where s.PADDR = p.ADDR and s.USERNAME='NFE';

select s.STATUS,s.inst_id,s.MACHINE, s.SID, s.serial#, s.USERNAME, s.osuser, s.SQL_HASH_VALUE, s.sql_id, p.PID, p.SPID
 from gv$process p, gv$session s
  where s.PADDR = p.ADDR and s.SID='727'; order by s.inst_id;

select s.STATUS,s.inst_id,s.MACHINE, s.SID, s.serial#, s.USERNAME, s.osuser, s.SQL_HASH_VALUE, s.sql_id, p.PID, p.SPID
 from gv$process p, gv$session s
  where s.PADDR = p.ADDR and s.USERNAME='HP_DBSPI' order by s.inst_id;  
  
select s.SID, s.serial#, s.USERNAME, s.osuser,s.MACHINE,s.TERMINAL, s.SQL_HASH_VALUE, s.sql_id from gv$process p, gv$session s where s.PADDR = p.ADDR;

  
  
  select
       substr(a.spid,1,9) pid,
       substr(b.sid,1,5) sid,
       substr(b.serial#,1,5) ser#,
       substr(b.machine,1,6) box,
       substr(b.username,1,10) username,
--       b.server,
       substr(b.osuser,1,8) os_user,
       substr(b.program,1,30) program
from v$session b, v$process a
where
b.paddr = a.addr
and type='CONT_BDPROD_201410'
order by spid;

########## ------ ##########
select s.SID, s.serial#, s.USERNAME, s.osuser, s.SQL_HASH_VALUE, s.sql_id, p.PID, p.SPID
 from v$process p, v$session s
  where s.PADDR = p.ADDR;
  and s.USERNAME= 'fy031';
  
