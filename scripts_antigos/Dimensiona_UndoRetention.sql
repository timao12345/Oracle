
##### Retorna valor necess�rio para undo_retention: ##################

SELECT 	d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]", SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]", 
		ROUND((d.undo_size / (to_number(f.value) * g.undo_block_per_sec)))"OPTIMAL UNDO RETENTION [Sec]"
 FROM ( SELECT SUM(a.bytes) undo_size  FROM v$datafile a,  v$tablespace b, dba_tablespaces c 
			WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name AND a.ts# = b.ts# ) 
			d, v$parameter e, v$parameter f, ( 
				SELECT MAX(undoblks/((end_time-begin_time)*3600*24))undo_block_per_sec FROM v$undostat ) g 
					WHERE e.name = 'undo_retention' AND f.name = 'db_block_size'; 
					
					
################# Retorna tamanho necess�rio da Tablespace UNDO de acordo com o undo_retention configurado. ##############
					
SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
       SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
       (TO_NUMBER(e.value) * TO_NUMBER(f.value) * g.undo_block_per_sec) / (1024*1024) "NEEDED UNDO SIZE [MByte]"
FROM
    (SELECT SUM(a.bytes) undo_size
     FROM v$datafile a inner join  v$tablespace b
                              on      a.ts# = b.ts#
                       inner join  dba_tablespaces c
                              on      b.name = c.tablespace_name
     WHERE c.contents = 'UNDO' AND c.status = 'ONLINE') d,v$parameter e,v$parameter f,        
            (SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
             FROM v$undostat) g
WHERE e.name = 'undo_retention' AND f.name = 'db_block_size';

------------------------------------------------------------------------------------------------------------------------------------

Using username "oracle".
Last login: Mon Jul  6 15:30:53 2015 from 160.118.129.74
Tue Jul  7 17:26:44 BRT 2015
[oracle@blh11lnxdb11 ~]$ . oraenv
ORACLE_SID = [oracle] ? bi
The Oracle base has been set to /u01/app/oracle
[oracle@blh11lnxdb11 ~]$ sqlplus "/as sysdba"

SQL*Plus: Release 11.2.0.3.0 Production on Tue Jul 7 17:27:02 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options

SQL> set lines 180
SQL> select * from v$instance;

INSTANCE_NUMBER INSTANCE_NAME    HOST_NAME                                                        VERSION           STARTUP_T STATUS       PAR    THREAD# ARCHIVE LOG_SWITCH_WAIT
--------------- ---------------- ---------------------------------------------------------------- ----------------- --------- ------------ --- ---------- ------- ---------------
LOGINS     SHU DATABASE_STATUS   INSTANCE_ROLE      ACTIVE_ST BLO
---------- --- ----------------- ------------------ --------- ---
              1 bi               blh11lnxdb11                                                     11.2.0.3.0        14-MAY-15 OPEN         NO           1 STARTED
ALLOWED    NO  ACTIVE            PRIMARY_INSTANCE   NORMAL    NO


SQL>
SQL>
SQL>
SQL> !
[oracle@blh11lnxdb11 ~]$ vi undoadvisor.sql
[oracle@blh11lnxdb11 ~]$ exit
exit

SQL> clear columns
columns cleared
SQL> column tablespace format a20
SQL> column total_mb format 999,999,999.99
SQL> column used_mb format 999,999,999,999.99
SQL> column free_mb format 999,999,999.99
SQL> column pct_used format 999.99
column graph format a22 heading "GRAPH (X=5%)"
column status format a7
SQL> SQL> SQL> compute sum of total_mb on report
compute sum of used_mb on report
SQL> SQL> compute sum of free_mb on report
SQL> break on report
SQL> set lines 200 pages 100
select  total.ts tablespace,
SQL>   2          DECODE(total.mb,null,'OFFLINE',dbat.status) status,
                total.mb total_mb,
                NVL(total.mb - free.mb,total.mb) used_mb,
  3    4    5                  NVL(free.mb,0) free_mb,
  6          DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used,
  7                  CASE WHEN (total.mb IS NULL) THEN '['||RPAD(LPAD('OFFLINE',13,'-'),20,'-')||']'
  8                  ELSE '['|| DECODE(free.mb,
  9                               null,'XXXXXXXXXXXXXXXXXXXX',
 10                               NVL(RPAD(LPAD('X',trunc((100-ROUND( (free.mb)/(total.mb) * 100, 2))/5),'X'),20,'-'),
 11                                 '--------------------'))||']'
 12           END as GRAPH
 13  from
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
 14   15   16          dba_tablespaces dbat
 17  where total.ts=free.ts(+) and
 18        total.ts=dbat.tablespace_name
 19  UNION ALL
select  sh.tablespace_name,
 20   21          'TEMP',
 22                  SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
 23                  SUM(sh.bytes_used)/1024/1024 used_mb,
 24                  SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
 25   26          '['||DECODE(SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX',
 27                NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'),
 28                  '--------------------'))||']'
 29  FROM v$temp_space_header sh
 30  GROUP BY tablespace_name
 31  order by 6
 32  /

