
Criando ja com todos os discos:

CREATE DISKGROUP DATA NORMAL REDUNDANCY 
FAILGROUP controller1 DISK 
'o/192.168.10.20/DATA_CD_DISK01_stocell1','o/192.168.10.20/DATA_CD_DISK02_stocell1','o/192.168.10.20/DATA_CD_DISK03_stocell1',
'o/192.168.10.20/DATA_CD_DISK04_stocell1','o/192.168.10.20/DATA_CD_DISK05_stocell1','o/192.168.10.20/DATA_CD_DISK06_stocell1',
'o/192.168.10.20/DATA_CD_DISK07_stocell1','o/192.168.10.20/DATA_CD_DISK08_stocell1','o/192.168.10.20/DATA_CD_DISK09_stocell1',
'o/192.168.10.20/DATA_CD_DISK10_stocell1','o/192.168.10.20/DATA_CD_DISK11_stocell1','o/192.168.10.20/DATA_CD_DISK12_stocell1'
FAILGROUP controller2 DISK 
'o/192.168.10.40/DATA_CD_DISK01_stocell1','o/192.168.10.40/DATA_CD_DISK02_stocell2','o/192.168.10.40/DATA_CD_DISK03_stocell1',
'o/192.168.10.40/DATA_CD_DISK04_stocell1','o/192.168.10.40/DATA_CD_DISK05_stocell2','o/192.168.10.40/DATA_CD_DISK06_stocell1',
'o/192.168.10.40/DATA_CD_DISK07_stocell1','o/192.168.10.40/DATA_CD_DISK08_stocell2','o/192.168.10.40/DATA_CD_DISK09_stocell1',
'o/192.168.10.40/DATA_CD_DISK10_stocell1','o/192.168.10.40/DATA_CD_DISK11_stocell2','o/192.168.10.40/DATA_CD_DISK12_stocell1' 
ATTRIBUTE 'compatible.asm'='11.2.0.4.0','compatible.rdbms'='11.1.0.7.0','au_size'='4M','cell.smart_scan_capable'='TRUE';


Criando apenas com a celular 1 de storage e depois adiconei discos conforme abaixo:
CREATE DISKGROUP DATA NORMAL REDUNDANCY 
FAILGROUP controller1 DISK 
'o/192.168.10.20/DATA_CD_DISK01_stocell1','o/192.168.10.20/DATA_CD_DISK02_stocell1','o/192.168.10.20/DATA_CD_DISK03_stocell1',
'o/192.168.10.20/DATA_CD_DISK04_stocell1','o/192.168.10.20/DATA_CD_DISK05_stocell1','o/192.168.10.20/DATA_CD_DISK06_stocell1'
FAILGROUP controller2 DISK 
'o/192.168.10.20/DATA_CD_DISK07_stocell1','o/192.168.10.20/DATA_CD_DISK08_stocell1','o/192.168.10.20/DATA_CD_DISK09_stocell1',
'o/192.168.10.20/DATA_CD_DISK10_stocell1','o/192.168.10.20/DATA_CD_DISK11_stocell1','o/192.168.10.20/DATA_CD_DISK12_stocell1'
ATTRIBUTE 'compatible.asm'='11.2.0.4.0','compatible.rdbms'='11.1.0.7.0','au_size'='4M','cell.smart_scan_capable'='TRUE';


Adicionando discos:

ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK01_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK02_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK03_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK04_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK05_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK06_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK07_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK08_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK09_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK10_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER1 DISK 'o/192.168.10.40/DATA_CD_DISK11_stocell2' REBALANCE POWER 11;
ALTER DISKGROUP DATA ADD FAILGROUP CONTROLLER2 DISK 'o/192.168.10.40/DATA_CD_DISK12_stocell2' REBALANCE POWER 11;

SQL> SELECT g.group_number diskgroup#,
g.name diskgroup,
g.type,
d.failgroup,
d.name disk_name,
d.path disk_path
FROM v$asm_diskgroup g,
v$asm_disk d
where d.group_number= g.group_number;  2    3    4    5    6    7    8    9

DISKGROUP# DISKGROUP                      TYPE   FAILGROUP                      DISK_NAME                      DISK_PATH
---------- ------------------------------ ------ ------------------------------ ------------------------------ ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK04_STOCELL2        o/192.168.10.40/DATA_CD_DISK04_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK01_STOCELL1        o/192.168.10.20/DATA_CD_DISK01_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK08_STOCELL2        o/192.168.10.40/DATA_CD_DISK08_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK01_STOCELL2        o/192.168.10.40/DATA_CD_DISK01_stocell2
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK12_STOCELL2        o/192.168.10.40/DATA_CD_DISK12_stocell2
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK02_STOCELL2        o/192.168.10.40/DATA_CD_DISK02_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK07_STOCELL2        o/192.168.10.40/DATA_CD_DISK07_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK09_STOCELL2        o/192.168.10.40/DATA_CD_DISK09_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK05_STOCELL2        o/192.168.10.40/DATA_CD_DISK05_stocell2
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK06_STOCELL2        o/192.168.10.40/DATA_CD_DISK06_stocell2
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK11_STOCELL2        o/192.168.10.40/DATA_CD_DISK11_stocell2
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK10_STOCELL2        o/192.168.10.40/DATA_CD_DISK10_stocell2
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK07_STOCELL1        o/192.168.10.20/DATA_CD_DISK07_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK09_STOCELL1        o/192.168.10.20/DATA_CD_DISK09_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK12_STOCELL1        o/192.168.10.20/DATA_CD_DISK12_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK08_STOCELL1        o/192.168.10.20/DATA_CD_DISK08_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK02_STOCELL1        o/192.168.10.20/DATA_CD_DISK02_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK05_STOCELL1        o/192.168.10.20/DATA_CD_DISK05_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK03_STOCELL1        o/192.168.10.20/DATA_CD_DISK03_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK11_STOCELL1        o/192.168.10.20/DATA_CD_DISK11_stocell1
         1 DATA                           NORMAL CONTROLLER2                    DATA_CD_DISK10_STOCELL1        o/192.168.10.20/DATA_CD_DISK10_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK06_STOCELL1        o/192.168.10.20/DATA_CD_DISK06_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK04_STOCELL1        o/192.168.10.20/DATA_CD_DISK04_stocell1
         1 DATA                           NORMAL CONTROLLER1                    DATA_CD_DISK03_STOCELL2        o/192.168.10.40/DATA_CD_DISK03_stocell2


Verifica o Estado do disco no servidor de celula:

[celladmin@stocell2 ~]$ cellcli -e list griddisk attributes name,asmmodestatus,asmdeactivationoutcome
         DATA_CD_DISK01_stocell2         ONLINE  Yes
         DATA_CD_DISK02_stocell2         ONLINE  Yes
         DATA_CD_DISK03_stocell2         ONLINE  Yes
         DATA_CD_DISK04_stocell2         ONLINE  Yes
         DATA_CD_DISK05_stocell2         ONLINE  Yes
         DATA_CD_DISK06_stocell2         ONLINE  Yes
         DATA_CD_DISK07_stocell2         ONLINE  Yes
         DATA_CD_DISK08_stocell2         ONLINE  Yes
         DATA_CD_DISK09_stocell2         ONLINE  Yes
         DATA_CD_DISK10_stocell2         ONLINE  Yes
         DATA_CD_DISK11_stocell2         UNUSED  Yes
         DATA_CD_DISK12_stocell2         UNUSED  Yes
