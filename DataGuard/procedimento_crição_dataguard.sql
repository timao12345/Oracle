1 - IP  ORAODSTB578B / 192.168.199.121
RH 6.5 e foi instalado atrav�s de um template do VM que j� est� customizado pelo UOLDiveo
	     
2 - USU�RIO / SENHA
dcadmin dhc !@#

3 - VALIDAR PACOTES
./runcluvfy.sh stage -pre crsinst -n RAC01,RAC02 -fixup -verbose

Oracle Linux 6 and Red Hat Enterprise Linux 6 
The following packages (or later versions) must be installed:

binutils-2.20.51.0.2-5.11.el6 (x86_64)
compat-libcap1-1.10-1 (x86_64)
compat-libstdc++-33-3.2.3-69.el6 (x86_64)
compat-libstdc++-33-3.2.3-69.el6.i686
gcc-4.4.4-13.el6 (x86_64)
gcc-c++-4.4.4-13.el6 (x86_64)
glibc-2.12-1.7.el6 (i686)
glibc-2.12-1.7.el6 (x86_64)
glibc-devel-2.12-1.7.el6 (x86_64)
glibc-devel-2.12-1.7.el6.i686
ksh
libgcc-4.4.4-13.el6 (i686)
libgcc-4.4.4-13.el6 (x86_64)
libstdc++-4.4.4-13.el6 (x86_64)
libstdc++-4.4.4-13.el6.i686
libstdc++-devel-4.4.4-13.el6 (x86_64)
libstdc++-devel-4.4.4-13.el6.i686
libaio-0.3.107-10.el6 (x86_64)
libaio-0.3.107-10.el6.i686
libaio-devel-0.3.107-10.el6 (x86_64)
libaio-devel-0.3.107-10.el6.i686
make-3.81-19.el6
sysstat-9.0.4-11.el6 (x86_64)

On Oracle Linux 6 and Red Hat Enterprise Linux 6:

unixODBC-2.2.14-11.el6.i686 or later
unixODBC-devel-2.2.14-11.el6.i686 or later


4 - INSTALAR ORACLEASM LIB
CRIAR DISCOS

5 -
INSTALAR BINARIO GRID
owner grid
ORACLE_BASE=/u01/app/grid
ORACLE_HOME=/u01/app/11.2.0/grid_p4
Vers�es do Oracle GI - 11.2.0.4 + CPU Jun2014 (11.2.0.4.3)

6 - 
INSTALAR BIN�RIO ORACLE
owner ebs
ORACLE_BASE=/u02/app/oracle
ORACLE_HOME=/u02/app/oracle/product/11.2.0/ebs_p4
Vers�es do Oracle GI - 11.2.0.4 + CPU Jun2014 (11.2.0.4.3) + Patch 17501296

7 - 
Configurar a replica��o fisica com o banco EBS dos servidores ORAERPTB578A/ORAERPTB578B
Backup /work-tmp
Restore standby
Configurar no modo "Maximum Performance" 
Habilitar o Active Data Guard na replica.
Configurar o Data Guard Broker.



--pre instala��o
grep MemTotal /proc/meminfo	1.5gb
grep SwapTotal /proc/meminfo	1.5gb
df -h /tmp			1.0gb			


--pacotes
wget http://public-yum.oracle.com/public-yum-ol6.repo
wget http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
yum install oracle-rdbms-server-11gR2-preinstall

OU

[ol6_u5_base]
name=Oracle Linux $releasever Update 5 installation media copy ($basearch)
baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL6/5/base/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1

Oracle Linux 6 and Red Hat Enterprise Linux 6 
The following packages (or later versions) must be installed:

binutils-2.20.51.0.2-5.11.el6 (x86_64)
compat-libcap1-1.10-1 (x86_64)
compat-libstdc++-33-3.2.3-69.el6 (x86_64)
compat-libstdc++-33-3.2.3-69.el6.i686
gcc-4.4.4-13.el6 (x86_64)
gcc-c++-4.4.4-13.el6 (x86_64)
glibc-2.12-1.7.el6 (i686)
glibc-2.12-1.7.el6 (x86_64)
glibc-devel-2.12-1.7.el6 (x86_64)
glibc-devel-2.12-1.7.el6.i686
ksh
libgcc-4.4.4-13.el6 (i686)
libgcc-4.4.4-13.el6 (x86_64)
libstdc++-4.4.4-13.el6 (x86_64)
libstdc++-4.4.4-13.el6.i686
libstdc++-devel-4.4.4-13.el6 (x86_64)
libstdc++-devel-4.4.4-13.el6.i686
libaio-0.3.107-10.el6 (x86_64)
libaio-0.3.107-10.el6.i686
libaio-devel-0.3.107-10.el6 (x86_64)
libaio-devel-0.3.107-10.el6.i686
make-3.81-19.el6
sysstat-9.0.4-11.el6 (x86_64)

On Oracle Linux 6 and Red Hat Enterprise Linux 6:

unixODBC-2.2.14-11.el6.i686 or later
unixODBC-devel-2.2.14-11.el6.i686 or later

--usu�rios
Create Groups:
/usr/sbin/groupadd  oinstall
/usr/sbin/groupadd  asmadmin
/usr/sbin/groupadd  dba
/usr/sbin/groupadd  oper
/usr/sbin/groupadd  asmdba
/usr/sbin/groupadd  asmoper

Create Users
/usr/sbin/useradd  -g oinstall -G asmdba,dba,asmoper,asmadmin ebs (so2006azu)
/usr/sbin/useradd  -g oinstall -G asmdba,dba,asmoper,asmadmin grid (so2006azu)

