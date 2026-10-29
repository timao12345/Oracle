----------------------------------------------------------------------------------------
-- VERIFICAR CONSUMO DE CPU
----------------------------------------------------------------------------------------
set lines 200
col username for a20
 
select  nvl(ss.USERNAME,'ORACLE PROC') username,
 se.SID,
 VALUE cpu_usage
from  v$session ss, 
 v$sesstat se, 
 v$statname sn
where   se.STATISTIC# = sn.STATISTIC#
and   NAME like '%CPU used by this session%'
and   se.SID = ss.SID
order   by cpu_usage asc;
----------------------------------------------------------------------------------------
-- VERIFICAR CONSUMO DE CPU
----------------------------------------------------------------------------------------
set lines 200
SET PAGESIZE 60
SET LINESIZE 300

COLUMN username FORMAT A30
COLUMN sid FORMAT 9999999
COLUMN serial# FORMAT 9999999
COLUMN "utilizacao de cpu (seconds)"  FORMAT 999,999,999.0000

SELECT
   s.username,
   t.sid,
   s.serial#,
   SUM(VALUE/100) as "utilização de cpu (seconds)"
FROM
   gv$session s,
   gv$sesstat t,
   gv$statname n
WHERE
   t.STATISTIC# = n.STATISTIC#
AND
   NAME like '%CPU used by this session%'
AND
   t.SID = s.SID
AND
   s.status='ACTIVE'
AND
   s.username is not null
GROUP BY username,t.sid,s.serial#
order by 4 desc;