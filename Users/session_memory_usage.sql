REM LOCATION:   Application Tuning\Reports
REM FUNCTION:   Generate value for current session memory usage
REM TESTED ON:  7.3.3.5, 8.0.4.1, 8.1.5, 8.1.7, 9.0.1, 10.2.0.3, 11.1.0.6
REM PLATFORM:   non-specific
REM REQUIRES:   v$session, v$sesstat, v$statname
REM
REM  This is a part of the Knowledge Xpert for Oracle Administration library.
REM  Copyright (C) 2008 Quest Software
REM  All rights reserved.
REM
REM******************** Knowledge Xpert for Oracle Administration ********************

COLUMN sess_mem heading "Current|session|memory|Mbytes" format 9,999,999,999,999
SELECT   NVL (username, 'SYS-BKGD') username, sess.SID, SUM (VALUE) /1024/1024 sess_mem
    FROM v$session sess, v$sesstat stat, v$statname NAME
   WHERE sess.SID = stat.SID
     AND stat.statistic# = NAME.statistic#
     AND NAME.NAME LIKE 'session % memory'
GROUP BY username, sess.SID
order by sess_mem
/