usermod  -g oinstall -G asmdba,dba,asmoper,asmadmin ebs

Create Directories
mkdir -p /u01/app/11.2.0/grid_p4 
mkdir -p /u02/app/oracle/product/11.2.0/ebs_p4
chown -R grid:oinstall /u01/
chown -R ebs:oinstall /u02/app/oracle
chmod -R 775 /u01/ 
chmod -R 775 /u02/app 


--valores atuais
[dcadmin@oraodstb578b ~]$ cat /proc/sys/kernel/shmmax
68719476736
[dcadmin@oraodstb578b ~]$ cat /proc/sys/kernel/shmall
4294967296
[dcadmin@oraodstb578b ~]$ getconf PAGE_SIZE
4096
[dcadmin@oraodstb578b ~]$ cat /proc/sys/kernel/shmmni
4096
[dcadmin@oraodstb578b ~]$ free -g
             total       used       free     shared    buffers     cached
Mem:            15          6          8          0          0          6
-/+ buffers/cache:          0         15
Swap:            1          0          1


-- Calcular de acordo com o banco que vai ser instalado o shmmax e shmall
SGA 8GB

shmall (paginas)
Converter 8GB em bytes e dividir pelo tamanho da pagina.
( 8 - 1024 - 1024 - 1024 ) / 4096 
2097152

shmmax (bytes)
8589934592
4398046511104


--parametros
/etc/security/limits.conf
# oracle-rdbms-server-11gR2-preinstall setting for nofile soft limit is 1024
oracle   soft   nofile    2047
grid   soft   nofile    1024
# oracle-rdbms-server-11gR2-preinstall setting for nofile hard limit is 65536
oracle   hard   nofile    65536
grid	   hard   nofile    65536
# oracle-rdbms-server-11gR2-preinstall setting for nproc soft limit is 16384
# refer orabug15971421 for more info.
oracle   soft   nproc    16384
grid	   soft   nproc    16384
# oracle-rdbms-server-11gR2-preinstall setting for nproc hard limit is 16384
oracle   hard   nproc    16384
grid	   hard   nproc    16384
# oracle-rdbms-server-11gR2-preinstall setting for stack soft limit is 10240KB
oracle   soft   stack    10240
grid	   soft   stack    10240
# oracle-rdbms-server-11gR2-preinstall setting for stack hard limit is 32768KB
oracle   hard   stack    32768
grid	   hard   stack    32768


/etc/pam.d/login
session	required	pam_limits.so




--asm lib
[dcadmin@oraodstb578b ~]$ uname -a
Linux oraodstb578b 2.6.32-431.20.5.el6.x86_64 #1 SMP Wed Jul 16 05:26:53 EDT 2014 x86_64 x86_64 x86_64 GNU/Linux
[dcadmin@oraodstb578b ~]$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 6.5 (Santiago)
[dcadmin@oraodstb578b ~]$
http://www.oracle.com/technetwork/server-storage/linux/asmlib/rhel6-1940776.html
https://support.oracle.com/epmos/faces/SearchDocDisplay?_adf.ctrl-state=n1pikphj4_4&_afrLoop=309298409503705#SCOPE

linux.x64_asmlib20_redhat6_oracleasmlib-2.0.4-1.el6.x86_64.rpm
linux.x64_asmlib20_redhat6_oracleasm-support-2.1.8-1.el6.x86_64.rpm
linux.x64_asmlib20_redhat6_kmod-oracleasm-2.0.6.rh1-2.el6.x86_64.rpm

[root@oraodstb578b dev]# ls sd-
sda  sda1  sda2  sdb  sdb1  sdc  sdd  sde  sdf  sdg  sdh

Disk /dev/sdc: 214.7 GB, 214748364800 bytes
Disk /dev/sdf: 214.7 GB, 214748364800 bytes
Disk /dev/sdd: 214.7 GB, 214748364800 bytes
Disk /dev/sdh: 214.7 GB, 214748364800 bytes
Disk /dev/sdg: 214.7 GB, 214748364800 bytes
Disk /dev/sde: 214.7 GB, 214748364800 bytes

fdisk /dev/sdc
fdisk /dev/sdf
fdisk /dev/sdd
fdisk /dev/sdh
fdisk /dev/sdg
fdisk /dev/sde

[root@oraodstb578b dev]# ls sd-
sda  sda1  sda2  sdb  sdb1  sdc  sdc1  sdd  sdd1  sde  sde1  sdf  sdf1  sdg  sdg1  sdh  sdh1

oracleasm init
oracleasm configure -i

--dados da produ��o
/etc/sysconfig/oracleasm
# ORACLEASM_ENABLED: 'true' means to load the driver on boot.
ORACLEASM_ENABLED=true
# ORACLEASM_UID: Default user owning the /dev/oracleasm mount point.
ORACLEASM_UID=grid
# ORACLEASM_GID: Default group owning the /dev/oracleasm mount point.
ORACLEASM_GID=asmadmin
# ORACLEASM_SCANBOOT: 'true' means scan for ASM disks on boot.
ORACLEASM_SCANBOOT=true
# ORACLEASM_SCANORDER: Matching patterns to order disk scanning
ORACLEASM_SCANORDER="dm"
# ORACLEASM_SCANEXCLUDE: Matching patterns to exclude disks from scan
ORACLEASM_SCANEXCLUDE="sd"
# ORACLEASM_USE_LOGICAL_BLOCK_SIZE: 'true' means use the logical block size
# reported by the underlying disk instead of the physical. The default
# is 'false'
ORACLEASM_USE_LOGICAL_BLOCK_SIZE=false

