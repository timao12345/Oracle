Requirements for Installing Oracle 11gR2 RDBMS on RHEL (and OEL) 5 on AMD64/EM64T (Doc ID 880989.1)
http://docs.oracle.com/cd/E11882_01/server.112/e41134/toc.htm

Bin�rios:
/nfs/software/oracle/RDBMS/Linux/Oracle11gR2/11.2.0.2/database

Diret�rio de instala��o
[oracle@blvd71:~] $ mkdir -p /usr/lic/oracle/home/product/11.2.0
[oracle@blvd71:~] $ mkdir -p /usr/lic/oracle/home/product/oraInventory

[oracle@blvd71:~] $ getconf PAGE_SIZE
4096
[oracle@blvd63:~/product/11.2.0/OPatch] $ cat /proc/sys/kernel/shmall
16777216

vi /etc/sysctl.conf
### parametros adicionados para instalacao Oracle 11gr2 # Oracle Support 880989.1 ###
kernel.shmall = 17301504 
kernel.shmmax = 8589934592
kernel.shmmni = 4096 
kernel.sem = 250 32000 100 128 
fs.file-max = 6815744
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500 
net.core.rmem_default = 262144 
net.core.rmem_max = 4194304 
net.core.wmem_default = 262144 
net.core.wmem_max = 1048576

################ 63 #####################
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.ip_local_port_range = 9000 65500
kernel.sem = 256 32000 100 142
kernel.shmall = 16777216
kernel.shmmax = 8589934592
kernel.shmmni = 4096
kernel.msgmax = 8192
kernel.msgmnb = 65535
kernel.msgmni = 2878
fs.file-max = 6815744
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 262144



#sysctl -p

vi /etc/security/limits.conf
### parametros adicionados para instalacao Oracle 11gr2 # Oracle Support 880989.1 ###
oracle soft nproc 2047 
oracle hard nproc 16384 
oracle soft nofile 1024 
oracle hard nofile 65536 
oracle soft stack 10240

vi /etc/pam.d/login
### parametros adicionados para instalacao Oracle 11gr2 # Oracle Support 880989.1 ###
session required pam_limits.so


vi /etc/profile
### parametros adicionados para instalacao Oracle 11gr2 # Oracle Support 880989.1 ###
if [ $USER = "oracle" ]; then 
   if [ $SHELL = "/bin/ksh" ]; then 
       ulimit -u 16384 
       ulimit -n 65536 
   else 
       ulimit -u 16384 -n 65536 
   fi 
fi 

#Verifica��o do Hostname
[root@blvd71 home]# hostname
blvd71.br.scania.com

Foi adicionado a seguinte configura��o do arquivo /etc/hosts
vi /etc/hosts
138.106.239.54          blvd71.br.scania.com blvd71

rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep binutils 

### Verifica��o de acotes ###
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep binutils-2
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep compat-libstdc++
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-common
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep ksh-2
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libaio-0
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libgcc-4
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libstdc++
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep make
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf-devel
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf-devel-static
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-headers
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep kernel-headers
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-devel-2
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep gcc-4
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libgomp-4
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libstdc++-devel-4
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep gcc-c++-4
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libaio-devel-0
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep sysstat-7
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep unixODBC-2
rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep unixODBC-devel-2

