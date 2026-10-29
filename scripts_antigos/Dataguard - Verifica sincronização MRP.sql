   THREAD# PRIMARYSEQ STANDBYSEQ        GAP
---------- ---------- ---------- ----------
         1      19839      19821         18
         2      20860      20842         18
         3      19518      19501         17
         4      19845      19828         17
                                 ----------
TOTAL                                    70

set lines 220
set pages 50000
col status for a10
SELECT PROCESS,
STATUS,
THREAD#,
SEQUENCE#,
BLOCK#,
BLOCKS
FROM V$MANAGED_STANDBY;
SQL>   2    3    4    5    6    7
PROCESS   STATUS          THREAD#  SEQUENCE#     BLOCK#     BLOCKS
--------- ------------ ---------- ---------- ---------- ----------
ARCH      CLOSING               1      19577     215040        754
ARCH      CLOSING               2      19929     348160        615
ARCH      CLOSING               2      20788          1        507
ARCH      CLOSING               4      19330     366592       1992
ARCH      CLOSING               1      19755     376832       1884
ARCH      CLOSING               3      19034      49152        719
ARCH      CONNECTED             0          0          0          0
ARCH      CLOSING               3      19022      71680       1306
ARCH      CLOSING               4      19689     280576       1693
ARCH      CLOSING               1      19118          1       1571
ARCH      CLOSING               1      19760     327680        559
ARCH      CLOSING               1      19353     100352        479
ARCH      CLOSING               1      19391     317440       1816
ARCH      CLOSING               4      19426     358400        777
ARCH      CLOSING               3      19000       4096        958
ARCH      CLOSING               1      19181     120832       1100
ARCH      CLOSING               4      19414     198656        194
ARCH      CLOSING               4      19811     251904       1816
ARCH      CLOSING               1      19167          1        598
ARCH      CLOSING               1      19768       2048       1553

20 rows selected.

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT;


Database altered.

SQL> SQL>
SQL> Set pages 50
SELECT PROCESS,
STATUS,
THREAD#,
SEQUENCE#,
BLOCK#,
BLOCKS
FROM V$MANAGED_STANDBY;
SQL>   2    3    4    5    6    7
PROCESS   STATUS          THREAD#  SEQUENCE#     BLOCK#     BLOCKS
--------- ------------ ---------- ---------- ---------- ----------
ARCH      CLOSING               1      19577     215040        754
ARCH      CLOSING               2      19929     348160        615
ARCH      CLOSING               2      20788          1        507
ARCH      CLOSING               4      19330     366592       1992
ARCH      CLOSING               1      19755     376832       1884
ARCH      CLOSING               3      19034      49152        719
ARCH      CONNECTED             0          0          0          0
ARCH      CLOSING               3      19022      71680       1306
ARCH      CLOSING               4      19689     280576       1693
ARCH      CLOSING               1      19118          1       1571
ARCH      CLOSING               1      19760     327680        559
ARCH      CLOSING               1      19353     100352        479
ARCH      CLOSING               1      19391     317440       1816
ARCH      CLOSING               4      19426     358400        777
ARCH      CLOSING               3      19000       4096        958
ARCH      CLOSING               1      19181     120832       1100
ARCH      CLOSING               4      19414     198656        194
ARCH      CLOSING               4      19811     251904       1816
ARCH      CLOSING               1      19167          1        598
ARCH      CLOSING               1      19768       2048       1553
MRP0      APPLYING_LOG          3      19511     179804     202265

21 rows selected.

SET LINES 800
SET PAGESIZE 10000
BREAK ON REPORT
COMPUTE SUM LABEL TOTAL OF GAP ON REPORT
select primary.thread#,
       primary.maxsequence primaryseq,
       standby.maxsequence standbyseq,
       primary.maxsequence - standby.maxsequence gap
from ( select thread#, max(sequence#) maxsequence
       from v$archived_log
       where archived = 'YES'
         and resetlogs_change# = ( select d.resetlogs_change# from v$database d )
       group by thread# order by thread# ) primary,
     ( select thread#, max(sequence#) maxsequence
       from v$archived_log
       where applied = 'YES'
         and resetlogs_change# = ( select d.resetlogs_change# from v$database d )
       group by thread# order by thread# ) standby
where primary.thread# = standby.thread#;

   THREAD# PRIMARYSEQ STANDBYSEQ        GAP
---------- ---------- ---------- ----------
         1      19841      19841          0
         2      20862      20862          0
         3      19520      19520          0
         4      19847      19847          0
                                 ----------
TOTAL                                     0

SQL>