[dcadmin@oraerptb578a ~]$

/etc/init.d/oracleasm createdisk DATA1 /dev/sdc1
/etc/init.d/oracleasm createdisk DATA2 /dev/sdd1
/etc/init.d/oracleasm createdisk DATA3 /dev/sde1
/etc/init.d/oracleasm createdisk DATA4 /dev/sdf1
/etc/init.d/oracleasm createdisk DATA5 /dev/sdg1

/etc/init.d/oracleasm createdisk FRA1 /dev/sdh1

[root@oraodstb578b dev]# oracleasm listdisks
DATA1
DATA2
DATA3
DATA4
DATA5
FRA1
[root@oraodstb578b dev]#


--install grid
--bash
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
ORACLE_BASE=/u01/app/grid; export ORACLE_BASE
ORACLE_HOME=/u01/app/11.2.0/grid_p4; export ORACLE_HOME
ORACLE_SID=+ASM; export ORACLE_SID
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH

senhas asm:db2006azu
User: sys / Password: fYxIKnPUyAEi
User: asmsnmp / Password: D3KA0FZvxlUR

alter user sys identified by fYxIKnPUyAEi;
alter user  asmsnmp  identified by D3KA0FZvxlUR;




--erro elfutils-libelf-devel-0.97 And pdksh-5.2.14 Are Missing (PRVF-7532) - (Doc ID 1454982.1)

--ignorado erro de swapsize


--install oracle com ebs
--bash
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
ORACLE_BASE=/u02/app/oracle; export ORACLE_BASE
ORACLE_HOME=/u02/app/oracle/product/11.2.0/ebs_p4; export ORACLE_HOME
ORACLE_SID=; export ORACLE_SID
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH

install database software only

--ignorado erro de swapsize

--atualizar opatch
OPatch Version: 11.2.0.3.6


--aplicar  CPU Jun2014 (11.2.0.4.3)
como root
umask 022
/u01/app/11.2.0/grid_p4/OPatch/opatch auto /u01/stage/patch/18706472 -ocmrf /u01/ocm/ocm.rsp	
$ORACLE_HOME/OPatch/opatch lsinventory -detail -oh /u01/app/11.2.0/grid_p4
$ORACLE_HOME/OPatch/opatch lsinventory -detail -oh /u02/app/oracle/product/11.2.0/ebs_p4


umask 022
/u02/app/oracle/product/11.2.0/ebs_p4/OPatch/opatch auto /u01/stage/patch/18706472 -ocmrf /u01/ocm/ocm.rsp -oh 	/u02/app/oracle/product/11.2.0/ebs_p4
$ORACLE_HOME/OPatch/opatch lsinventory -detail -oh /u02/app/oracle/product/11.2.0/ebs_p4
--aplicar patch 17501296
/u02/app/oracle/product/11.2.0/ebs_p4/OPatch/opatch apply

Patch 18706472 - grid infrastructure system patch 11.2.0.4.3
Includes:
1. 11.2.0.4.3   DB PSU - Bug 18522509
2. 11.2.0.4.3  OCW PSU - Bug 18522515
3. 11.2.0.4.3 ACFS PSU - Bug 18522514



--criar orafra
CRIADO VIA ASMCA


--executar ap�s cria��o do banco
$ sqlplus /nolog         
        SQL> CONNECT / AS SYSDBA
        SQL> @?/sqlpatch/17501296/postinstall.sql

@?/rdbms/admin/catbundle.sql psu apply


--nfs
yum install nfs- -y

service rpcbind start
chkconfig rpcbind on
service nfs start
chkconfig nfs on

mount -t nfs 10.0.6.210:/home/work-tmp /work-tmp  -o rsize=65536,wsize=65536,hard,intr,nodev,nosuid,actimeo=0,nfsvers=3,noauto

--aplicar patch 18828868
como ebs
criar usu�rio dba
$ORACLE_HOME/OPatch/opatch apply online -connectString EBS_ODS:uoldiveo_dba:patch:

--------------------------------------------------------------------------
--dataguard
--pré requisitos
--------------------------------------------------------------------------
--Criado uma cópia do arquivo de inicilaização
	create pfile='/work-tmp/prod/initstdby.ora' from spfile;


DB_NAME=dupdb
CONTROL_FILES=(/oradata/dupdb/controlfile/control01.ctl, /oradata/dupdb/controlfile/control02.ctl)
DB_FILE_NAME_CONVERT=(/u01/app/oracle/oradata/ORCL/datafile,/oradata/dupdb/datafile)
LOG_FILE_NAME_CONVERT=(/u01/app/oracle/oradata/ORCL/onlinelog,/oradata/dupdb/onlinelog)

-- Copiar o controlfile de prod e colocar no ambiente de DR, deve ser alterado no arquivo pfile antes de iniciar a instancia.
cp /u01/exemplo/control01.ora /work-tmp/prod/control01.ora

--log_archive_format  devem ser iguais
	standby		log_archive_format                   string      %t_%s_%r.dbf
	producao	log_archive_format                   string      %t_%s_%r.dbf

--Copiado aqruivo de senha  da produção para standby
	remote_login_passwordfile=exclusive  em ambos
	scp orapwEBS1 ebs@10.0.6.95:/u02/app/oracle/product/11.2.0/ebs_p4/dbs/orapwEBS_ODS