TABLESPACE           STATUS         TOTAL_MB             USED_MB         FREE_MB PCT_USED GRAPH (X=5%)
-------------------- ------- --------------- ------------------- --------------- -------- ----------------------
TS_INDEX_05          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_03           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_01           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_04           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_06           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_04          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_03          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_02           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_05           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_07           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_01          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_06          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_07          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_08           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_02          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_08          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
UNDOTBS1             ONLINE        32,767.98              628.36       32,139.63     1.92 [--------------------]
USERS                ONLINE         7,000.00            1,945.31        5,054.69    27.79 [XXXXX---------------]
TEMP                 TEMP         327,677.92          229,377.92       98,300.00    70.00 [XXXXXXXXXXXXXX------]
SYSAUX               ONLINE         3,072.00            2,177.75          894.25    70.89 [XXXXXXXXXXXXXX------]
TBL_BI_IND           ONLINE       102,590.00           85,594.94       16,995.06    83.43 [XXXXXXXXXXXXXXXX----]
SYSTEM               ONLINE         3,072.00            2,708.38          363.63    88.16 [XXXXXXXXXXXXXXXXX---]
TBS_BI_DATA          ONLINE     2,274,874.91        2,039,295.78      235,579.13    89.64 [XXXXXXXXXXXXXXXXX---]
                             --------------- ------------------- ---------------
sum                             2,914,894.81        2,361,744.44      553,150.38

23 rows selected.

SQL> sho parameter undo

NAME_COL_PLUS_SHOW_PARAM                                                         TYPE
-------------------------------------------------------------------------------- -----------
VALUE_COL_PLUS_SHOW_PARAM
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
undo_management                                                                  string
AUTO
undo_retention                                                                   integer
1800
undo_tablespace                                                                  string
UNDOTBS1
SQL> col VALUE_COL_PLUS_SHOW_PARAM for a60
SQL> sho parameter undo

NAME_COL_PLUS_SHOW_PARAM                                                         TYPE        VALUE_COL_PLUS_SHOW_PARAM
-------------------------------------------------------------------------------- ----------- ------------------------------------------------------------
undo_management                                                                  string      AUTO
undo_retention                                                                   integer     1800
undo_tablespace                                                                  string      UNDOTBS1
SQL> @undoadvisor.sql

PL/SQL procedure successfully completed.

SQL> exit
Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$ ls -ltrh
total 144K
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Videos
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Templates
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Public
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Pictures
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Music
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Downloads
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Documents
drwxr-xr-x 2 oracle oinstall 4.0K Dec  6  2014 Desktop
drwxr-xr-x 3 oracle oinstall 4.0K Dec  7  2014 oradiag_oracle
-rwxrwxr-x 1 oracle oinstall  732 Feb 19 19:57 script_limpeza_bi.sh
-rw-r--r-- 1 oracle oinstall  19K Feb 19 19:58 script_limpeza_bi.log
-rw------- 1 oracle oinstall  70K Apr 29 21:46 nohup.out
-rw-r--r-- 1 oracle oinstall 4.2K Jul  7 17:28 undoadvisor.sql
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$
[oracle@blh11lnxdb11 ~]$ sqlplus "/as sysdba"

SQL*Plus: Release 11.2.0.3.0 Production on Tue Jul 7 17:37:03 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options

