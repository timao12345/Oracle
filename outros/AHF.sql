#Atualizar ferramentas de nuvem

dbaascli admin updateStack



###Atualizar AHF

ahfctl update

#

[root@exacc01-7jrgw1 ~]# tfactl print status
WARNING - AHF Software is older than 180 days. Please consider upgrading AHF to the latest version using ahfctl upgrade.

.------------------------------------------------------------------------------------------------------.
| Host           | Status of TFA | PID   | Port | Version    | Build ID             | Inventory Status |
+----------------+---------------+-------+------+------------+----------------------+------------------+
| exacc01-7jrgw1 | RUNNING       | 50048 | 5000 | 21.1.4.0.0 | 21140020210628122659 | COMPLETE         |
| exacc01-7jrgw2 | RUNNING       | 47525 | 5000 | 21.1.4.0.0 | 21140020210628122659 | COMPLETE         |
'----------------+---------------+-------+------+------------+----------------------+------------------'
[root@exacc01-7jrgw1 ~]#



[root@exacc01db01vmc01 ~]# tfactl print status

.---------------------------------------------------------------------------------------------------------.
| Host             | Status of TFA | PID   | Port | Version    | Build ID              | Inventory Status |
+------------------+---------------+-------+------+------------+-----------------------+------------------+
| exacc01db01vmc01 | RUNNING       | 54849 | 5000 | 23.9.5.0.0 | 230950020231204212435 | COMPLETE         |
| exacc01db02vmc01 | RUNNING       | 55523 | 5000 | 23.9.5.0.0 | 230950020231204212435 | COMPLETE         |
'------------------+---------------+-------+------+------------+-----------------------+------------------'
[root@exacc01db01vmc01 ~]#


#Download AHF - https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=372603001803052&id=2550798.1&_afrWindowMode=0&_adf.ctrl-state=clqi61bdh_4

Mover para o servidor e descompactar

[root@exacc01-7jrgw2 ahf]# ll
total 843728
-rwxrwxrwx 1 oracle oinstall 420034739 Feb  7 17:35 AHF-LINUX_v24.1.0.zip
-rwx------ 1 root   root     443919910 Feb  5 21:09 ahf_setup
-rw------- 1 root   root           384 Feb  5 21:09 ahf_setup.dat
-r-------- 1 root   root           625 Feb  5 21:10 oracle-tfa.pub
-r-xr-x--- 1 root   root          1537 Feb  5 21:10 README.txt
[root@exacc01-7jrgw2 ahf]#
[root@exacc01-7jrgw2 ahf]#
[root@exacc01-7jrgw2 ahf]# ./ahf_setup



#Documento do AHF

https://docs.oracle.com/en/engineered-systems/health-diagnostics/autonomous-health-framework/ahfug/install-upgrade-ahf.html#GUID-41689DF9-F81D-4C8C-992F-78CF48F9B6DF


-- doc para desinstalar AHF
https://docs.oracle.com/en/engineered-systems/health-diagnostics/autonomous-health-framework/ahfug/uninstall-ahf.html#GUID-663F0836-A2A2-4EFB-B19E-EABF303739A9



-- funcional
tfactl diagcollect -from "2025-08-20 09:00:00" -to "2025-08-20 11:00:00" -noclassify

tfactl diagcollect -from "2025-08-01" -to "2025-08-31"


./GetExaWatcherResults.sh --from 07/16/2025_15:00:00 --to 07/16/2025_21:00:00

tfactl diagcollect -all -from "MON/DD/YYYY HH24:MI:SS" -to "MON/DD/YYYY HH24:MI:SS"

for "Mar/2/2013 21:00:00"

AHF_HOME=/opt/oracle.ahf
BUILD_VERSION=2502400
BUILD_DATE=202504271231
PREV_BUILD_VR=2409000
INSTALL_TYPE=TYPICAL
CRS_HOME=/u01/app/23.0.0.0/grid
TFA_HOME=/opt/oracle.ahf/tfa
EXACHK_HOME=/opt/oracle.ahf/exachk
AHF_DIR=/opt/oracle.ahf/ahf
COMMON_DIR=/opt/oracle.ahf/common
JLIB_DIR=/opt/oracle.ahf/common/jlib
ACR_DIR=/opt/oracle.ahf/common/acr
JAVA_HOME=/opt/oracle.ahf/jre
PYTHON_HOME=/opt/oracle.ahf/common/venv
CVU_LOC=/opt/oracle.ahf/common/cvu

DATA_DIR=/u02/oracle.ahf/data
TFA_DATA_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/tfa
EXACHK_DATA_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/exachk
REPOSITORY=/u02/oracle.ahf/data/repository
WORK_DIR=/u02/oracle.ahf/data/work
DIAG_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag
TFA_DIAG_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag/tfa
EXACHK_DIAG_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag/exachk
COMMON_DATA_DIR=/u02/oracle.ahf/data/exacc01-kpv-prd-db01/common

INSTALL_USER=root
ENV_TYPE=EXACC
PERL=/bin/perl
SI_ENV=0
DATABASE_CLIENT_DIR=/u01/app/23.0.0.0/grid



ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/tfa
ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/exachk
ls -l /u02/oracle.ahf/data/repository
ls -l /u02/oracle.ahf/data/work
ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag
ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag/tfa
ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/diag/exachk
ls -l /u02/oracle.ahf/data/exacc01-kpv-prd-db01/common



mkdir acr
mkdir ahf
mkdir balance
mkdir cha
mkdir chm
mkdir common
mkdir diag
mkdir exachk
mkdir shm
mkdir tfa