--Acertar parametros de convert caso necessário , nesse caso  a estrutura é identica
ALTER SYSTEM SET db_FILE_NAME_CONVERT='+DATAC1','+DATAC2','+RECOC1','+RECOC2' scope=spfile;
ALTER SYSTEM SET log_file_name_convert='+DATAC1','+DATAC2','+RECOC1','+RECOC2' scope=spfile;

--Replicação de datafiles em ambos
alter system set standby_file_management=AUTO;

--Deixar Em defer até começar a replicar na produção
	log_archive_dest_2                   string
	log_archive_dest_state_2             string      DEFER

alter system set log_archive_dest_state_2='DEFER';
--Nome standby
	db_unique_name e service_names no standby EBS_ODS
	db_unique_name e service_names na produção EBS

--O mesmo deve estar com archivelog ativado (em ambos)

Habilitar o force logging  na produão
select force_logging from v$database;

alter database force logging;


--Aumentar 
	log_archive_max_processes 	PRODUÇÃO ATUAL 4
	LOG_ARCHIVE_MAX_PROCESSES = sum(remote_destinations) + count(threads)

--ORAPWD
	orapwd file=orapwEBS1  entries=5 FORCE=Y
	orapwd file=orapwEBS2  entries=5 FORCE=Y
	orapwd file=orapwEBS_ODS  entries=10 FORCE=Y
	password=sX2n7uKfb2yl 

PERFROMANCE
SQL> SELECT PROTECTION_MODE FROM V$DATABASE;

PROTECTION_MODE
--------------------
MAXIMUM PERFORMANCE



--------------------------------------------------------------------------
--dataguard
--configurar database primario
--------------------------------------------------------------------------
 Criando os serviços TNS
/u02/app/oracle/product/11.2.0/ebs_p4/network/admin/EBS_ORAERPTB578

EBS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oraerptb578-scan.azul.corp)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = EBS)
    )
  )

EBS_ODS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.0.6.95)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = EBS_ODS)
    )
  )

--configurar entrada oraodstb578b no /etc/hosts
x.x.x.x      oraodstb578b    oraodstb578b.azul.corp
teste com tnsping 


--------------------------------------------------------------------------
--dataguard
--configurar database standby
--------------------------------------------------------------------------
1 - CRIÇÃO DE DIRETÓRIOS  administrativos
ADUM , BDUMP .....

2 - Startup nomount com init retirado da produção
export ORACLE_SID=EBS_ODS
SERVICE_NAMES
create spfile='+DGDATA' from pfile;
altera iniEBS_ODS.ora = "spfile='+DGDATA/ebs_ods/parameterfile/spfile.256.860580543'"


3 - tnsnames.ora
cd $ORACLE_HOME/network/admin
EBS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.0.6.131)(PORT = 1522))
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.0.6.132)(PORT = 1522))
    (LOAD_BALANCE = yes)
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = EBS1)
    )
  )


EBS_ODS =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oraodstb578b)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = EBS_ODS)
    )
  )


LISTENER ESTATICO
SID_LIST_LISTENER =
        (SID_LIST=
	(SID_DESC=
		(GLOBAL_DBNAME=EBS_ODS)
		(SID_NAME=EBS_ODS)
        	(ORACLE_HOME=/u02/app/oracle/product/11.2.0/ebs_p4)
	)
    )


--------------------------------------------------------------------------
--dataguard
--backup / restore ou duplicate 
--------------------------------------------------------------------------
-- backup controlfile for standby, jogando em um filesystem local
run {
ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/u02/controlfile_standby_rcu_%U.ctl';
RELEASE CHANNEL c1;
}

-- backup controlfile for standby, jogando para a tape.
run {
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=SJP001,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=sjp_1313190983)';
BACKUP CURRENT CONTROLFILE FOR STANDBY;
RELEASE CHANNEL t1;
}

--POP
run {
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=POP001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_POP,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=pop_1059082765)';
BACKUP CURRENT CONTROLFILE FOR STANDBY;
RELEASE CHANNEL t1;
}

--SJP
run {
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=SJP001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_SJP,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=sjp_1313190983)';
BACKUP CURRENT CONTROLFILE FOR STANDBY;
RELEASE CHANNEL t1;
}

BACKUP FORMAT '/backup_acfs_sap/PSP/controlfile_standby_PSP_%U.ctl' tag BKP_CONTROLFILE_POP_STBY CURRENT CONTROLFILE FOR STANDBY;


run {
ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
BACKUP CURRENT CONTROLFILE FORMAT '/u02/controlfile_orarcu_%U.ctl';
RELEASE CHANNEL c1;
}

--BACKUP DO NÓ PRIMÁRIO
--backup  da produção
duração para fita apx 3hrs
executar para o /work-tmp em nohup

#!/bin/bash
export ORACLE_SID=EBS1
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> //work-tmp/prod/backupfull_EBS1.log 2>&1
run{
allocate channel c1 device type disk format '/work-tmp/prod/%d_%I_%p_%s';
backup as compressed backupset database plus archivelog;
backup current controlfile for standby format '/work-tmp/prod/controlfile_atual.bkp';
}
exit
EOF

--Restore no ambiente standby a partir de um backup existente
restore controlfile from '/work-tmp/prod/controlfile_atual.bkp';
alter database mount;
crosscheck archivelog all;
delete noprompt expired archivelog all;

#!/bin/bash
export ORACLE_SID=stdby
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /work-tmp/prod/restore_stdby.log 2>&1
run {
allocate channel c1 device type disk;
restore database;
recover database;
}