### Resultado da Verifica��o de Pacotes ###
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep binutils-2
binutils-2.17.50.0.6-14.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep compat-libstdc++
compat-libstdc++-33-3.2.3-61 (i386)
compat-libstdc++-33-3.2.3-61 (x86_64)
compat-libstdc++-296-2.96-138 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf
elfutils-libelf-devel-static-0.137-3.el5 (i386)
elfutils-libelf-0.137-3.el5 (x86_64)
elfutils-libelf-devel-0.137-3.el5 (x86_64)
elfutils-libelf-devel-static-0.137-3.el5 (x86_64)
elfutils-libelf-0.137-3.el5 (i386)
elfutils-libelf-devel-0.137-3.el5 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc
glibc-2.5-49.el5_5.4 (x86_64)
glibc-headers-2.5-49.el5_5.4 (x86_64)
compat-glibc-2.3.4-2.26 (i386)
glibc-common-2.5-49.el5_5.4 (x86_64)
compat-glibc-headers-2.3.4-2.26 (x86_64)
compat-glibc-2.3.4-2.26 (x86_64)
glibc-2.5-49.el5_5.4 (i686)
glibc-devel-2.5-49.el5_5.4 (i386)
glibc-devel-2.5-49.el5_5.4 (x86_64)
glibc-utils-2.5-49.el5_5.4 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-common
glibc-common-2.5-49.el5_5.4 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep ksh-2
ksh-20100202-1.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libaio-0
libaio-0.3.106-5 (x86_64)
libaio-0.3.106-5 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libgcc-4
libgcc-4.1.2-48.el5 (i386)
libgcc-4.1.2-48.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libstdc++
compat-libstdc++-33-3.2.3-61 (i386)
libstdc++-4.1.2-48.el5 (i386)
libstdc++-devel-4.1.2-48.el5 (i386)
libstdc++-devel-4.1.2-48.el5 (x86_64)
compat-libstdc++-33-3.2.3-61 (x86_64)
compat-libstdc++-296-2.96-138 (i386)
libstdc++-4.1.2-48.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep make
make-3.81-3.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf-devel
elfutils-libelf-devel-static-0.137-3.el5 (i386)
elfutils-libelf-devel-0.137-3.el5 (x86_64)
elfutils-libelf-devel-static-0.137-3.el5 (x86_64)
elfutils-libelf-devel-0.137-3.el5 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep elfutils-libelf-devel-static
elfutils-libelf-devel-static-0.137-3.el5 (i386)
elfutils-libelf-devel-static-0.137-3.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-headers
glibc-headers-2.5-49.el5_5.4 (x86_64)
compat-glibc-headers-2.3.4-2.26 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep kernel-headers
kernel-headers-2.6.18-194.11.1.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep glibc-devel-2
glibc-devel-2.5-49.el5_5.4 (i386)
glibc-devel-2.5-49.el5_5.4 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep gcc-4
libgcc-4.1.2-48.el5 (i386)
libgcc-4.1.2-48.el5 (x86_64)
gcc-4.1.2-48.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libgomp-4
libgomp-4.4.0-6.el5 (i386)
libgomp-4.4.0-6.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libstdc++-devel-4
libstdc++-devel-4.1.2-48.el5 (i386)
libstdc++-devel-4.1.2-48.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep gcc-c++-4
gcc-c++-4.1.2-48.el5 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep libaio-devel-0
libaio-devel-0.3.106-5 (x86_64)
libaio-devel-0.3.106-5 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep sysstat-7
sysstat-7.0.2-3.el5_5.1 (x86_64)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep unixODBC-2
unixODBC-2.2.11-7.1 (x86_64)
unixODBC-2.2.11-7.1 (i386)
[root@blvd71 home]# rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n" | grep unixODBC-devel-2
unixODBC-devel-2.2.11-7.1 (x86_64)
unixODBC-devel-2.2.11-7.1 (i386)

### Swap ###
O SWAP n�o est� de acordo com o recomendado.
O SWAP atual � de 4G o recomendado para 16G de RAM � 16G de SWAP.

[root@blvd71 11.2.0]# /usr/lic/oracle/home/product/oraInventory/orainstRoot.sh
Changing permissions of /usr/lic/oracle/home/product/oraInventory.
Adding read,write permissions for group.
Removing read,write,execute permissions for world.

Changing groupname of /usr/lic/oracle/home/product/oraInventory to oinstall.
The execution of the script is complete.
[root@blvd71 11.2.0]# /usr/lic/oracle/home/product/11.2.0/root.sh
Running Oracle 11g root script...

The following environment variables are set as:
    ORACLE_OWNER= oracle
    ORACLE_HOME=  /usr/lic/oracle/home/product/11.2.0

Enter the full pathname of the local bin directory: [/usr/local/bin]:
   Copying dbhome to /usr/local/bin ...
   Copying oraenv to /usr/local/bin ...
   Copying coraenv to /usr/local/bin ...


Creating /etc/oratab file...
Entries will be added to the /etc/oratab file as needed by
Database Configuration Assistant when a database is created
Finished running generic part of root script.
Now product-specific root actions will be performed.
Finished product-specific root actions.


