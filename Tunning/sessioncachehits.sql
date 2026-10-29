column cursor_cache_hits format a20
column soft_parses format a20
column hard_parses format a20
select to_char(100 * sess / calls, '999999999990.00') || '%' cursor_cache_hits,
    to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' soft_parses,
    to_char(100 * hard / calls, '999990.00') || '%' hard_parses
from ( select value calls from v$sysstat where name = 'parse count (total)' ),
  ( select value hard from v$sysstat where name = 'parse count (hard)' ),
  ( select value sess from v$sysstat where name = 'session cursor cache hits' )
/
COLUMN sess_mem heading "Current|session|memory|Mbytes" format 9,999,999,999,999
SELECT   NVL (username, 'SYS-BKGD') username, sess.SID, SUM (VALUE) /1024/1024 sess_mem
    FROM v$session sess, v$sesstat stat, v$statname NAME
   WHERE sess.SID = stat.SID
     AND stat.statistic# = NAME.statistic#
     AND NAME.NAME LIKE 'session % memory'
GROUP BY username, sess.SID
/