-- ou de produção logar no rman e executar o duplicate
export ORACLE_SID=ORCLDR
rman target sys/123456@TESTE2 auxiliary  /
duplicate target database to ORCLDR for standby;

-- pode criar o script e rodar em nohup duplicate_ebs_ods.sh
#!/bin/bash
#
# Backup via RMAN
#
BKP_DIR=/work-tmp/prod
rm -f log=$BKP_DIR/duplicate.log
$ORACLE_HOME/bin/rman target sys/123456@TESTE auxiliary sys/123456@ORCLDR @$BKP_DIR/duplicate_ebs_ods.rcv log=$BKP_DIR/duplicate_ebs_ods.log



run {
allocate channel pri1 type disk;
allocate channel pri2 type disk;
ALLOCATE AUXILIARY CHANNEL c1 TYPE DISK;
ALLOCATE AUXILIARY CHANNEL c2 TYPE DISK;
duplicate target database for standby from active database NOFILENAMECHECK;
}


NOFILENAMECHECK; -->> RMAN-05001: auxiliary file name +DGDATA/ebs/datafile/system.335.848395175 conflicts with a file used by the target database


nohup ./duplicate_ebs_ods.sh &

--------------------------------------------------------------------------
--dataguard
--após duplicate
--------------------------------------------------------------------------
Criar os arquivos de standby redolog 1 membro por grupo na produ��o e standby 
	maximum number of logfiles for each thread + 1 -maximum number of thcat reads
SELECT GROUP#,THREAD#,SEQUENCE#,ARCHIVED,STATUS FROM V$STANDBY_LOG;

--producao
alter database add standby logfile thread 1 group 20  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 21  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 22  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 23  '+DATAC1' size 4000m;


alter database add standby logfile thread 2 group 24  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 25  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 26  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 27  '+DATAC1' size 4000m;



 
--standby
alter database add standby logfile thread 1 group 20  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 21  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 22  '+DATAC1' size 4000m;
alter database add standby logfile thread 1 group 23  '+DATAC1' size 4000m;

alter database add standby logfile thread 2 group 24  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 25  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 26  '+DATAC1' size 4000m;
alter database add standby logfile thread 2 group 27  '+DATAC1' size 4000m;



--Parametros de inicialização na produção (primary)
-- obs: não esquecer de levar o arquivo de senha de prod para o standby

alter system set log_archive_dest_2='SERVICE=ECCSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_2='SERVICE=SJPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=SJPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_2='SERVICE=POPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=POPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_2='SERVICE=LTPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=LTPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_2='SERVICE=PSPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=PSPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;

-- sap ecc
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(ECC,ECCSTBY)' scope=both; 
ALTER SYSTEM SET log_archive_dest_2='SERVICE=ECCSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

--sap ltp
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(LTP,LTPSTBY)' scope=both;
alter system set log_archive_dest_2='SERVICE=LTPSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=LTPSTBY' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both;
alter system set log_archive_dest_state_2='ENABLE' scope=both;

--sap sjp
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(SJPSTBY,SJP)' scope=both; 
alter system set log_archive_dest_2='SERVICE=SJPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=SJPSTBY' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

--sap pop
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(POP,POPSTBY)' scope=both; 
alter system set log_archive_dest_2='SERVICE=POPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=POPSTBY' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

--sap psp
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(PSP,PSPSTBY)' scope=both; 
alter system set log_archive_dest_2='SERVICE=PSPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=PSPSTBY' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

-- kpv
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(KPVPRD,KPVSTBY)' scope=both; 
alter system set log_archive_dest_2='SERVICE=kpvstby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=kpvstby NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

-- orarcu
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(ORARCU_55B_GRU,ORARCUSTBY)' scope=both; 
alter system set log_archive_dest_2='SERVICE=orarcustby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=orarcustby NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;

alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;

-- apex
alter system set LOG_ARCHIVE_MAX_PROCESSES = 4 scope=both;
alter system set log_archive_config ='DG_CONFIG=(APEXPRD,APEXSTBY)' scope=both; 
ALTER SYSTEM SET log_archive_dest_2='SERVICE=APEXSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=APEXSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both;
alter system set log_archive_dest_state_2='DEFER' scope=both; 
alter system set log_archive_dest_state_2='ENABLE' scope=both;


-- valida nos dois nodes
SELECT DEST_ID, STATUS, ERROR, DESTINATION FROM V$ARCHIVE_DEST WHERE DEST_ID=2;

-- opções diferentes do log_archive_dest_2
alter system set log_archive_dest_2='service="kpvstby", ASYNC NOAFFIRM delay=0 optional compression=disable max_failure=0 reopen=300 db_unique_name="kpvstby" net_timeout=30, valid_for=(online_logfile,all_roles)';
alter system set log_archive_dest_2='SERVICE=kpvstby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=kpvstby'
ALTER SYSTEM SET log_archive_dest_2='SERVICE=kpvstby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=kpvstby NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5';



-- alterar por ultimo no primary
alter system set fal_server=kpvstby;
alter system set fal_client=KPVPRD;

alter system set LOG_ARCHIVE_DEST_STATE_2=DEFER scope=both; 
alter system set LOG_ARCHIVE_DEST_STATE_2=ENABLE scope=both;  

ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT=AUTO;

alter system set fal_client='ECC001' scope=both;
alter system set fal_server='ECCSTBY' scope=both;

