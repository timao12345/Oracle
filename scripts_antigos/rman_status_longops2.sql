set lines 160 pages 50000 timin on
column SID format a10
column SID format 999999999
column USERNAME format a10
column "Operation" format A40
column "Done" format A12
column "Total" format A12
column "Unit" format A7
column "Started" format A19
column "Elapsed" format A9
column "Estimated" format A9
column "% Done" format 999999999
SELECT DISTINCT s.SID, s.username,
       DECODE(TARGET_DESC, NULL, DECODE(TARGET, NULL, OPNAME, CONCAT(OPNAME, CONCAT(' - ', TARGET))),
       DECODE(TARGET, NULL, CONCAT(OPNAME, CONCAT(' : ',TARGET_DESC)),
       CONCAT(OPNAME, CONCAT(' : ', CONCAT(TARGET_DESC, CONCAT(' - ',TARGET)))))) "Operation",
       TO_CHAR(SOFAR, 'FM999,999,990') "Done", TO_CHAR(TOTALWORK, 'FM999,999,990') "Total", /*units "Unit",*/
       TO_CHAR(START_TIME, 'DD/MM/YYYY HH24:MI:SS') "Started",
-- TO_CHAR(ELAPSED_SECONDS,'99,999,990.00') "ElapsedSec",
       TO_CHAR(TRUNC(ELAPSED_SECONDS/3600) , 'FM00') || ':' ||
       TO_CHAR(TRUNC(MOD(ELAPSED_SECONDS, 3600)/60), 'FM00') || ':' ||
       TO_CHAR(MOD(MOD(ELAPSED_SECONDS, 3600), 60) , 'FM00') "Elapsed",
-- TIME_REMAINING "EstimatedSec",
       TO_CHAR(TRUNC(TIME_REMAINING/3600) , 'FM900')|| ':' ||
       TO_CHAR(TRUNC(MOD(TIME_REMAINING, 3600)/60), 'FM00') || ':' ||
       TO_CHAR(MOD(MOD(TIME_REMAINING, 3600), 60) , 'FM00') "Estimated",
       TO_CHAR(SOFAR / TOTALWORK * 100, '99.99') "% Done" --, V$SQL.SQL_TEXT, SQL_ADDRESS
  FROM gV$SESSION_LONGOPS sl, gV$SESSION s, gv$process p
WHERE sl.SID= s.SID AND sl.SERIAL#=s.SERIAL#
AND (sl.SOFAR/sl.TOTALWORK)*100 < 100
AND TOTALWORK > 0
AND s.paddr = p.addr
ORDER BY SID;

