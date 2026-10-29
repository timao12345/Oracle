[ora12c@blhlnxrman ~]$ . oraenv
ORACLE_SID = [rman12c] ? rman12c
The Oracle base remains unchanged with value /u02/app/oracle
[ora12c@blhlnxrman ~]$
[ora12c@blhlnxrman ~]$ rman target /@dwmsaf_x3

Recovery Manager: Release 12.1.0.2.0 - Production on Mon Jun 5 23:36:16 2017

Copyright (c) 1982, 2014, Oracle and/or its affiliates.  All rights reserved.

connected to target database: DWMSAF (DBID=1474983917)

RMAN> show all;

using target database control file instead of recovery catalog
RMAN configuration parameters for database with db_unique_name DWMSAFS are:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 15 DAYS;
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO 'SBT_TAPE';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of show command at 06/05/2017 23:36:39
RMAN-12010: automatic channel allocation initialization failed
RMAN-12012: multiple records for SBT_TAPE parallelism found in repository

RMAN> CONFIGURE DEVICE TYPE sbt PARALLELISM 2;

old RMAN configuration parameters:
CONFIGURE DEVICE TYPE 'SBT_TAPE' PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET;
old RMAN configuration parameters:
CONFIGURE DEVICE TYPE 'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 4;
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE 'SBT_TAPE' PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET;
new RMAN configuration parameters are successfully stored

RMAN> show all;

RMAN configuration parameters for database with db_unique_name DWMSAFS are:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 15 DAYS;
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO 'SBT_TAPE';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE SBT_TAPE TO '%F'; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE 'SBT_TAPE' PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET;
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE SBT_TAPE TO 1; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE SBT_TAPE TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS  'ENV=(NB_ORA_POLICY=KROTON_ORACLE_RMAN_KRTNORACLX5_DWMSAF,NB_ORA_SCHEDULE=Default-Application-Backup,NB_ORA_SERV=sts28lnx)';
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+DATAC1/DWMSAFS/snapcf_DWMSAFS4.f';
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+DATAC1/DWMSAFS/snapcf_dwmsafs4.f';

RMAN>


---------------------------------------------------------------------------------

Caso o problema persista, logar no SQL*Plus no banco de origem e rodar o seguinte comando:

execute dbms_backup_restore.resetConfig;


NOTA ORACLE

https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=358642184279890&parent=EXTERNAL_SEARCH&sourceId=PROBLEM&id=436121.1&_afrWindowMode=0&_adf.ctrl-state=m1hy4m138_4
