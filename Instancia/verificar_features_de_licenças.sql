--V$VERSION: Lista a versão e edição do banco de dados Oracle.
--V$OPTION: Lista as options e features instaladas no banco de dados. Geralmente as options são licenciadas separadamente e as features costumam já vir no produto que foi instalado (Standard #Edition, Enterprise Edition).
--DBA_REGISTRY: Lista os componentes que foram instalados no banco de dados.
--DBA_FEATURE_USAGE_STATISTICS: Lista as features e as estatísticas de uso. Essas estatísticas são geradas aptravés de uma procedure não documentada do Oracle.


--Leia mais: https://eduardolegatti.blogspot.com/2018/02/verificando-versao-features-e-options.html#ixzz7n1gXLZYQ
--Under Creative Commons License: Attribution Non-Commercial

SQL> select * from v$version;

BANNER                                   BANNER_FULL                              BANNER_LEGACY                                CON_ID
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------
Oracle Database 19c Enterprise Edition R Oracle Database 19c Enterprise Edition R Oracle Database 19c Enterprise Edition R          0
elease 19.0.0.0.0 - Production           elease 19.0.0.0.0 - Production           elease 19.0.0.0.0 - Production
                                         Version 19.11.0.0.0

SQL> select * from v$option order by 2,1;

PARAMETER                                                        VALUE                                                                CON_ID
---------------------------------------------------------------- ---------------------------------------------------------------- ----------
ASM Proxy Instance                                               FALSE                                                                     0
I/O Server                                                       FALSE                                                                     0
Management Database                                              FALSE                                                                     0
Oracle Database Vault                                            FALSE                                                                     0
Oracle Label Security                                            FALSE                                                                     0
Real Application Clusters                                        FALSE                                                                     0
Unified Auditing                                                 FALSE                                                                     0
Active Data Guard                                                TRUE                                                                      0
Adaptive Execution Plans                                         TRUE                                                                      0
Advanced Analytics                                               TRUE                                                                      0
Advanced Compression                                             TRUE                                                                      0
Advanced Index Compression                                       TRUE                                                                      0
Advanced replication                                             TRUE                                                                      0
Application Role                                                 TRUE                                                                      0
Automatic Data Optimization                                      TRUE                                                                      0
Automatic Storage Management                                     TRUE                                                                      0
Backup Encryption                                                TRUE                                                                      0
Basic Compression                                                TRUE                                                                      0
Bit-mapped indexes                                               TRUE                                                                      0
Block Change Tracking                                            TRUE                                                                      0
Block Media Recovery                                             TRUE                                                                      0
Cache Fusion Lock Accelerator                                    TRUE                                                                      0
Centrally Managed User                                           TRUE                                                                      0
Change Data Capture                                              TRUE                                                                      0
Coalesce Index                                                   TRUE                                                                      0
Connection multiplexing                                          TRUE                                                                      0
Connection pooling                                               TRUE                                                                      0
Cross Transportable Backups                                      TRUE                                                                      0
DICOM                                                            TRUE                                                                      0
Data Mining                                                      TRUE                                                                      0
Data Redaction                                                   TRUE                                                                      0
Database queuing                                                 TRUE                                                                      0
Database resource manager                                        TRUE                                                                      0
Deferred Segment Creation                                        TRUE                                                                      0
Duplexed backups                                                 TRUE                                                                      0
Enterprise User Security                                         TRUE                                                                      0
Exadata Discovery                                                TRUE                                                                      0
Export transportable tablespaces                                 TRUE                                                                      0
Fast-Start Fault Recovery                                        TRUE                                                                      0
File Mapping                                                     TRUE                                                                      0
Fine-grained Auditing                                            TRUE                                                                      0
Fine-grained access control                                      TRUE                                                                      0
Flashback Data Archive                                           TRUE                                                                      0
Flashback Database                                               TRUE                                                                      0
Flashback Table                                                  TRUE                                                                      0
Global Data Services                                             TRUE                                                                      0
Heat Map                                                         TRUE                                                                      0
In-Memory Aggregation                                            TRUE                                                                      0
In-Memory Column Store                                           TRUE                                                                      0
Incremental backup and recovery                                  TRUE                                                                      0
Instead-of triggers                                              TRUE                                                                      0
Java                                                             TRUE                                                                      0
Join index                                                       TRUE                                                                      0
Managed Standby                                                  TRUE                                                                      0
Materialized view rewrite                                        TRUE                                                                      0
OLAP                                                             TRUE                                                                      0
OLAP Window Functions                                            TRUE                                                                      0
Objects                                                          TRUE                                                                      0
Online Index Build                                               TRUE                                                                      0
Online Redefinition                                              TRUE                                                                      0
Oracle Data Guard                                                TRUE                                                                      0
Parallel backup and recovery                                     TRUE                                                                      0
Parallel execution                                               TRUE                                                                      0
Parallel load                                                    TRUE                                                                      0
Partitioning                                                     TRUE                                                                      0
Plan Stability                                                   TRUE                                                                      0
Point-in-time tablespace recovery                                TRUE                                                                      0
Privilege Analysis                                               TRUE                                                                      0
Proxy authentication/authorization                               TRUE                                                                      0
Real Application Security                                        TRUE                                                                      0
Real Application Testing                                         TRUE                                                                      0
Result Cache                                                     TRUE                                                                      0
SQL Plan Management                                              TRUE                                                                      0
Sample Scan                                                      TRUE                                                                      0
SecureFiles Encryption                                           TRUE                                                                      0
Server Flash Cache                                               TRUE                                                                      0
Snapshot time recovery                                           TRUE                                                                      0
Spatial                                                          TRUE                                                                      0
Streams Capture                                                  TRUE                                                                      0
Table Clustering                                                 TRUE                                                                      0
Transparent Application Failover                                 TRUE                                                                      0
Transparent Data Encryption                                      TRUE                                                                      0
Transparent Sensitive Data Protection                            TRUE                                                                      0
Trial Recovery                                                   TRUE                                                                      0
Unused Block Compression                                         TRUE                                                                      0
XStream                                                          TRUE                                                                      0
Zone Maps                                                        TRUE                                                                      0


SQL> select name,version,detected_usages,description from DBA_FEATURE_USAGE_STATISTICS where rownum<=50 order by 1;

-- ou

select name,version,detected_usages,description from DBA_FEATURE_USAGE_STATISTICS where name like '%Tuning%';

select name,version,detected_usages,description from DBA_FEATURE_USAGE_STATISTICS where name like '%&Feature%';


NAME                                                    VERSION           DETECTED_USAGES DESCRIPTION
------------------------------------------------------- ----------------- --------------- ----------------------------------------------------------------------------------------------------
Automatic Maintenance - Optimizer Statistics Gathering  11.2.0.4.0                    181 Automatic initiation of Optimizer Statistics Collection
Automatic Segment Space Management (system)             11.2.0.4.0                    297 Extents of locally managed tablespaces are managed automatically by Oracle.
Automatic Segment Space Management (system)             19.0.0.0.0                     14 Extents of locally managed tablespaces are managed automatically by Oracle.
Automatic Undo Management                               11.2.0.4.0                    297 Oracle automatically manages undo data using an UNDO tablespace.
Automatic Undo Management                               19.0.0.0.0                     14 Oracle automatically manages undo data using an UNDO tablespace.
Dynamic SGA                                             11.2.0.4.0                      0 The Oracle SGA has been dynamically resized through an ALTER SYSTEM SET statement.
Exadata                                                 11.2.0.4.0                      0 Exadata is being used
HeapCompression                                         11.2.0.4.0                      0 Heap Compression is being used
Hybrid Columnar Compression                             11.2.0.4.0                      0 Hybrid Columnar Compression is used
Job Scheduler                                           11.2.0.4.0                      9 Job Scheduler feature is being used.
Locally Managed Tablespaces (system)                    19.0.0.0.0                     14 There exists tablespaces that are locally managed in the database.
Locally Managed Tablespaces (system)                    11.2.0.4.0                    297 There exists tablespaces that are locally managed in the database.
Materialized Views (User)                               11.2.0.4.0                      0 User Materialized Views exist in the database
OCCI                                                    19.0.0.0.0                      0 OCCI used
ODA Infrastructure                                      19.0.0.0.0                      0 Oracle Database Appliance infrastructure in use
ODP.Net, Managed Driver                                 19.0.0.0.0                      0 ODP.Net, Managed Driver used
ODP.Net, Unmanaged Driver                               19.0.0.0.0                      0 ODP.Net, Unmanaged Driver used
Oracle Java Virtual Machine (system)                    11.2.0.4.0                      0 OJVM default system users
Oracle Java Virtual Machine (user)                      11.2.0.4.0                      0 OJVM has been used by at least one non-system user
Oracle Multimedia DICOM                                 11.2.0.4.0                      0 Oracle Multimedia DICOM (Digital Imaging and COmmunications in Medicine) has been used
Oracle Utility Metadata API                             11.2.0.4.0                      3 Oracle Utility (Metadata API) has been used.
PERL DBD::Oracle                                        19.0.0.0.0                      0 PERL DBD::Oracle used
PHP OCI8                                                19.0.0.0.0                      0 PHP OCI8 used
Partitioning (system)                                   19.0.0.0.0                     14 Oracle Partitioning option is being used - there is at least one partitioned object created.
Partitioning (user)                                     11.2.0.4.0                     33 Oracle Partitioning option is being used - there is at least one user partitioned object created.
Pillar Storage                                          11.2.0.4.0                      0 Tablespaces stored on Oracles Pillar Axiom Storage
Pillar Storage with EHCC                                11.2.0.4.0                      0 EHCC used on tablespaces stored on Oracles Pillar Axiom Storage
Pro*C                                                   19.0.0.0.0                      1 Pro*C used
Pro*Cobol                                               19.0.0.0.0                      0 Pro*Cobol used
Pro*Fortran                                             19.0.0.0.0                      0 Pro*Fortran used
RMAN - Tape Backup                                      19.0.0.0.0                     14 Recovery Manager (RMAN) is being used to backup the database to tape.
ROracle                                                 19.0.0.0.0                      0 ROracle used
Ruby-oci8                                               19.0.0.0.0                      0 Ruby-oci8 used
SecureFile Compression (system)                         11.2.0.4.0                      0 SecureFile Compression is being used by system users
SecureFile Compression (user)                           11.2.0.4.0                      0 SecureFile Compression is being used
SecureFile Deduplication (system)                       11.2.0.4.0                      0 SecureFile Deduplication is being used by system users
SecureFile Deduplication (user)                         11.2.0.4.0                      0 SecureFile Deduplication is being used
SecureFile Encryption (system)                          11.2.0.4.0                      0 SecureFile Encryption is being used by system users
SecureFile Encryption (user)                            11.2.0.4.0                      0 SecureFile Encryption is being used
SecureFiles (system)                                    11.2.0.4.0                      0 SecureFiles is being used by system users
SecureFiles (user)                                      11.2.0.4.0                    297 SecureFiles is being used
Segment Advisor (user)                                  11.2.0.4.0                      0 Segment Advisor has been used. There is at least one user task executed.
Segment Shrink                                          11.2.0.4.0                      0 Segment Shrink has been used.
Semantics/RDF                                           11.2.0.4.0                      0 A semantic network has been created indicating usage of the RDF Semantic Graph feature of Oracle Spa
                                                                                          tial and Graph.

Services                                                11.2.0.4.0                      0 Oracle Services.
Spatial                                                 11.2.0.4.0                      0 There is at least one usage of the Oracle Spatial feature usage table.
Sun ZFS with EHCC                                       11.2.0.4.0                      0 EHCC used on tablespaces stored on Oracles Sun ZFS Storage
ZFS Storage                                             11.2.0.4.0                      0 Tablespaces stored on Oracles Sun ZFS Storage
cx_Oracle                                               19.0.0.0.0                      0 cx_Oracle used
node-oraceldb                                           19.0.0.0.0                      0 node-oraceldb used

50 rows selected.




SQL > select comp_id,comp_name,version,status,modified,schema,procedure from dba_registry  order by 1;

COMP_ID                        COMP_NAME                           VERSION                        STATUS                            MODIFIED                   SCHEM PROCEDURE
------------------------------ ----------------------------------- ------------------------------ --------------------------------- -------------------------- ----- -----------------------------------
CATALOG                        Oracle Database Catalog Views       19.0.0.0.0                     VALID                             18-SEP-2020 16:37:53       SYS   DBMS_REGISTRY_SYS.VALIDATE_CATALOG
CATPROC                        Oracle Database Packages and Types  19.0.0.0.0                     VALID                             18-SEP-2020 16:37:53       SYS   DBMS_REGISTRY_SYS.VALIDATE_CATPROC
RAC                            Oracle Real Application Clusters    19.0.0.0.0                     OPTION OFF                        18-SEP-2020 16:14:33       SYS   DBMS_CLUSTDB.VALIDATE
XDB                            Oracle XML Database                 19.0.0.0.0                     VALID                             18-SEP-2020 16:37:55       XDB   DBMS_REGXDB.VALIDATEXDB