#### Patches ####
Baixar e aplicar os patches:
13004894 - Baixado - Aplicado
13001379 - Baixado - Aplicado
12942119 - Baixado - Aplicado
12400751 - Baixado - Aplicado
10229719 - Baixado - Aplicado
10160615 - Baixado - Aplicado
10149223 - Baixado - Aplicado
4247037 - Baixado - Aplicado

### Todos os Patches foram instalados com sucesso ###

[oracle@blvd71:/nfs/software/oracle/RDBMS/Linux/Oracle11gR2/11.2.0.2/patches/4247037] $ opatch lsinventory
Invoking OPatch 11.2.0.1.1

Oracle Interim Patch Installer version 11.2.0.1.1
Copyright (c) 2009, Oracle Corporation.  All rights reserved.


Oracle Home       : /usr/lic/oracle/home/product/11.2.0
Central Inventory : /usr/lic/oracle/home/product/oraInventory
   from           : /etc/oraInst.loc
OPatch version    : 11.2.0.1.1
OUI version       : 11.2.0.2.0
OUI location      : /usr/lic/oracle/home/product/11.2.0/oui
Log file location : /usr/lic/oracle/home/product/11.2.0/cfgtoollogs/opatch/opatch2013-08-26_15-23-56PM.log

Patch history file: /usr/lic/oracle/home/product/11.2.0/cfgtoollogs/opatch/opatch_history.txt

Lsinventory Output file location : /usr/lic/oracle/home/product/11.2.0/cfgtoollogs/opatch/lsinv/lsinventory2013-08-26_15-23-56PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1):

Oracle Database 11g                                                  11.2.0.2.0
There are 1 products installed in this Oracle Home.


Interim patches (8) :

Patch  4247037      : applied on Mon Aug 26 15:23:40 BRT 2013
Unique Patch ID:  13016142
   Created on 17 SEP 2009, 09:52:00 hrs US/Pacific
   Bugs fixed:
     4247037

Patch  10149223     : applied on Mon Aug 26 15:21:41 BRT 2013
Unique Patch ID:  13073567
   Created on 25 Oct 2010, 03:35:14 hrs PST8PDT
   Bugs fixed:
     10149223

Patch  10160615     : applied on Mon Aug 26 15:20:03 BRT 2013
Unique Patch ID:  13348800
   Created on 17 Jan 2011, 05:06:03 hrs PST8PDT
   Bugs fixed:
     10160615

Patch  10229719     : applied on Mon Aug 26 15:17:46 BRT 2013
Unique Patch ID:  13186657
   Created on 28 Nov 2010, 23:27:11 hrs PST8PDT
   Bugs fixed:
     10229719

Patch  12400751     : applied on Mon Aug 26 15:14:16 BRT 2013
Unique Patch ID:  13880767
   Created on 28 Jun 2011, 00:48:59 hrs PST8PDT
   Bugs fixed:
     12400751

Patch  12942119     : applied on Mon Aug 26 15:11:35 BRT 2013
Unique Patch ID:  14249063
   Created on 9 Nov 2011, 01:01:31 hrs PST8PDT
   Bugs fixed:
     12942119

Patch  13001379     : applied on Mon Aug 26 15:09:42 BRT 2013
Unique Patch ID:  14718548
   Created on 31 Mar 2012, 04:48:44 hrs PST8PDT
   Bugs fixed:
     13001379

Patch  13004894     : applied on Mon Aug 26 15:06:14 BRT 2013
Unique Patch ID:  14143364
   Created on 28 Sep 2011, 10:06:58 hrs PST8PDT
   Bugs fixed:
     13004894



--------------------------------------------------------------------------------

OPatch succeeded.

#### CONFIGURA��O DATAGUARD 11GR2 ####
###### For Primary DB ############

### For�ar Log ###
ALTER DATABASE FORCE LOGGING;


    GROUP# STATUS  TYPE    MEMBER                                                       IS_
---------- ------- ------- ------------------------------------------------------------ ---
         1         ONLINE  /ora_log01/FILA/redo01a.log                                  NO
         1         ONLINE  /ora_log02/FILA/redo01b.log                                  NO
         2         ONLINE  /ora_log01/FILA/redo02a.log                                  NO
         2         ONLINE  /ora_log02/FILA/redo02b.log                                  NO
         3         ONLINE  /ora_log01/FILA/redo03a.log                                  NO
         3         ONLINE  /ora_log02/FILA/redo03b.log                                  NO
		 
		 
    GROUP#    THREAD#  SEQUENCE#      BYTES  BLOCKSIZE    MEMBERS ARC STATUS           FIRST_CHANGE# FIRST_TIM NEXT_CHANGE# NEXT_TIME
