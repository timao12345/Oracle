-- To start redo apply in foreground:

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE;

-- To stop redo apply process on the Standby database (to stop MRP):

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

-- To start real-time redo apply:

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT FROM SESSION;

-- To start redo apply in background:

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;
or
SQL> RECOVER MANAGED STANDBY DATABASE DISCONNECT;

-- To check redo apply  and Media recovery service status:

SQL> SELECT PROCESS,STATUS, THREAD#,SEQUENCE#, BLOCK#, BLOCKS FROM V$MANAGED_STANDBY ;

-- If managed standby recovery is not running or not started with real-time apply, restart managed recovery with real-time apply enabled:

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT;

-- To gather Data Guard configuration information(standby)

SQL> SELECT DATABASE_ROLE,OPEN_MODE, PROTECTION_MODE FROM V$DATABASE 

DATABASE_ROLE OPEN_MODE PROTECTION_MODE
---------------- -------------------- --------------------
PHYSICAL STANDBY MOUNTED MAXIMUM PERFORMANCE

SQL> SELECT RECOVERY_MODE FROM V$ARCHIVE_DEST_STATUS WHERE RECOVERY_MODE!='IDLE';

RECOVERY_MODE
-----------------------
MANAGED REAL TIME APPLY

alter database recover managed standby database disconnect from session;


-- To calculate the Redo bytes per second

SQL> SELECT SUM (BLOCKS * BLOCK_SIZE) / 1024 / 1024 / 60 / 60 / 30 REDO_MB_PER_SEC
 FROM GV$ARCHIVED_LOG
 WHERE FIRST_TIME BETWEEN TO_DATE ('01.05.2016', 'DD.MM.YYYY')
 AND TO_DATE ('01.06.2016', 'DD.MM.YYYY');

 -- To check status of Data Guard synchronization(standby):

SQL> SELECT NAME, VALUE FROM V$DATAGUARD_STATS;

NAME VALUE
--------------------- -------------------------------
transport lag          +00 00:00:00
apply lag              +00 00:00:00
apply finish time      +00 00:00:00.000
estimated startup time 32

-- To verify there is no log file gap between the primary and the standby database:

SQL> SELECT STATUS, GAP_STATUS FROM V$ARCHIVE_DEST_STATUS WHERE DEST_ID = 3;

STATUS GAP_STATUS
--------- ------------------------
VALID NO GAP
 

-- To verify that the primary database can be switched to the standby role:

/* A value of TO STANDBY or SESSIONS ACTIVE indicates that the primary database can be switched to the standby role. If neither of these values is returned, a switchover is not possible because redo transport is either misconfigured or is not functioning properly.*/

SQL> SELECT SWITCHOVER_STATUS FROM V$DATABASE; 

SWITCHOVER_STATUS
--------------------
TO STANDBY

-- To convert the primary database into a physical standby :

/* Before switchover the current control file is backed up to the current SQL session trace file and it possible to reconstruct a current control file, if necessary.*/

SQL> ALTER DATABASE COMMIT TO SWITCHOVER TO PHYSICAL STANDBY WITH SESSION SHUTDOWN;

Database altered.

-- To verify Managed Recovery is running on the standby :

SQL> SELECT PROCESS FROM V$MANAGED_STANDBY WHERE PROCESS LIKE 'MRP%'; 

PROCESS
---------
MRP0

-- To show information about the protection mode, the protection level, the role of the database, and switchover status:

SQL> SELECT DATABASE_ROLE, DB_UNIQUE_NAME INSTANCE, OPEN_MODE, PROTECTION_MODE, PROTECTION_LEVEL, SWITCHOVER_STATUS FROM V$DATABASE;

DATABASE_ROLE     INSTANCE    OPEN_MODE    PROTECTION_MODE     PROTECTION_LEVEL     SWITCHOVER_STATUS
---------------- ---------- ------------ -------------------- -------------------- -------------------- --------------------
PRIMARY           TESTCDB    READ WRITE    MAXIMUM PERFORMANCE MAXIMUM PERFORMANCE   TO STANDBY

