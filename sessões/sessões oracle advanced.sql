set long 10000000
set linesize 1000
set pagesize 900
set pause off
set feed on
set echo off
column host_name format a13
column pid format 9999
column process format a9    heading 'PROCESS'
column sid format 9999
column serial# format 99999
column status format a8
column action format a25 trunc
col username format a15 trunc
column logon format a11
column "SQL_ADDRESS : HASH VALUE" for a30
column osuser format a9
column machine format a20 trunc
column svr_pid format a7
column cli_pid format a12
column LCK format a3
column cmd format a3
column phys format 999999999
SELECT   -- a.pid,
       	   a.SID SID,
           a.serial#,
	   b.spid PROCESS,
	   a.status,
A.SQL_ADDRESS||':'||A.SQL_HASH_VALUE "SQL_ADDRESS : HASH VALUE",
--       a.sql_address,
         a.username,
         a.last_call_et,
         DECODE (SUBSTR (a.osuser, 1, 9),'OraUser', 'C/S',SUBSTR (a.osuser, 1, 9)) osuser,
         DECODE (SUBSTR (a.terminal, 1, 6), 'Window', machine, machine) machine,
         to_char(logon_time,'dd/mm HH24:MI') logon,
     --    b.spid svr_pid,
     --    a.process cli_pid,
         d.consistent_gets gets,
         d.physical_reads phys,
         d.block_changes changes,
     --    DECODE (a.lockwait, '', 'N', 'S') lck,
         decode (c.name,'SELECT','SEL','INSERT','INS','UPDATE','UPD','DELETE','DEL','PL/SQL EXECUTE','PLS','UNK') cmd
    FROM v$session a,
         v$process b,
         audit_actions c,
         v$sess_io d,
         v$sesstat e,
         v$statname f
   WHERE a.paddr = b.addr
     AND a.username != ' '
     AND a.username <> 'SYS'
--   AND a.username = ''
--     AND a.status = 'ACTIVE'
     AND a.command = c.action
     AND a.SID = d.SID
     AND a.SID = e.SID
     AND e.statistic# = f.statistic#
     AND e.statistic# = 12
     AND f.statistic# = 12
ORDER BY logon
/