--Parametros de inicialização no STANDBY
alter system set log_archive_config ='dg_config=(APEXSTBY,APEXPRD)' scope=both; 
alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=KPVPRD' scope=both;  -- se estiver configurado, não alterar
alter system set log_archive_dest_2='SERVICE=KPVSTBY ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=KPVSTBY' scope=both; -- opcional no standby.


alter system set log_archive_dest_state_2='ENABLE' scope=both; 
alter system set log_archive_dest_state_2='DEFER' scope=both; 

ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT=AUTO SCOPE=BOTH;
ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT='MANUAL' SCOPE=BOTH;

ALTER SYSTEM SET FAL_CLIENT='ECCSTBY' SCOPE=BOTH;
ALTER SYSTEM SET FAL_SERVER='ECC' SCOPE=BOTH;


-- Maximum Protection. - SYNC
/*
Aguarda a confirmação de que os dados foram gravados no destino de standby antes de confirmar a gravação no destino primário.
Isso garante que nenhum dado seja perdido em caso de falha do sistema primário. No entanto, isso pode impactar o desempenho, pois o processo de gravação depende da resposta do destino de standby.
*/
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY AFFIRM SYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY';
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PROTECTION;
ALTER DATABASE OPEN;

-- Maximum Availability. SYNC -  FAST SYNC  -  FAR SYNC
/*
Aguarda a confirmação de que os dados foram gravados no destino de standby antes de confirmar a gravação no destino primário, 
mas permite que o banco de dados continue operando mesmo que o destino de standby não esteja disponível temporariamente.
*/
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY AFFIRM SYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY';
ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE AVAILABILITY;

-- Maximum Performance. - ASYNC
/*
Nunca espera pela confirmação do destino de standby antes de confirmar a gravação do REDO no primário, primary continua normalmente mesmo que o destino de standby não esteja disponível
Isso maximiza o desempenho do banco de dados primário, mas pode resultar em perda de dados se o destino de standby não estiver sincronizado no momento de uma falha.
*/
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY ASYNC NOAFFIRM VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY';
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY ASYNC NOAFFIRM VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY' scope=both sid='ECC001';

ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE NET_TIMEOUT=300 REOPEN=120 VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY';
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=ECCSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY' scope=both sid='*';

alter system set log_archive_dest_2='service="ECCSTBY", ASYNC NOAFFIRM delay=0 optional compression=disable max_failure=0 reopen=300 db_unique_name="kpvstby" net_timeout=30, valid_for=(online_logfile,all_roles)';

ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE PERFORMANCE;

--HABILITAR ORACLE DATAGUARD
select name, db_unique_name, database_role from v$database; 
alter database recover managed standby database disconnect ;

KPVPRD =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST=exacc01-scan.rootbrasil.intranet)(PORT=1521))
      (CONNECT_DATA =
        (SERVER = DEDICATED)
        (SERVICE_NAME = kpvprd.rootbrasil.intranet)
      )
     )

--VALIDAÇÕES
rman target sys@ECCSTBY auxiliary sys@ECC
RMAN> RECOVER DATABASE FROM SERVICE 'ECC';

--Check database status primary and standby
SELECT PROTECTION_MODE,PROTECTION_LEVEL,DATABASE_ROLE ROLE,SWITCHOVER_STATUS FROM V$DATABASE;



alter system switch logfile;  
ALTER SYSTEM ARCHIVE LOG CURRENT;


select to_char(COMPLETION_TIME, 'dd/mm/yyyy hh24:mi') COMPLETION_TIME, SEQUENCE#, ARCHIVED, APPLIED, DELETED
from v$archived_log
where sequence#=(select max(SEQUENCE#)
                   from v$archived_log
                   where APPLIED='YES'); 


select to_char(COMPLETION_TIME, 'dd/mm/yyyy hh24:mi') COMPLETION_TIME, THREAD#, SEQUENCE#, ARCHIVED, APPLIED, DELETED
from v$archived_log;


--Tempo de diferença da produção:
select (sysdate - controlfile_time) -24-60 from v$database;   --> em minutos

select (sysdate - controlfile_time) from v$database; --> em dias



--verificação pelo SCN
[Standby] 
select to_char(current_scn) from v$database;

[Primary]
select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;

6018120185105

--primary
set lines 200
col dest_name format a50
select DEST_ID,DEST_NAME,STATUS,ERROR from V$ARCHIVE_DEST_STATUS;

col dest_name for a20
col status for a15
set lines 160
set pages 300
select dest_id, dest_name, status, database_mode, error, SYNCHRONIZED, GAP_STATUS from v$archive_dest_status;


--standby or primary

col message format a65
select to_char(timestamp,'DD/MM/YYYY HH24:MI:SS'), message from v$dataguard_status;


--verifica��o archives
set lines 300 pages 10000
select process, client_process, thread#, sequence#, status, block#, blocks, (blocks-512) as bytes
from V$managed_standby;
SQL>   2
PROCESS   CLIENT_P    THREAD#  SEQUENCE# STATUS           BLOCK#     BLOCKS      BYTES
--------- -------- ---------- ---------- ------------ ---------- ---------- ----------
ARCH      ARCH              1       5344 CLOSING            2048       1772     907264
ARCH      ARCH              1       5345 CLOSING           32768        942     482304
ARCH      ARCH              0          0 CONNECTED             0          0          0
ARCH      ARCH              1       5343 CLOSING               1        178      91136
RFS       ARCH              0          0 IDLE                  0          0          0
RFS       LGWR              1       5346 IDLE              20308          1        512
RFS       UNKNOWN           0          0 IDLE                  0          0          0
MRP0      N/A               2       5372 WAIT_FOR_LOG          0          0          0
RFS       UNKNOWN           0          0 IDLE                  0          0          0
RFS       UNKNOWN           0          0 IDLE                  0          0          0
RFS       UNKNOWN           0          0 IDLE                  0          0          0