---------- ---------- ---------- ---------- ---------- ---------- --- ---------------- ------------- --------- ------------ ---------
         1          1      22033  524288000        512          2 YES INACTIVE            2.2010E+11 28-AUG-13   2.2010E+11 28-AUG-13
         2          1      22034  524288000        512          2 NO  CURRENT             2.2010E+11 28-AUG-13   2.8147E+14
         3          1      22032  524288000        512          2 YES INACTIVE            2.2010E+11 28-AUG-13   2.2010E+11 28-AUG-13
		 
### Adicionar Redologs Standby ###
alter database add standby logfile group 4  '/ora_log01/FILA/standby_redo04a.log','/ora_log02/FILA/standby_redo04b.log' size 524288000;
alter database add standby logfile group 5  '/ora_log01/FILA/standby_redo05a.log','/ora_log02/FILA/standby_redo05b.log' size 524288000;
alter database add standby logfile group 6  '/ora_log01/FILA/standby_redo06a.log','/ora_log02/FILA/standby_redo06b.log' size 524288000;

### COMANDOS SQL PARA ALTERAÇAO DE ARQUIVO SPFILE ####
alter system set LOG_ARCHIVE_CONFIG='dg_config=(KPVPRD_STBY,kpvprd)' scope=both;
alter system set LOG_ARCHIVE_DEST_1='LOCATION=/ora_arch01/FILA VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=FILA' scope=both;
alter system set LOG_ARCHIVE_DEST_2='SERVICE=FILADG LGWR SYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE)  DB_UNIQUE_NAME=FILADG' scope=both;
alter system set log_archive_dest_state_1=enable scope=both;
alter system set log_archive_dest_state_2=enable scope=both;
alter system set log_archive_max_processes=8 scope=both;
alter system set fal_server=FILADG scope=both;
alter system set db_file_name_convert='FILADG','FILA' scope=spfile;
alter system set log_file_name_convert='FILADG','FILA' scope=spfile;
alter system set standby_file_management=AUTO scope=both;

###### For Standby DB ############
### COMANDOS SQL PARA ALTERAÇAO DE ARQUIVO SPFILE ####
alter system set db_unique_name='FILADG' scope=spfile;
alter system set control_files='/usr/lic/oracle/home/oradata/FILADG/control01.ctl','/ora_log01/FILADG/control02.ctl','/ora_log02/FILADG/control03.ctl' scope=spfile;
alter system set FAL_SERVER ='FILA' scope=both;
alter system set FAL_CLIENT='FILADG' db_file_name_convert='FILA','FILADG' scope=spfile;
alter system set DB_FILE_NAME_CONVERT ='FILA','FILADG' scope=spfile;
alter system set LOG_FILE_NAME_CONVERT ='FILA','FILADG' scope=spfile;
alter system set LOG_ARCHIVE_DEST_1='LOCATION=/ora_arch01/FILA VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=FILADG' scope=both;
alter system set LOG_ARCHIVE_DEST_2='SERVICE=FILA ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=FILA' scope=both;
alter system set STANDBY_FILE_MANAGEMENT=AUTO scope=both;


### CONFIGURA��O DO LISTENER ###

###### For Primary Data Base ############

Foram criados os arquivos listener.new e tnsnames.new com as altera��es abaixo.
Esses arquivos v�o substituir os arquivos listener.ora e tnsnames.ora
Foi gerado um backup dos arquivos listener.ora e tnsnames.ora
listener.ora_bkp_28082013_antes_dataguard
tnsnames.ora_bkp_28082013_antes_dataguard

mv
### Configura��o do DataGuard, caso precisar rodar o autoconfig do EBS salvar configura��es abaixo ###

### inicio ajustes DataGuard ###
FILA =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = blvd63.br.scania.com)(PORT = 1521))
    )
  )