-- On the standby database, query the V$ARCHIVED_LOG view to identify existing files in the archived redo log.

SQL> SELECT SEQUENCE#, FIRST_TIME, NEXT_TIME FROM V$ARCHIVED_LOG ORDER BY SEQUENCE#;
Or
SQL> SELECT THREAD#, MAX(SEQUENCE#) AS "LAST_APPLIED_LOG" FROM V$LOG_HISTORY GROUP BY THREAD#;

-- On the standby database, query the V$ARCHIVED_LOG view to verify the archived redo log files were applied.

SELECT SEQUENCE#,APPLIED FROM V$ARCHIVED_LOG ORDER BY SEQUENCE#;
 

 

-- To determine which log files were not received by the standby site.

SELECT LOCAL.THREAD#, LOCAL.SEQUENCE#
FROM (SELECT THREAD#, SEQUENCE#
FROM V$ARCHIVED_LOG
WHERE DEST_ID = 1) LOCAL
WHERE LOCAL.SEQUENCE# NOT IN (SELECT SEQUENCE#
FROM V$ARCHIVED_LOG
WHERE DEST_ID = 2 AND THREAD# = LOCAL.THREAD#);
 

-- Archivelog difference: Run this on the primary database. (not for real-time apply):

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

SELECT A.THREAD#,
 B.LAST_SEQ,
 A.APPLIED_SEQ,
 A.LAST_APP_TIMESTAMP,
 B.LAST_SEQ - A.APPLIED_SEQ ARC_DIFF
 FROM ( SELECT THREAD#,
 MAX (SEQUENCE#) APPLIED_SEQ,
 MAX (NEXT_TIME) LAST_APP_TIMESTAMP
 FROM GV$ARCHIVED_LOG
 WHERE APPLIED = 'YES'
 GROUP BY THREAD#) A,
 ( SELECT THREAD#, MAX (SEQUENCE#) LAST_SEQ
 FROM GV$ARCHIVED_LOG
 GROUP BY THREAD#) B
 WHERE A.THREAD# = B.THREAD#;

 THREAD#   LAST_SEQ    APPLIED_SEQ  LAST_APP_TIMESTAMP   ARC_DIFF
---------- ---------- -----------   --------------------- ----------
 1         21282      21281         09-IYUL-2016 12:06:5     1
 2         23747      23746         09-IYUL-2016 12:16:13    1

2 rows selected.

 

-- To check archive log apply  on primary database:

SET LINESIZE 150
SET PAGESIZE 999
COL NAME FORMAT A60
COL DEST_TYPE FORMAT A10
COL ARCHIVED FORMAT A10
COL APPLIED FORMAT A10

SELECT SEQUENCE#,
NAME,
DEST_ID ,
CASE WHEN STANDBY_DEST = 'YES' THEN 'Standby' ELSE 'Local' END
AS DEST_TYPE ,
ARCHIVED ,
APPLIED
FROM V$ARCHIVED_LOG
WHERE SEQUENCE# > (SELECT MAX (SEQUENCE#)
FROM V$ARCHIVED_LOG
WHERE STANDBY_DEST = 'YES' AND APPLIED = 'YES')
ORDER BY SEQUENCE# , DEST_ID ;


 SEQUENCE#  NAME                                                          DEST_ID  DEST_TYPE  ARCHIVED APPLIED
---------- -------------------------------------------------------------- -------  ---------- -------- --------
 23748      +FRA/TESTCDB/ARCHIVELOG/2016_07_09/thread_2_seq_23748.10041.9   1      Local        YES       NO
 23748      +DATA/TESTCDB/ARCHIVELOG/2016_07_09/thread_2_seq_23748.10062.   2      Local        YES       NO
 23748      TESTSTB                                                         3      Standby      YES       NO

3 rows selected.