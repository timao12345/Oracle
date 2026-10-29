[sabre@oradbtb578a RS00568969]$ sqlplus / as sysdba

SQL*Plus: Release 11.2.0.4.0 Production on Sat Feb 2 20:04:59 2019

Copyright (c) 1982, 2013, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, Real Application Clusters, Automatic Storage Management, OLAP,
Data Mining and Real Application Testing options

SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1> drop directory RS00568969
  2  ;

Directory dropped.

SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1> create directory RS00568969 as '/work-tmp/sabre/RS00568969';

Directory created.

SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1> select
   owner,
   sum(bytes)/1024/1024/1024 schema_size_gig
from
   dba_segments
group by
   owner;  2    3    4    5    6    7

OWNER                          SCHEMA_SIZE_GIG
------------------------------ ---------------
UOLDIVEO_DBA                        .796386719
MDSYS                               .073791504
DMSYS                               .000244141
OUTLN                               .000549316
CTXSYS                              .006103516
OLAPSYS                             .015197754
RM_SYNONYM                          .012695313
SYSTEM                               .10760498
RM_WORK                             33.1650391
EXFSYS                               .00378418
SCOTT                               .000366211
DBSNMP                              .003356934
RM_LIVE                             105.973816
ORDSYS                              .000549316
SYSMAN                              .120727539
XDB                                 .056152344
APPQOSSYS                           .000244141
ORDDATA                             .012084961
SYS                                 5.14044189
WMSYS                               .007202148
AZULDBA                             .005432129

21 rows selected.

SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1>
SYS@SABRECC1> exit
Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, Real Application Clusters, Automatic Storage Management, OLAP,
Data Mining and Real Application Testing options
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$ pwd
/work-tmp/sabre/RS00568969
[sabre@oradbtb578a RS00568969]$ df -h .
Filesystem            Size  Used Avail Use% Mounted on
10.0.6.210:/home/work-tmp
                      857G  200G  648G  24% /work-tmp
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$ nohup expdp '"/ as sysdba"' directory=RS00568969 dumpfile=RS00568969_sabre_full_%U.dmp logfile=RS00568969_sabre_full.log filesize=10G full=Y &
[1] 17646
nohup: ignoring input and appending output to 'nohup.out'
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$
[sabre@oradbtb578a RS00568969]$ tail -100f nohup.out

Export: Release 11.2.0.4.0 - Production on Sat Feb 2 20:09:05 2019

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, Real Application Clusters, Automatic Storage Management, OLAP,
Data Mining and Real Application Testing options
FLASHBACK automatically enabled to preserve database integrity.
Starting "SYS"."SYS_EXPORT_FULL_05":  "/******** AS SYSDBA" directory=RS00568969 dumpfile=RS00568969_sabre_full_%U.dmp logfile=RS00568969_sabre_full.log filesize=10G full=Y
Estimate in progress using BLOCKS method...
Processing object type DATABASE_EXPORT/SCHEMA/TABLE/TABLE_DATA


Total estimation using BLOCKS method: 57.71 GB
Processing object type DATABASE_EXPORT/TABLESPACE
Processing object type DATABASE_EXPORT/PROFILE
Processing object type DATABASE_EXPORT/SYS_USER/USER
Processing object type DATABASE_EXPORT/SCHEMA/USER
Processing object type DATABASE_EXPORT/ROLE
Processing object type DATABASE_EXPORT/GRANT/SYSTEM_GRANT/PROC_SYSTEM_GRANT
Processing object type DATABASE_EXPORT/SCHEMA/GRANT/SYSTEM_GRANT
Processing object type DATABASE_EXPORT/SCHEMA/ROLE_GRANT
Processing object type DATABASE_EXPORT/SCHEMA/DEFAULT_ROLE
Processing object type DATABASE_EXPORT/SCHEMA/TABLESPACE_QUOTA
Processing object type DATABASE_EXPORT/RESOURCE_COST
Processing object type DATABASE_EXPORT/SCHEMA/DB_LINK
Processing object type DATABASE_EXPORT/TRUSTED_DB_LINK
Processing object type DATABASE_EXPORT/SCHEMA/SEQUENCE/SEQUENCE
Processing object type DATABASE_EXPORT/SCHEMA/SEQUENCE/GRANT/OWNER_GRANT/OBJECT_GRANT
Processing object type DATABASE_EXPORT/DIRECTORY/DIRECTORY
Processing object type DATABASE_EXPORT/DIRECTORY/GRANT/OWNER_GRANT/OBJECT_GRANT
Processing object type DATABASE_EXPORT/CONTEXT
Processing object type DATABASE_EXPORT/SCHEMA/PUBLIC_SYNONYM/SYNONYM
Processing object type DATABASE_EXPORT/SCHEMA/SYNONYM
Processing object type DATABASE_EXPORT/SCHEMA/TYPE/TYPE_SPEC
Processing object type DATABASE_EXPORT/SCHEMA/TYPE/GRANT/OWNER_GRANT/OBJECT_GRANT
Processing object type DATABASE_EXPORT/SYSTEM_PROCOBJACT/PRE_SYSTEM_ACTIONS/PROCACT_SYSTEM
Processing object type DATABASE_EXPORT/SYSTEM_PROCOBJACT/PROCOBJ
Processing object type DATABASE_EXPORT/SYSTEM_PROCOBJACT/POST_SYSTEM_ACTIONS/PROCACT_SYSTEM
Processing object type DATABASE_EXPORT/SCHEMA/PROCACT_SCHEMA