SID_LIST_FILA =
  (SID_LIST =
    (SID_DESC =
      (SID_NAME = FILA)
	  (GLOBAL_DBNAME=FILA)
	  (ORACLE_HOME=/usr/lic/oracle/home/product/11.2.0)
	  (ENVS=TNS_ADMIN="/usr/lic/oracle/home/product/11.2.0/network/admin/FILA_blvd63")
    )
  )

SID_LIST_FILA =
 (SID_LIST =
	(SID_DESC =
	(SID_NAME = FILA)
	(GLOBAL_DBNAME=FILA_DGMGRL)
	(ORACLE_HOME = /usr/lic/oracle/home/product/11.2.0)
	(ENVS=TNS_ADMIN="/usr/lic/oracle/home/product/11.2.0/network/admin/FILA_blvd63")
	)
)


(SID_DESC =
(GLOBAL_DBNAME =KPVPRD_STBY)
(ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_1)
(SID_NAME = kpvprd1)
(ENVS=TNS_ADMIN="/u02/app/oracle/product/19.0.0.0/dbhome_1/network/admin/KPVPRD_STBY")
)


	 
### Fim ajustes DataGuard ###



### Configura��o TNSNAMES ###
###### For Primary DB ############
### Configuracao do DataGuard, caso precisar rodar o autoconfig do EBS salvar configura��es abaixo ###
FILA=
(DESCRIPTION=
 (ADDRESS=(PROTOCOL=tcp)(HOST=blvd63.br.scania.com)(PORT=1521))
  (CONNECT_DATA=
  (SERVER = DEDICATED)
  (SERVICE_NAME=FILA) (UR=A)
  (INSTANCE_NAME=FILA)
 )
)

FILA_DGMGRL =
(DESCRIPTION =
 (ADDRESS = (PROTOCOL = TCP)(HOST = lblvd63.br.scania.com)(PORT = 1521))
  (CONNECT_DATA =
  (SERVER = DEDICATED)
  (SERVICE_NAME = FILA_DGMGRL)
 )
)

FILADG=
(DESCRIPTION=
 (ADDRESS=(PROTOCOL=tcp)(HOST=blvd71.br.scania.com)(PORT=1521))
  (CONNECT_DATA=
  (SERVER = DEDICATED)
  (SERVICE_NAME=FILA) (UR=A)
  (INSTANCE_NAME=FILA)
 )
)

FILADG_DGMGRL =
(DESCRIPTION =
 (ADDRESS = (PROTOCOL = TCP)(HOST = blvd71.br.scania.com)(PORT = 1521))
  (CONNECT_DATA =
  (SERVER = DEDICATED)
  (SERVICE_NAME = FILA_DGMGRL)
 )
)
### Fim ajustes DataGuard ###


### CONFIGURA��O DO LISTENER ###
###### For Standby DB ############
### ajustes realizados para configura��o do DataGuard, caso precisar rodar o autoconfig do EBS salvar configura��es abaixo ###

### inicio ajustes DataGuard ###
FILA =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = blvd71.br.scania.com)(PORT = 1521))
    )
  )

SID_LIST_FILA =
  (SID_LIST =
    (SID_DESC =
      (ORACLE_HOME= /usr/lic/oracle/home/product/11.2.0)
      (SID_NAME = FILA)
	  (GLOBAL_DBNAME=FILA)
	  (ORACLE_HOME=/usr/lic/oracle/home/product/11.2.0)
	  (ENVS=TNS_ADMIN="/usr/lic/oracle/home/product/11.2.0/network/admin/FILA_blvd71")
    )
  )


SID_LIST_FILA =
 (SID_LIST =
	(SID_DESC =
	(SID_NAME = FILA)
	(GLOBAL_DBNAME=FILA_DGMGRL)
	(ORACLE_HOME = /usr/lic/oracle/home/product/11.2.0)
	(ENVS=TNS_ADMIN="/usr/lic/oracle/home/product/11.2.0/network/admin/FILA_blvd71")
	)
)

### Fim ajustes DataGuard ###



### Configura��o TNSNAMES ###
###### For Standby DB ############
### Configura��o do DataGuard, caso precisar rodar o autoconfig do EBS salvar configura��es abaixo ###
FILA=
(DESCRIPTION=
 (ADDRESS=(PROTOCOL=tcp)(HOST=blvd63.br.scania.com)(PORT=1521))
  (CONNECT_DATA=
  (SERVER = DEDICATED)
  (SERVICE_NAME=FILA) (UR=A)
  (INSTANCE_NAME=FILA)
 )
)

