11gR2 (11.2.0.1) ORA-15027: active use of diskgroup precludes its dismount (With no database clients connected) (Doc ID 1082876.1)


Dropnado disco no Exadata:

SQL> 
set lines 1000
col PATH for a15
select name, header_status, path, OS_MB,TOTAL_MB, FREE_MB from v$asm_disk order by 1;


alter diskgroup datac1 drop disk DATA13;
alter diskgroup datac1 drop disk DATA14;
alter diskgroup datac1 drop disk DATA15;

DATA13
DATA14
DATA15

alter diskgroup reco drop disk RECO_0000;

ALTER DISKGROUP DATAC1 DROP DISK 'DATA16';


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

Possivel erro:

SQL> DROP DISKGROUP RECOC1 INCLUDING CONTENTS;
DROP DISKGROUP data INCLUDING CONTENTS
*
ERROR at line 1:
ORA-15039: diskgroup not dropped
ORA-15027: active use of diskgroup "DATA" precludes its dismount

ALTER DISKGROUP RECOC1 MOUNT FORCE;

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