--configurado archive_lag_target Para 1800 , forçar a geração de archive a cada 30 minutos

--------------------------------------------------------------------------
--dataguard
--Habilitar o Flashback database no destino, limitar o periodo de retenção para 4 horas.
--------------------------------------------------------------------------
show parameter recover 
show parameter log_archive_dest_1
alter system set db_flashback_retention_target=240; (minutos)

SQL>  show parameter flash

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_flash_cache_file                  string
db_flash_cache_size                  big integer 0
db_flashback_retention_target        integer     240

SQL> select flashback_on from v$database;

FLASHBACK_ON
------------------
NO

alter database recover managed standby database cancel;

alter database flashback on;

alter database recover managed standby database disconnect ;


--exemplo (banco em mount)
FLASHBACK DATABASE TO TIMESTAMP SYSDATE-(1/24)
ALTER DATABASE OPEN RESETLOGS; 

--------------------------------------------------------------------------
--dataguard
--ACTIVE DATA GUARD NA REPLICA
--------------------------------------------------------------------------
    ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
    SHUTDOWN IMMEDIATE;
    STARTUP MOUNT;
    ALTER DATABASE OPEN READ ONLY;
    ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT;
    ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT FROM SESSION;
    (ORA-16826: apply service state is inconsistent with the DelayMins property)
    SELECT open_mode FROM V$DATABASE;


--------------------------------------------------------------------------
--dataguard
--Configurar o Data Guard Broker
--------------------------------------------------------------------------
Configurar o Data Guard Broker.
http://www.databasejournal.com/features/oracle/article.php/3822176/Configuring-Data-Guard-Broker.htm
http://www.anselmodba.com/category/data-guard/active-dataguard-11g/

--pré requisito habilitar parametro din�mico
alter system set dg_broker_start=TRUE scope=both;
validar DG_BROKER_CONFIG_FILE1 and DG_BROKER_CONFIG_FILE2 (em caso de RAC no primary and standby devem estar compartilhados)

bash-4.1$ dgmgrl
DGMGRL: Data Guard Command Line Interface

No banco primary utilizar o dgmgrl e conectar como sys
dgmgrl
connect sys   -->> sX2n7uKfb2yl

--1.) Criar DG broker para o database primário

CREATE CONFIGURATION 'KPVPRD' AS PRIMARY DATABASE IS KPVPRD  CONNECT IDENTIFIER IS KPVPRD;
show configuration nos mostra a configuração por defaul DISABLED

DGMGRL> CREATE CONFIGURATION 'KPVPRD' AS PRIMARY DATABASE IS KPVPRD  CONNECT IDENTIFIER IS KPVPRD;
Configuration "KPVPRD" created with primary database "KPVPRD"
DGMGRL> show configuration;

Configuration - KPVPRD

  Protection Mode: MaxPerformance
  Databases:
    ebs - Primary database

Fast-Start Failover: DISABLED

Configuration Status:
DISABLED

2.) Adicionar standby database
ADD DATABASE KPVPRD_STBY AS  CONNECT IDENTIFIER IS KPVPRD_STBY;
show configuration verbose;

DGMGRL> ADD DATABASE 'kpvstby' AS  CONNECT IDENTIFIER IS KPV_STBY;
Database "EBS_ODS" added
DGMGRL> show configuration verbose;

Configuration - EBS

  Protection Mode: MaxPerformance
  Databases:
    ebs     - Primary database
    EBS_ODS - Physical standby database

  Properties:
    FastStartFailoverThreshold      = '30'
    OperationTimeout                = '30'
    FastStartFailoverLagLimit       = '30'
    CommunicationTimeout            = '180'
    ObserverReconnect               = '0'
    FastStartFailoverAutoReinstate  = 'TRUE'
    FastStartFailoverPmyShutdown    = 'TRUE'
    BystandersFollowRoleChange      = 'ALL'
    ObserverOverride                = 'FALSE'
    ExternalDestination1            = ''
    ExternalDestination2            = ''
    PrimaryLostWriteAction          = 'CONTINUE'

Fast-Start Failover: DISABLED

Configuration Status:
DISABLED


3.) Habilitar  Data Guard Broker configuração:

DGMGRL> enable configuration;
Enabled.

--erro
Configuration Status:
ORA-16610: command "Broker operation" in progress
DGM-17017: unable to determine configuration status

--
http://docs.oracle.com/cd/B19306_01/server.102/b14230/configure.htm#CFHEABFJ
If the broker is managing a RAC database, the value of DG_BROKER_CONFIG_FILE1 and the value of DG_BROKER_CONFIG_FILE2 
for each of the instances must point to the same set of physical files

ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1 = '+DATAC1/KPVSTBY/dr1kpvstby.dat' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2 = '+DATAC1/KPVSTBY/dr2kpvstby.dat' SCOPE=BOTH;


ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1 = '+DATAC1/KPVPRD/dr1KPVPRD.dat' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2 = '+DATAC1/KPVPRD/dr2KPVPRD.dat' SCOPE=BOTH;

