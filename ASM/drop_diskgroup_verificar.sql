11gR2 (11.2.0.1) ORA-15027: active use of diskgroup precludes its dismount (With no database clients connected) (Doc ID 1082876.1)


Dropnado disco no Exadata:

SQL> select name, header_status, path from v$asm_disk;


alter diskgroup data drop disk DATA_CD_DISK05_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK09_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK01_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK12_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK07_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK11_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK08_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK03_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK10_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK04_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK02_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK06_STOCELL2;
alter diskgroup data drop disk DATA_CD_DISK10_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK02_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK09_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK04_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK08_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK06_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK07_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK12_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK03_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK01_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK05_STOCELL1;
alter diskgroup data drop disk DATA_CD_DISK11_STOCELL1;


 CREATE DISKGROUP DATA NORMAL REDUNDANCY  DISK 
'o/192.168.10.20/DATA_CD_DISK01_stocell1',
'o/192.168.10.20/DATA_CD_DISK02_stocell1',
'o/192.168.10.20/DATA_CD_DISK03_stocell1',
'o/192.168.10.20/DATA_CD_DISK04_stocell1',
'o/192.168.10.20/DATA_CD_DISK05_stocell1',
'o/192.168.10.20/DATA_CD_DISK06_stocell1',
'o/192.168.10.20/DATA_CD_DISK07_stocell1',
'o/192.168.10.20/DATA_CD_DISK08_stocell1',
'o/192.168.10.20/DATA_CD_DISK09_stocell1',
'o/192.168.10.20/DATA_CD_DISK10_stocell1',
'o/192.168.10.20/DATA_CD_DISK11_stocell1',
'o/192.168.10.20/DATA_CD_DISK12_stocell1'
ATTRIBUTE 'compatible.asm'='11.2.0.4.0','compatible.rdbms'='11.1.0.7.0','au_size'='4M','cell.smart_scan_capable'='TRUE' /* ASMCA */;


'o/192.168.10.40/DATA_CD_DISK01_stocell1',
'o/192.168.10.40/DATA_CD_DISK02_stocell1',
'o/192.168.10.40/DATA_CD_DISK03_stocell1',
'o/192.168.10.40/DATA_CD_DISK04_stocell1',
'o/192.168.10.40/DATA_CD_DISK05_stocell1',
'o/192.168.10.40/DATA_CD_DISK06_stocell1',
'o/192.168.10.40/DATA_CD_DISK07_stocell1',
'o/192.168.10.40/DATA_CD_DISK08_stocell1',
'o/192.168.10.40/DATA_CD_DISK09_stocell1',
'o/192.168.10.40/DATA_CD_DISK10_stocell1',
'o/192.168.10.40/DATA_CD_DISK11_stocell1',
'o/192.168.10.40/DATA_CD_DISK12_stocell1' 

Possivel erro:

SQL> DROP DISKGROUP data INCLUDING CONTENTS;
DROP DISKGROUP data INCLUDING CONTENTS
*
ERROR at line 1:
ORA-15039: diskgroup not dropped
ORA-15027: active use of diskgroup "DATA" precludes its dismount


SQL> select * from v$asm_client;

no rows selected

SQL> show parameter instance_type

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
instance_type                        string      asm
SQL> show parameter spfile

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
spfile                               string      +DATA/asm/asmparameterfile/reg
                                                 istry.253.867703287
SQL> create pfile='$ORACLE_HOME/dbs/init+ASM.ora' from spfile='+DATA/asm/asmparameterfile/registry.253.867703287';

File created.

SQL> shutdown immediate;
ASM diskgroups dismounted
ASM instance shutdown
SQL> startup pfile=$ORACLE_HOME/dbs/init+ASM.ora
ASM instance started

Total System Global Area 1135747072 bytes
Fixed Size                  2260728 bytes
Variable Size            1108320520 bytes
ASM Cache                  25165824 bytes
ASM diskgroups mounted
SQL> DROP DISKGROUP data INCLUDING CONTENTS;

Diskgroup dropped.

