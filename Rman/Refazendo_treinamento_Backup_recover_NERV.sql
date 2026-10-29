RMAN> CONFIGURE BACKUP OPTIMIZATION ON;

new RMAN configuration parameters:
CONFIGURE BACKUP OPTIMIZATION ON;
new RMAN configuration parameters are successfully stored

RMAN> CONFIGURE CONTROLFILE AUTOBACKUP ON;

new RMAN configuration parameters:
CONFIGURE CONTROLFILE AUTOBACKUP ON;
new RMAN configuration parameters are successfully stored


RMAN> CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO COMPRESSED BACKUPSET;

new RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO COMPRESSED BACKUPSET;
new RMAN configuration parameters are successfully stored

RMAN> CONFIGURE COMPRESSION ALGORITHM 'HIGH' OPTIMIZE FOR LOAD TRUE AS OF RELEASE 'DEFAULT';

new RMAN configuration parameters:
CONFIGURE COMPRESSION ALGORITHM 'HIGH' OPTIMIZE FOR LOAD TRUE AS OF RELEASE 'DEFAULT';
new RMAN configuration parameters are successfully stored


SQL> CREATE TABLESPACE TBS_CATALOGO DATAFILE '+DATA' SIZE 10M AUTOEXTEND ON NEXT 10M;

Tablespace created.

SQL> CREATE USER USER_CATALOGO IDENTIFIED BY USER_CATALOGO DEFAULT TABLESPACE TBS_CATALOGO;

User created.

SQL> GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO USER_CATALOGO;

Grant succeeded.


[oracle@London ~]$ rman CATALOG=USER_CATALOGO/USER_CATALOGO

Recovery Manager: Release 11.2.0.3.0 - Production on Tue Feb 17 16:39:57 2015

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

connected to recovery catalog database

RMAN> CREATE CATALOG TABLESPACE TBS_CATALOGO;

recovery catalog created

[oracle@London admin]$ echo $ORACLE_SID
London


[oracle@London admin]$ rman CATALOG=USER_CATALOGO/USER_CATALOGO@CATALOG TARGET /

Recovery Manager: Release 11.2.0.3.0 - Production on Tue Feb 17 16:50:37 2015

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

connected to target database: LONDON (DBID=3200366490)
connected to recovery catalog database

RMAN> register database;

database registered in recovery catalog
starting full resync of recovery catalog
full resync complete

RMAN> unregister database;

database name is "LONDON" and DBID is 3200366490

Do you really want to unregister the database (enter YES or NO)? yes
database unregistered from the recovery catalog

RMAN> register database;

database registered in recovery catalog
starting full resync of recovery catalog
full resync complete


[oracle@London admin]$ rman target /


RMAN> show all;

CONFIGURE BACKUP OPTIMIZATION ON;

RMAN> CONFIGURE BACKUP OPTIMIZATION OFF;

old RMAN configuration parameters:
CONFIGURE BACKUP OPTIMIZATION ON;
new RMAN configuration parameters:
CONFIGURE BACKUP OPTIMIZATION OFF;
new RMAN configuration parameters are successfully stored

Recovery Manager complete.
[oracle@London admin]$ rman CATALOG=USER_CATALOGO/USER_CATALOGO@CATALOG TARGET /

RMAN> show all;

CONFIGURE BACKUP OPTIMIZATION OFF;


[oracle@London admin]$ sqlplus USER_CATALOGO/USER_CATALOGO@CATALOG

SQL*Plus: Release 11.2.0.3.0 Production on Tue Feb 17 16:56:17 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options

SQL> @?/rdbms/admin/prgrmanc.sql
Catalog version is at least 8.1.7
Removed 0 al records
Removed 0 bp records
Removed 0 bs records
Removed 0 ccf records
Removed 0 cdf records
Removed 0 xcf records
Removed 0 xdf records
Removed 0 rlh records

PL/SQL procedure successfully completed.

RMAN> CONFIGURE COMPRESSION ALGORITHM 'MEDIUM' OPTIMIZE FOR LOAD FALSE;

/u01/app/oracle/high
[oracle@London high]$ du -h .
268M    .
/u01/app/oracle/medium
[oracle@London medium]$ du -h .
267M    .
[oracle@London medium]$ rman CATALOG=USER_CATALOGO/USER_CATALOGO@CATALOG TARGET /

RMAN> list backup of database;


List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
1533    Full    267.17M    DISK        00:02:03     17-FEB-15
        BP Key: 1534   Status: AVAILABLE  Compressed: YES  Tag: TAG20150217T215529
        Piece Name: /u01/app/oracle/high/db0spvhh6i_1_1.dbf
  List of Datafiles in backup set 1533
  File LV Type Ckp SCN    Ckp Time  Name
  ---- -- ---- ---------- --------- ----
  1       Full 3594444    17-FEB-15 +DATA/london/system01.dbf
  2       Full 3594444    17-FEB-15 +DATA/london/sysaux01.dbf
  3       Full 3594444    17-FEB-15 +DATA/london/undotbs01.dbf
  4       Full 3594444    17-FEB-15 +DATA/london/users01.dbf
  5       Full 3594444    17-FEB-15 +DATA/london/example01.dbf
  6       Full 3594444    17-FEB-15 +DATA/london/datafile/tbs_teste.338.868833515

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
1609    Full    265.80M    DISK        00:01:40     17-FEB-15
        BP Key: 1612   Status: AVAILABLE  Compressed: YES  Tag: TAG20150217T220038
        Piece Name: /u01/app/oracle/medium/db0upvhhg8_1_1.dbf
  List of Datafiles in backup set 1609
  File LV Type Ckp SCN    Ckp Time  Name
  ---- -- ---- ---------- --------- ----
  1       Full 3595628    17-FEB-15 +DATA/london/system01.dbf
  2       Full 3595628    17-FEB-15 +DATA/london/sysaux01.dbf
  3       Full 3595628    17-FEB-15 +DATA/london/undotbs01.dbf
  4       Full 3595628    17-FEB-15 +DATA/london/users01.dbf
  5       Full 3595628    17-FEB-15 +DATA/london/example01.dbf
  6       Full 3595628    17-FEB-15 +DATA/london/datafile/tbs_teste.338.868833515