--monitoração pra troubleshoot
DGMGRL> SHOW DATABASE 'TESTPRI' 'StatusReport';
DGMGRL> SHOW DATABASE 'TESTPRI' 'LogXptStatus';
DGMGRL> SHOW DATABASE 'TESTPRI' 'InconsistentProperties';
DGMGRL> SHOW DATABASE 'TESTPRI' 'InconsistentLogXptProps';
DGMGRL> SHOW DATABASE 'TESTDG' 'StatusReport';
DGMGRL> SHOW DATABASE 'TESTDG' 'LogXptStatus';
DGMGRL> SHOW DATABASE 'TESTDG' 'InconsistentProperties';
DGMGRL> SHOW DATABASE 'TESTDG' 'InconsistentLogXptProps';



--validações
DGMGRL> show database ebs

Database - ebs

  Role:            PRIMARY
  Intended State:  TRANSPORT-ON
  Instance(s):
    EBS1
    EBS2

Database Status:
SUCCESS

DGMGRL> show database ebs_ods

Database - ebs_ods

  Role:            PHYSICAL STANDBY
  Intended State:  APPLY-ON
  Transport Lag:   0 seconds (computed 1 second ago)
  Apply Lag:       0 seconds (computed 0 seconds ago)
  Apply Rate:      868.00 KByte/s
  Real Time Query: ON
  Instance(s):
    EBS_ODS

Database Status:
SUCCESS

--------------------------------------------------------------------------
--dataguard
--delete applied
--------------------------------------------------------------------------


--How Delete Applied Standby Archived Logs Manually On 11g2

--1) prior to 11g, if not using mandatory archivelog destinations, the database (primary and standby) must be restarted with the following parameter:       
SQL> alter system set "_log_deletion_policy"='ALL' scope=both;


--When backups of archived redo log files are taken on the Primary database:
--1.     Issue the following command on the standby database:
CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON STANDBY;

--2.     Issue the following command on the primary database:
--Usually by Default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;

 

When backups of archived redo log files are taken on the standby database:
Issue the following command on the primary database:
CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON STANDBY;

Issue the following command on the standby database:
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;

How to Ensure that RMAN Does NOT Delete Archived Logs That Have Not Yet Shipped to Standby [ID 394261.1]
DOC ID 728053.1
	




--------------------------------------------------------------------------
--dataguard
--dicas banif
--------------------------------------------------------------------------

Configurar a replicação fisica com o banco EBS dos servidores ORAERPTB578A/ORAERPTB578B
A replicação deve ser configurada no modo "Maximum Performance" obrigatoriamente.

--parametros produção
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
fal_client                           string      banif (EBS)
fal_server                           string      standbydb(EBS_STD)

--
log_archive_config                   string      dg_config=(standbydr,standbydb
                                                 )
log_archive_dest                     string
log_archive_dest_1                   string      service="(DESCRIPTION=(ADDRESS
                                                 _LIST=(ADDRESS=(PROTOCOL=tcp)(
                                                 HOST=cgdoradbstby)(PORT=1521))
                                                 )(CONNECT_DATA=(SERVICE_NAME=s
                                                 tandbydb_XPT)(INSTANCE_NAME=ST
                                                 ANDBYDB)(SERVER=dedicated)))",
                                                     LGWR SYNC AFFIRM delay=0 O
                                                 PTIONAL max_failure=0 max_conn
                                                 ections=1   reopen=300 db_uniq
                                                 ue_name="standbydb" register n
                                                 et_timeout=180  valid_for=(onl
                                                 ine_logfile,primary_role)

log_archive_dest_state_1             string      ENABLE
--
STANDBYDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = cgdORADBSTBY)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = banif)
    )
  )



--parametros standby

LOG_ARCHIVE_CONFIG='DG_CONFIG=(BANIF, BANIF_STD)'
LOG_ARCHIVE_FORMAT=o1_mf_%t_%s_%r_.arc
LOG_ARCHIVE_DEST_1= 'LOCATION=+ORAFRA  VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=BANIF_STD'
LOG_ARCHIVE_DEST_2= 'SERVICE=BANIF LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=BANIF'
LOG_ARCHIVE_DEST_STATE_1=ENABLE
LOG_ARCHIVE_DEST_STATE_2=ENABLE
REMOTE_LOGIN_PASSWORDFILE=EXCLUSIVE
STANDBY_FILE_MANAGEMENT=AUTO
FAL_SERVER=BANIF
FAL_CLIENT=BANIF_STD



--andamento de backup na origem 
SELECT sid, serial#, opname, sofar, totalwork,
      round(sofar/totalwork-100,2) "% Complete", time_remaining
FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
  AND opname NOT LIKE 'RMAN: aggregate%'
  AND sofar <> totalwork
  AND totalwork != 0;


--shell script para deleção de archives
export ORACLE_SID=EBS_ODS
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / nocatalog
run
{
allocate channel t1 type disk;
CROSSCHECK ARCHIVELOG ALL;
delete noprompt archivelog until time 'sysdate-5';
}
-- ou

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin;
export ORACLE_SID=kpvstby1;
export LD_LIBRARY_PATH=/u02/app/oracle/product/19.0.0.0/dbhome_1/lib;
export ORACLE_BASE=/u02/app/oracle;
export ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1;
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export TNS_ADMIN=/u02/app/oracle/product/19.0.0.0/dbhome_1/network/admin/ORAKPV;
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target /
run
{
allocate channel t1 type disk;
CROSSCHECK ARCHIVELOG ALL;
delete noprompt archivelog until time 'sysdate-5';
}


delete noprompt archivelog until time 'sysdate-1';
DELETE NOPROMPT ARCHIVELOG ALL completed before 'SYSDATE-5'; 