SQL> set lines 180
SQL>
SQL>
SQL> SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]", SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
  2             ROUND((d.undo_size / (to_number(f.value) * g.undo_block_per_sec)))"OPTIMAL UNDO RETENTION [Sec]"
  3   FROM ( SELECT SUM(a.bytes) undo_size  FROM v$datafile a,  v$tablespace b, dba_tablespaces c
  4                     WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name AND a.ts# = b.ts# )
  5                     d, v$parameter e, v$parameter f, (
  6                             SELECT MAX(undoblks/((end_time-begin_time)*3600*24))undo_block_per_sec FROM v$undostat ) g
                                        WHERE e.name = 'undo_retention' AND f.name = 'db_block_size';   7

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      OPTIMAL UNDO RETENTION [Sec]
------------------------ ------------------------- ----------------------------
              32767.9844 1800                                              5000

SQL> show patameter UNDO_RETENTION
SP2-0158: unknown SHOW option "patameter"
SP2-0735: unknown SHOW option beginning "UNDO_RETEN..."
SQL> show parameter undo

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
undo_management                      string      AUTO
undo_retention                       integer     1800
undo_tablespace                      string      UNDOTBS1
SQL>
SQL>
SQL>
SQL> SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
  2                        SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
  3                        (TO_NUMBER(e.value) * TO_NUMBER(f.value) *
  4                       g.undo_block_per_sec) / (1024*1024)
  5                     "NEEDED UNDO SIZE [MByte]"
  FROM        (SELECT       SUM(a.bytes) undo_size
  6    7                         FROM        v$datafile a
  8                         inner join  v$tablespace b
  9                                on      a.ts# = b.ts#
 10                          inner join  dba_tablespaces c
                              on      b.name = c.tablespace_name
                       WHERE       c.contents = 'UNDO'
                      AND         c.status = 'ONLINE') d,
 11   12   13   14                        v$parameter e,
 15                        v$parameter f,
 16                       ( SELECT   MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
 17                         FROM    v$undostat) g
  WHERE   e.name = 'undo_retention'
  AND         f.name = 'db_block_size'; 18   19

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      NEEDED UNDO SIZE [MByte]
------------------------ ------------------------- ------------------------
              32767.9844 1800                                    11796.6094

SQL>
SQL>
SQL>
SQL>
SQL>
SQL>
SQL> show parameter undo retention

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
undo_management                      string      AUTO
undo_retention                       integer     1800
undo_tablespace                      string      UNDOTBS1
SQL>
SQL> clear columns
columns cleared
SQL> column tablespace format a20
SQL> column total_mb format 999,999,999.99
SQL> column used_mb format 999,999,999,999.99
SQL> column free_mb format 999,999,999.99
SQL> column pct_used format 999.99
SQL> column graph format a22 heading "GRAPH (X=5%)"
SQL> column status format a7
SQL> compute sum of total_mb on report
SQL> compute sum of used_mb on report
SQL> compute sum of free_mb on report
SQL> break on report
SQL> set lines 200 pages 100
select  total.ts tablespace,
SQL>   2          DECODE(total.mb,null,'OFFLINE',dbat.status) status,
  3                  total.mb total_mb,
  4                  NVL(total.mb - free.mb,total.mb) used_mb,
                NVL(free.mb,0) free_mb,
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used,
                CASE WHEN (total.mb IS NULL) THEN '['||RPAD(LPAD('OFFLINE',13,'-'),20,'-')||']'
  5    6    7    8                  ELSE '['|| DECODE(free.mb,
  9                               null,'XXXXXXXXXXXXXXXXXXXX',
 10                               NVL(RPAD(LPAD('X',trunc((100-ROUND( (free.mb)/(total.mb) * 100, 2))/5),'X'),20,'-'),
 11                                 '--------------------'))||']'
 12           END as GRAPH
 13  from
 14                  (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
 15                  (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
 16   17  where total.ts=free.ts(+) and
 18        total.ts=dbat.tablespace_name
UNION ALL
 19   20  select  sh.tablespace_name,
        'TEMP',
 21   22                  SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
                SUM(sh.bytes_used)/1024/1024 used_mb,
 23   24                  SUM(sh.bytes_free)/1024/1024 free_mb,
 25          ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
 26          '['||DECODE(SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX',
              NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'),
 27   28                  '--------------------'))||']'
 29  FROM v$temp_space_header sh
 30  GROUP BY tablespace_name
 31  order by 6
/
 32

TABLESPACE           STATUS         TOTAL_MB             USED_MB         FREE_MB PCT_USED GRAPH (X=5%)
-------------------- ------- --------------- ------------------- --------------- -------- ----------------------
TS_INDEX_05          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_03           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_01           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_04           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_06           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_04          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_03          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_02           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_05           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_07           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_01          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_06          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_07          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_DATA_08           ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_02          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
TS_INDEX_08          ONLINE        10,240.00                1.00       10,239.00      .01 [--------------------]
UNDOTBS1             ONLINE        32,767.98              628.36       32,139.63     1.92 [--------------------]
USERS                ONLINE         7,000.00            1,945.31        5,054.69    27.79 [XXXXX---------------]
TEMP                 TEMP         327,677.92          229,377.92       98,300.00    70.00 [XXXXXXXXXXXXXX------]
SYSAUX               ONLINE         3,072.00            2,177.75          894.25    70.89 [XXXXXXXXXXXXXX------]
TBL_BI_IND           ONLINE       102,590.00           85,594.94       16,995.06    83.43 [XXXXXXXXXXXXXXXX----]
SYSTEM               ONLINE         3,072.00            2,708.38          363.63    88.16 [XXXXXXXXXXXXXXXXX---]
TBS_BI_DATA          ONLINE     2,274,874.91        2,039,295.78      235,579.13    89.64 [XXXXXXXXXXXXXXXXX---]
                             --------------- ------------------- ---------------
sum                             2,914,894.81        2,361,744.44      553,150.38

23 rows selected.

SQL> SQL>
SQL>
SQL>
SQL> SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]", SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
  2             ROUND((d.undo_size / (to_number(f.value) * g.undo_block_per_sec)))"OPTIMAL UNDO RETENTION [Sec]"
  3   FROM ( SELECT SUM(a.bytes) undo_size  FROM v$datafile a,  v$tablespace b, dba_tablespaces c
  4                     WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name AND a.ts# = b.ts# )
  5                     d, v$parameter e, v$parameter f, (
  6                             SELECT MAX(undoblks/((end_time-begin_time)*3600*24))undo_block_per_sec FROM v$undostat ) g
                                        WHERE e.name = 'undo_retention' AND f.name = 'db_block_size';   7

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      OPTIMAL UNDO RETENTION [Sec]
------------------------ ------------------------- ----------------------------
              32767.9844 1800                                              5000

SQL>
SQL> desc dba_table_spaces
ERROR:
ORA-04043: object dba_table_spaces does not exist


SQL> desc dba_tablespaces
 Name                                                                                                              Null?    Type
 ----------------------------------------------------------------------------------------------------------------- -------- ----------------------------------------------------------------------------
 TABLESPACE_NAME                                                                                                   NOT NULL VARCHAR2(30)
 BLOCK_SIZE                                                                                                        NOT NULL NUMBER
 INITIAL_EXTENT                                                                                                             NUMBER
 NEXT_EXTENT                                                                                                                NUMBER
 MIN_EXTENTS                                                                                                       NOT NULL NUMBER
 MAX_EXTENTS                                                                                                                NUMBER
 MAX_SIZE                                                                                                                   NUMBER
 PCT_INCREASE                                                                                                               NUMBER
 MIN_EXTLEN                                                                                                                 NUMBER
 STATUS                                                                                                                     VARCHAR2(9)
 CONTENTS                                                                                                                   VARCHAR2(9)
 LOGGING                                                                                                                    VARCHAR2(9)
 FORCE_LOGGING                                                                                                              VARCHAR2(3)
 EXTENT_MANAGEMENT                                                                                                          VARCHAR2(10)
 ALLOCATION_TYPE                                                                                                            VARCHAR2(9)
 PLUGGED_IN                                                                                                                 VARCHAR2(3)
 SEGMENT_SPACE_MANAGEMENT                                                                                                   VARCHAR2(6)
 DEF_TAB_COMPRESSION                                                                                                        VARCHAR2(8)
 RETENTION                                                                                                                  VARCHAR2(11)
 BIGFILE                                                                                                                    VARCHAR2(3)
 PREDICATE_EVALUATION                                                                                                       VARCHAR2(7)
 ENCRYPTED                                                                                                                  VARCHAR2(3)
 COMPRESS_FOR                                                                                                               VARCHAR2(12)

SQL> select TABLESPACE_NAME,RETENTION from dba_tablespaces where TABLESPACE_NAME='UNDOTBS1';

TABLESPACE_NAME                RETENTION
------------------------------ -----------
UNDOTBS1                       NOGUARANTEE

SQL>
SQL> alter SYSTEM SET UNDO_RETENTION = 5000;

System altered.

SQL> alter SYSTEM SET UNDO_RETENTION = 5000 scope = both;

System altered.

SQL>
SQL>
SQL> ALTER TABLESPACE undotbs1 RETENTION GUARANTEE;

Tablespace altered.

SQL> select TABLESPACE_NAME,RETENTION from dba_tablespaces where TABLESPACE_NAME='UNDOTBS1';

TABLESPACE_NAME                RETENTION
------------------------------ -----------
UNDOTBS1                       GUARANTEE

SQL> SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
                      SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
  2    3                        (TO_NUMBER(e.value) * TO_NUMBER(f.value) *
  4                       g.undo_block_per_sec) / (1024*1024)
  5                     "NEEDED UNDO SIZE [MByte]"
  6    FROM        (SELECT       SUM(a.bytes) undo_size
                       FROM        v$datafile a
  7    8                         inner join  v$tablespace b
  9                                on      a.ts# = b.ts#
 10                          inner join  dba_tablespaces c
 11                                on      b.name = c.tablespace_name
                       WHERE       c.contents = 'UNDO'
 12   13                        AND         c.status = 'ONLINE') d,
 14                        v$parameter e,
 15                        v$parameter f,
                     ( SELECT   MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
                       FROM    v$undostat) g
  WHERE   e.name = 'undo_retention'
 16   17   18   19    AND         f.name = 'db_block_size';

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      NEEDED UNDO SIZE [MByte]
------------------------ ------------------------- ------------------------
              32767.9844 5000                                    32768.3594

SQL>
SQL>
SQL> show parameter UNDO_RETENTION

NAME_COL_PLUS_SHOW_PARAM                                                         TYPE
-------------------------------------------------------------------------------- -----------
VALUE_COL_PLUS_SHOW_PARAM
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
undo_retention                                                                   integer
5000
SQL>
SQL>
SQL>
SQL> col VALUE_COL_PLUS_SHOW_PARAM for a45
SQL> show parameter UNDO_RETENTION

NAME_COL_PLUS_SHOW_PARAM                                                         TYPE        VALUE_COL_PLUS_SHOW_PARAM
-------------------------------------------------------------------------------- ----------- ---------------------------------------------
undo_retention                                                                   integer     5000
SQL>


############################################################################
### CONGELA ###
###############

Title: ORA-01555 caused by SQL statement below (SQL ID: gb8y70xw3dvp1, Query Duration=33935 sec, SCN: 0x003c.2368ab7a):

SQL> SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]", SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
  2             ROUND((d.undo_size / (to_number(f.value) * g.undo_block_per_sec)))"OPTIMAL UNDO RETENTION [Sec]"
  3   FROM ( SELECT SUM(a.bytes) undo_size  FROM v$datafile a,  v$tablespace b, dba_tablespaces c
  4                     WHERE c.contents = 'UNDO' AND c.status = 'ONLINE' AND b.name = c.tablespace_name AND a.ts# = b.ts# )
  5                     d, v$parameter e, v$parameter f, (
                                SELECT MAX(undoblks/((end_time-begin_time)*3600*24))undo_block_per_sec FROM v$undostat ) g
  6    7                                        WHERE e.name = 'undo_retention' AND f.name = 'db_block_size';

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      OPTIMAL UNDO RETENTION [Sec]
------------------------ ------------------------- ----------------------------
                   28488 900                                              72499

SQL>



alter SYSTEM SET UNDO_RETENTION = 36000 scope = both;

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
_optimizer_undo_cost_change          string      11.2.0.3
undo_management                      string      AUTO
undo_retention                       integer     36000
undo_tablespace                      string      UNDOTBS1
SQL>

SQL> select TABLESPACE_NAME,RETENTION from dba_tablespaces where TABLESPACE_NAME='UNDOTBS1';

TABLESPACE_NAME                RETENTION
------------------------------ -----------
UNDOTBS1                       NOGUARANTEE

SQL> ALTER TABLESPACE UNDOTBS1 RETENTION GUARANTEE;

Tablespace altered.

SQL> select TABLESPACE_NAME,RETENTION from dba_tablespaces where TABLESPACE_NAME='UNDOTBS1';

TABLESPACE_NAME                RETENTION
------------------------------ -----------
UNDOTBS1                       GUARANTEE

SQL>
ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec]      NEEDED UNDO SIZE [MByte]
------------------------ ------------------------- ------------------------
                   28488 36000                                   14145.9375

SQL>