FILA_DGMGRL =
(DESCRIPTION =
 (ADDRESS = (PROTOCOL = TCP)(HOST = lblvd63.br.scania.com)(PORT = 1521))
  (CONNECT_DATA =
  (SERVER = DEDICATED)
  (SERVICE_NAME = FILA_DGMGRL)
 )
)

FILADG=
(DESCRIPTION=
 (ADDRESS=(PROTOCOL=tcp)(HOST=blvd71.br.scania.com)(PORT=1521))
  (CONNECT_DATA=
  (SERVER = DEDICATED)
  (SERVICE_NAME=FILA) (UR=A)
  (INSTANCE_NAME=FILA)
 )
)

FILADG_DGMGRL =
(DESCRIPTION =
 (ADDRESS = (PROTOCOL = TCP)(HOST = blvd71.br.scania.com)(PORT = 1521))
  (CONNECT_DATA =
  (SERVER = DEDICATED)
  (SERVICE_NAME = FILA_DGMGRL)
 )
)
### Fim ajustes DataGuard ###

#### copiar spfile e arquivos de senhas ###
scp spfileFILA.ora blvd71.br.scania.com:/usr/lic/oracle/home/product/11.2.0
scp orapwFILA blvd71.br.scania.com:/usr/lic/oracle/home/product/11.2.0

### criar diret�rios ###
mkdir -p /usr/lic/oracle/home/product/admin/FILA
mkdir -p /usr/lic/oracle/home/oradata/FILADG

### Foi criar um usu�rio no banco de dados produ��o para testes de conex�o. ###
SQL> create user acs identified by acs#123;
User created.
SQL> grant dba to acs;
Grant succeeded.

### CLONE DO BANCO DE DADOS PRIMARIO PARA O STANDBY ###

[oracle@blvd71:~] sqlplus / as sysdba
startup nomount

[oracle@blvd71:~] $ 
rman target sys/welcome1@FILA auxiliary sys/welcome1@FILADG 
run {
	allocate channel prmy1 type disk;
	allocate channel prmy2 type disk;
	allocate channel prmy3 type disk;
	allocate channel prmy4 type disk;
	allocate channel prmy5 type disk;
	allocate auxiliary channel stby1 type disk;
	duplicate target database for standby from active database
	spfile
		parameter_value_convert 'FILA','FILADG'
		set db_unique_name='FILADG'
		set fal_server='FILA'
		set fal_client='FILADG'
		set local_listener=''
		set remote_listener=''
		set standby_file_management='AUTO'
		set control_files='/usr/lic/oracle/home/oradata/FILADG/control01.ctl','/ora_log01/FILADG/control02.ctl','/ora_log02/FILADG/control03.ctl'
		set log_archive_dest_1='LOCATION=/ora_arch01/FILA VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=FILADG MANDATORY'
		set log_archive_dest_2='SERVICE=FILADG LGWR SYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE)  DB_UNIQUE_NAME=FILA'
		set db_file_name_convert='FILA','FILADG'
		set log_file_name_convert='FILA','FILADG'
		nofilenamecheck
	;}


### iniciar replicação dos logs ###
sqlplus / as sysdba
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;


###Configuração do Broker###


### Alteração do init.ora no servidor PRIMARIO

#FILA
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs1KPV_STBY.ora' SCOPE=BOTH sid='*';
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs2KPV_STBY.ora' SCOPE=BOTH sid='*';
alter system set dg_broker_start=true scope=both;


### Alteração do init.ora no servidores STANDBYS

#FILADG
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs1KPV_STBY.ora' SCOPE=BOTH sid='*';
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs2KPV_STBY.ora' SCOPE=BOTH sid='*';
alter system set dg_broker_start=true scope=both;


### Setup do Broker (realizado no servidor primário) ###

DGMGRL>
CREATE CONFIGURATION FILA_SCANIA_DR
AS
PRIMARY DATABASE IS FILA
CONNECT IDENTIFIER IS FILA
;

ADD DATABASE FILADG AS CONNECT IDENTIFIER IS 'FILADG';
DGMGRL> enable configuration;
Enabled.
DGMGRL> show configuration

remove configuration

