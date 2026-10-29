-----------------------------------------------------------------------------
--                 Oracle Database 12c Standalone com ASM                  --
-----------------------------------------------------------------------------

-- Criar disco para os binários utilizando LVM 

-- Listar as partições disponíveis
fdisk -l

-- Formatar a partição a ser utilizada para tipo LVM
fdisk /dev/sdb

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-52428799, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-52428799, default 52428799): 
Using default value 52428799
Partition 1 of type Linux and of size 25 GiB is set

-- Alterar o partition's system id para utilizar LVM
fdisk /dev/sdb 
p - print the partition table

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048    52428799    26213376   83  Linux 

Command (m for help): t
Selected partition 1
Hex code (type L to list all codes): L

-- Alterar para o tipo LVM: 8e
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM'
Command (m for help): w -- Salvar

-- Criar um PhysicalVolume para depois ser utilizado pelo LogicalVolumeManager
[root@oracle-12c ~]# pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.

pvcreate  /dev/sdl1
pvcreate  /dev/sdm1
pvcreate  /dev/sdn1
pvcreate  /dev/sdu1


/* Obs: Caso não tenha o pacote instalado, instale da seguinte forma: */
yum provides */pvcreate -- Identificar qual pacote disponibiliza o comando pvcreate
yum install lvm2

-- Criar o vg para montar o filesystem u01
[root@oracle-12c ~]# vgcreate vg_oracle /dev/sdb1
  Volume group "vg_oracle" successfully created
[root@oracle-12c ~]# vgs
  VG        #PV #LV #SN Attr   VSize   VFree  
  vg_oracle   1   0   0 wz--n- <25.00g <25.00g

vgcreate vg_oracle /dev/sdb1
vgcreate vg_oracle2 /dev/sdc1
vgcreate vg_oracle3 /dev/sdd1
vgcreate vg_oracle4 /dev/sde1

-- Criar o lv para o u01
[root@oracle-12c ~]# 

lvcreate -n u01 -L 50000M vg_oracle
lvcreate -n u02 -L 50000M vg_oracle2
lvcreate -n u03 -L 50000M vg_oracle3
lvcreate -n u04 -L 50000M vg_oracle4

lvcreate -n sap_bkp -L 1000000M vg_orabkp

lvextend -L +2G /dev/mapper/vg_cloud-LogVol00

lvextend -L +1G /dev/vg_oracle/u01
lvextend -L +1G /dev/vg_oracle2/u02
lvextend -L +1G /dev/vg_oracle3/u03
lvextend -L +1G /dev/vg_oracle4/u04


lvextend -L +170m /dev/vg_oracle2/u02
lvextend -L +170m /dev/vg_oracle3/u03
lvextend -L +170m /dev/vg_oracle4/u04

  Logical volume "u01" created.
[root@oracle-12c ~]# lvs
  LV   VG        Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  u01  vg_oracle -wi-a----- 15.00g        

-- Criar filesystem /u01
[root@oracle-12c ~]# mkfs.ext4 /dev/vg_orabkp/sap_bkp


mkfs.ext4 /dev/vg_oracle/u01
mkfs.ext4 /dev/vg_oracle2/u02
mkfs.ext4 /dev/vg_oracle3/u03
mkfs.ext4 /dev/vg_oracle4/u04


-- Criar diretório e montar filesystem
mkdir /u01

mount /dev/vg_oracle/u01 /u01
mount /dev/vg_oracle2/u02 /u02
mount /dev/vg_oracle3/u03 /u03
mount /dev/vg_oracle4/u04 /u04

-- Editar arquivo fstab para montar o filesystem na inicialização da máquina
vi /etc/fstab 
/dev/vg_oracle/u01    /u01                               ext4    defaults        0 0
/dev/vg_oracle2/u02    /u02                              ext4    defaults        0 0
/dev/vg_oracle3/u03    /u02                              ext4    defaults        0 0
/dev/vg_oracle4/u04    /u04                              ext4    defaults        0 0


/*--------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/

-- Criar arquivo/disco de swap

-- Utilizando um arquivo dentro de um filesystem existente
mkdir /swap
dd if=/dev/zero of=/swap/root_swap bs=1024 count=2097152
chown root:root /swap/root_swap
chmod 0600 /swap/root_swap
mkswap /swap/root_swap
swapon /swap/root_swap 

-- Utilizando LVM
lvcreate NOME_DO_VG -n NOME_DO_LV -L TAMANHO_A_SER_ACRESCENTADO
mkswap CAMINHO_COMPLETO_DO_NOME_DO_LV
swapon -v CAMINHO_COMPLETO_DO_NOME_DO_LV 

mkswap /dev/rhel/swap

/dev/mapper/rhel-swap

-- Utilizando um disco separado para o SWAP
fdisk /dev/sdc1
	n
	p
	default
	default
	default
	m to verify how set `change a partitions system id`
	t = change a partitions system id
	l to check where set swap
	82 = Linux Swap / SO
	w
-- Aplicar sem restartar o servidor 
partprobe /dev/sdc  --Changes take effect without restat the system
   
-- Criando o arquivo de swap:
[root@oradbd ~]# mkswap /dev/sdh1 -L swap
	Setting up swapspace version 1, size = 10484732 KiB
	LABEL=swap, UUID=9cfe064b-c05b-403f-bf58-f1229090b4da

-- Verificando as LABELS
   blkid
/dev/sdh1: LABEL="swap" UUID="9cfe064b-c05b-403f-bf58-f1229090b4da" TYPE="swap"

-- Habilitando o swap e publicando para o kernel
swapon /dev/sdh1

-- Gravar no fstab
LABEL=newswap   swap    swap    defaults        0       0

-- Verificar o status do wap
swapon -s


/*--------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/P
/*--------------------------------------------------------------------------------------------------*/


-- Instalando o Oracle ASMlib
[root@oradb-12c ~]# yum install kmod-oracleasm
[root@oradb-12c ~]# wget http://download.oracle.com/otn_software/asmlib/oracleasmlib-2.0.12-1.el7.x86_64.rpm
[root@oradb-12c ~]# yum -y localinstall oracleasmlib-2.0.12-1.el7.x86_64.rpm
[root@oradb-12c ~]# yum install oracleasm-support

kmod-redhat-oracleasm
-- Instalando o pacote de pré-instalação do Oracle
yum install -y oracle-rdbms-server-12cR1-preinstall

dnf install -y oracle-database-preinstall-19c

-- também tem o repositorio oficial aonde pode ser consultado caso seja um servidor que não tenha acesso a internet e precise do preinstall manual.
https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm


-- Configurando os parâmetros de kernel no arquivo /etc/sysctl.conf
fs.file-max = 6815744
kernel.sem = 250 32000 100 128  
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500

-- Executar o seguinte comando para que as alterações sejam salvas
/sbin/sysctl -p

-- Adicionar as seguintes linhas no arquivo /etc/security/limits.conf
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    2047
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728

grid   soft   nofile    1024
grid   hard   nofile    65536
grid   soft   nproc    2047
grid   hard   nproc    16384
grid   soft   stack    10240
grid   hard   stack    32768
grid   hard   memlock    134217728
grid   soft   memlock    134217728


-- Instalar os pacotes recomendados para a instalação do Oracle 19c
-- Ficar atendo pois cada SO é diferente, olhar no Guide de instalação na documentação sempre.
yum install binutils 
yum install bc -y
yum install binutils -y
yum install compat-openssl11 -y
yum install elfutils-libelf -y
yum install fontconfig -y
yum install glibc -y
yum install glibc-devel -y
yum install ksh -y
yum install libaio -y
yum install libasan -y
yum install liblsan 
yum install libX11-y 
yum install libXau-y 
yum install libXi-y 
yum install libXrender-y 
yum install libXtst -y
yum install libxcrypt-compat -y
yum install libgcc -y
yum install libibverbs -y
yum install libnsl -y
yum install librdmacm -y
yum install libstdc++ -y
yum install libxcb -y
yum install libvirt-libs -y
yum install make -y
yum install policycoreutils -y 
yum install policycoreutils-python-utils -y 
yum install smartmontools -y 
yum install sysstat -y 
yum install nfs-utils -y 
yum install chkconfig -y         

-- Criar os usuários/grupos (caso o pacote de pré-instalação não tenha criado) e permissionamento nos diretórios de instalação


backupdba:x:54324:oracle
dgdba:x:54325:oracle
kmdba:x:54326:oracle
racdba:x:54330:oracle


groupadd -g 1005 oinstall
groupadd -g 1010 dba
groupadd -g 1020  
groupadd -g 1030 asmdba
groupadd -g 1040 asmoper
groupadd -g 1050 oper

groupadd -g 54327 asmadmin
groupadd -g 54328 asmdba
groupadd -g 54329 asmoper

-- SAP HML
oinstall:x:54321:grid,oracle
dba:x:54322:oracle
oper:x:54323:
backupdba:x:54324:oracle
dgdba:x:54325:oracle
kmdba:x:54326:oracle
racdba:x:54330:oracle
asmadmin:x:54327:grid
asmdba:x:54328:grid,oracle
asmoper:x:54329:grid


-- SAP DEV
oinstall:x:54321:oracle,grid
dba:x:54322:oracle
oper:x:54323:oracle
backupdba:x:54324:oracle
dgdba:x:54325:oracle
kmdba:x:54326:oracle
racdba:x:54330:oracle
asmadmin:x:54327:grid
asmdba:x:54328:grid,oracle
asmoper:x:54329:grid

gpasswd --delete grid dgdba
gpasswd --delete grid kmdba
gpasswd --delete grid racdba
gpasswd --delete grid dba
gpasswd --delete grid backupdba


-- groups do Exadata Kiprev
oinstall:x:1001:oracle,grid,cdcadmin
asmdba:x:1004:oracle,grid,cdcadmin
asmoper:x:1005:grid,cdcadmin
asmadmin:x:1006:grid,cdcadmin
dba:x:1002:oracle,cdcadmin
racoper:x:1003:oracle

useradd -u 54321 -g oinstall -G dba,oper,asmdba,backupdba,dgdba,kmdba,racdba oracle
useradd -u 54421 -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,asmadmin,asmoper,asmdba grid

---- oracle ----
useradd -u 1001 -g oinstall -G dba,asmdba,dba oracle
useradd -u 1001 -g oinstall -G dba,asmdba,dba oracle

usermod -a -G oinstall,oper,dba,asmdba,backupdba,dgdba,kmdba,racdba,asmdba oracle

--ou
useradd -u 54321 -g oinstall -G dba,asmdba,racdba oracle


usermod -a -G dba,oper,asmdba,backupdba,dgdba,kmdba,racdba oracle

chmod -R 775 /u02
passwd oracle Ora$cra#

---- grid ----
useradd -u 54421 -g oinstall -G racdba,asmadmin,asmdba,asmoper grid --- mais usado

oinstall:x:54321:grid,oracle
racdba:x:54330:oracle,grid
asmadmin:x:54327:grid
asmdba:x:54328:grid,oracle
asmoper:x:54329:grid

oinstall:x:54321:oracle,grid
dba:x:54322:oracle,grid
backupdba:x:54324:oracle,grid
dgdba:x:54325:oracle,grid
kmdba:x:54326:oracle,grid
racdba:x:54330:oracle,grid
asmadmin:x:54327:grid
asmdba:x:54328:grid,oracle
asmoper:x:54329:grid


-- ou 

usermod -a -G oinstall,asmdba,backupdba,kmdba,racdba,asmadmin,asmoper,asmdba grid
usermod -a -G asmadmin,asmoper,oinstall,asmdba grid

chown -R grid:oinstall /u01
passwd grid Cvp#ora$

-- Criar a estrutura de diretórios do grid com user gird
mkdir -p /u01/app/19.0.0.0/grid  ####{grid-home}
mkdir -p /u01/app/grid  ######{grid-base}
mkdir -p /u01/app/oraInventory
mkdir -p /u01/path/
chown -R grid:oinstall /u01/app/19.0.0.0/grid

-- Criar a estrutura de diretórios do oracle com user oracle
mkdir -p /u02/app/oracle/product/19.0.0.0/dbhome_1  ######(oracle home)
mkdir -p /u02/path/
chown -R oracle:oinstall /u02/app/oracle/product/19.0.0.0/dbhome_1

mkdir -p /u03/app/oracle/product/19.0.0.0/dbhome_2  ######(oracle home)
mkdir -p /u03/path/
chown -R oracle:oinstall /u03/app/oracle/product/19.0.0.0/dbhome_2

mkdir -p /u04/app/oracle/product/19.0.0.0/dbhome_3  ######(oracle home)
mkdir -p /u04/path/
chown -R oracle:oinstall /u04/app/oracle/product/19.0.0.0/dbhome_3



-- Configurar o .bash_profile dos usuários grid
-- Grid user
export GRID_HOME=/u01/app/19.0.0.0/grid
export GRID_BASE=/u01/app/grid
export ORACLE_HOME=$GRID_HOME
export ORACLE_BASE=$GRID_BASE
export ORACLE_SID=+ASM1
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export TNS_ADMIN=$ORACLE_HOME/network/admin

-- Oracle user
export ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1
export ORACLE_SID=EDC
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_BASE=/u02/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

/*
vim ~/.bash_profile

# Bash Profile para o usuario: Oracle
#
#

# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# Global variables environment
TMP=/tmp
TMPDIR=$TMP
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db
TNS_ADMIN=$ORACLE_HOME/network/admin
ORACLE_TERM=xterm
EDITOR=vi

# User libraries and binaries path and classpath
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
PATH=$PATH:$HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch

export TMP TMPDIR ORACLE_BASE ORACLE_HOME TNS_ADMIN ORACLE_TERM EDITOR LD_LIBRARY_PATH CLASSPATH PATH
*/


-- Desabilitar o firewall
systemctl stop firewalld
systemctl disable firewalld

-- Desabilitar o SELINUX
-- Editar o arquivo /etc/selinux/config e alterar o seguinte parâmetro
SELINUX=permissive
setenforce Permissive


--##Configurando ASMLIB
systemctl enable oracleasm

systemctl start oracleasm

systemctl status oracleasm

/usr/sbin/oracleasm configure -i
/usr/sbin/oracleasm init




-- Configurar ASM
[root@oradb-12c ~]# oracleasm configure -i
Configuring the Oracle ASM library driver.

This will configure the on-boot properties of the Oracle ASM library
driver.  The following questions will determine whether the driver is
loaded on boot and what permissions it will have.  The current values
will be shown in brackets ('[]').  Hitting <ENTER> without typing an
answer will keep that current value.  Ctrl-C will abort.

Default user to own the driver interface []: grid
Default group to own the driver interface []: asmadmin
Start Oracle ASM library driver on boot (y/n) [n]: y
Scan for Oracle ASM disks on boot (y/n) [y]: y
Writing Oracle ASM library driver configuration: done

-- Inicializar ASM
[root@ora12node1 ~]# oracleasm init
Creating /dev/oracleasm mount point: /dev/oracleasm
Loading module "oracleasm": oracleasm
Configuring "oracleasm" to use device physical block size
Mounting ASMlib driver filesystem: /dev/oracleasm

-- Criar os seguintes devices para prosseguir com a instalação:
2 devices de 10GB para os datafiles
1 device de 10GB para a fast recovery area
2 devices de 10GB para multiplexar os redo logs
1 device para configuração do Grid Infrastructure

-- Formatar os devices com a seguinte configuração
[root@oradb-12c ~]# fdisk /dev/sdc
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xc35c4346.

The device presents a logical sector size that is smaller than
the physical sector size. Aligning to a physical sector (or optimal
I/O) size boundary is recommended, or performance may be impacted.

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-20971519, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-20971519, default 20971519): 
Using default value 20971519
Partition 1 of type Linux and of size 10 GiB is set

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[root@oradb-12c ~]# 



-- Criar e rotular os discos no ASMlib
[root@oradb-12c ~]# oracleasm createdisk DATA1 /dev/sdc1
Writing disk header: done
Instantiating disk: done

[root@oradb-12c ~]# oracleasm createdisk FRA1 /dev/sdd1
Writing disk header: done
Instantiating disk: done

[root@oradb-12c ~]# oracleasm createdisk REDOA /dev/sde1
Writing disk header: done
Instantiating disk: done

[root@oradb-12c ~]# oracleasm createdisk REDOB /dev/sdf1
Writing disk header: done
Instantiating disk: done


--Caso na hora da instalação sofrer erros infomrando que não tem discos configurados, executar comando abaixo conforme exemplo abaixo
[root@oradb-12c ~]# oracleasm querydisk -p 
oracleasm querydisk -p 
oracleasm querydisk -p 
oracleasm querydisk -p 
oracleasm querydisk -p 


Example 3. Determine if a disk belongs to Oracle ASMlib
[root@vmrac1 ~]# oracleasm querydisk /dev/sde1
Device “/dev/sde1” is marked an ASM disk with the label “DATA2” <– this belongs to ASMLIB
[root@vmrac1 ~]# oracleasm querydisk /dev/sdb1
Device “/dev/sdb1” is not marked as an ASM disk <– this does’nt belong to ASMLIB


-- Valide a criação dos mesmos
[grid@vmoracle02 grid]$ oracleasm scandisks
Reloading disk partitions: done
Cleaning any stale ASM disks...
Scanning system for ASM disks...
[grid@vmoracle02 grid]$ oracleasm listdisks




-- Realizar o export da variavel de ambiente DISPLAY
[grid@vmoracle02]$ DISPLAY=localhost:0.0
[grid@vmoracle02]$ export DIPSPLAY

[grid@vmoracle02]$xhost

DISPLAY=CVP20231000899:0.0; export DISPLAY

-- verificar no root xauth
xauth list

-- fazer sudo sem o " - "
sudo su oracle -- exemplo
xauth add -- adicionar todas entradas que listou no root

xauth add lnxdev011.rootbrasil.intranet/unix:10  MIT-MAGIC-COOKIE-1  da5d6d4332c7892bab3f2b2215f16e25
xauth add lnxdev011.rootbrasil.intranet/unix:11  MIT-MAGIC-COOKIE-1  536cf46deb9e690495b48a5158ed726a
xauth add lnxdev011.adcorp.intranet/unix:11  MIT-MAGIC-COOKIE-1  84cf93f7447ac4c1fe66065023a07403
xauth add lnxdev011.adcorp.intranet/unix:10  MIT-MAGIC-COOKIE-1  888e8213007221203f391285171bb39e
xauth add vmlnxdev016/unix:10  MIT-MAGIC-COOKIE-1  45faf135c65b8034d6db58163b6fee60
xauth add vmlnxdev016/unix:11  MIT-MAGIC-COOKIE-1  52c8e39f1e4eb7f5bef1b85a5e7e1e74

-- Entre no diretório onde foi baixado o Grid Infrastructure Installer e execute o instalador
./runInstaller

/* Realize as seguintes configurações nas abas a seguir

1 - [Installation Option] selecione "Install and Configure Oracle Grid Infrastructure for a Standalone Server"

2 - [Product Languages] selecione as linguagens que deseja adicionar na instalação

3 - 


*/

--Caso ocorra erros na hora da instação tanto do grid, quanto do banco de dados geralmente é são erros relacionados a premissões do usuario.

--Caso ocorra de não aparecer os discos do ASM quando for instalar o database executar o comando abaixo
  -- possivel erro [INS-30502] No ASM disk group found.
usermod -a -G asmdba oracle

usermod -aG asmdba grid

usermod -a -G asmadmin,asmoper,oinstall,asmdba grid

-- pre install oracle 19c
https://yum.oracle.com/repo/OracleLinux/OL9/appstream/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el9.x86_64.rpm

yum install bc -y
yum install binutils -y
yum install compat-libcap1 -y
yum install compat-libstdc++-33 -y
yum install elfutils-libelf -y
yum install elfutils-libelf-devel -y
yum install fontconfig-devel -y
yum install glibc -y
yum install glibc-devel -y
yum install ksh -y
yum install libaio -y
yum install libaio-devel -y
yum install libXrender -y
yum install libXrender-devel -y
yum install libX11 -y
yum install libXau -y
yum install libXi -y
yum install libXtst -y
yum install libgcc -y
yum install libstdc++ -y
yum install libstdc++-devel -y
yum install libxcb -y
yum install make -y
yum install policycoreutils -y
yum install policycoreutils-python -y
yum install smartmontools -y
yum install sysstat -y


yum install bc -y
yum install binutils -y
yum install compat-openssl11 -y
yum install elfutils-libelf -y
yum install fontconfig -y
yum install glibc -y
yum install glibc-devel -y
yum install ksh -y
yum install libaio -y
yum install libasan -y
yum install liblsan -y
yum install libX11 -y
yum install libXau -y
yum install libXi -y
yum install libXrender -y
yum install libXtst -y
yum install libxcrypt-compat -y
yum install libgcc -y
yum install libibverbs -y
yum install libnsl -y
yum install librdmacm -y
yum install libstdc++ -y
yum install libxcb -y
yum install libvirt-libs -y
yum install make -y
yum install policycoreutils -y
yum install policycoreutils-python-utils -y
yum install smartmontools -y
yum install sysstat -y

-- add linhas do grid no /etc/security/limits.conf
grid             soft    nofile          1024
grid             hard    nofile          65536
grid             soft    nproc           16384
grid             hard    nproc           16384
grid             soft    stack           10240
grid             hard    stack           32768
grid             soft    memlock         134217728
grid             hard    memlock         134217728

---- Aplicar path no home antes de instalar o software do BD em casos que o SO é RED HAT
-- https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=293581428015413&id=2982833.1&_afrWindowMode=0&_adf.ctrl-state=15ls3qc94n_706

export CV_ASSUME_DISTID=RHEL8  -- usado em SO com versão acima do 9 pois gera erro ao tentar instalar o software
export CV_ASSUME_DISTID=OL8
-- instalar somente o RU 19.24
./runInstaller -applyRU /u07/36582629
./runInstaller -silent -applyRU /u02/path/36582629
./runInstaller -silent -applyRU /u03/path/36582629
./runInstaller -silent -applyRU /u04/path/36582629

./gridSetup.sh -applyRU /u01/path/36582629
./gridSetup.sh -silent -applyRU /u01/path/36582629

./gridSetup.sh -responseFile /u01/app/19.0.0.0/grid/install/response/gridsetup.rsp

-- instlar somente o sofware do Banco via silent mode
./runInstaller -silent -responseFile /u01/app/oracle/product/19.0.0.0/oraapex/install/response/dbsetud.rsp

./runInstaller -ignorePrereq -waitforcompletion -silent                        \                                                 \
    -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
    oracle.install.option=INSTALL_DB_SWONLY                                    \
    ORACLE_HOSTNAME=${ORACLE_HOSTNAME}                                         \
    UNIX_GROUP_NAME=oinstall                                                   \
    INVENTORY_LOCATION=${ORA_INVENTORY}                                        \
    SELECTED_LANGUAGES=en,en_GB                                                \
    ORACLE_HOME=${ORACLE_HOME}                                                 \
    ORACLE_BASE=${ORACLE_BASE}                                                 \
    oracle.install.db.InstallEdition=EE                                        \
    oracle.install.db.OSDBA_GROUP=dba                                          \
    oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
    oracle.install.db.OSDGDBA_GROUP=dba                                        \
    oracle.install.db.OSKMDBA_GROUP=dba                                        \
    oracle.install.db.OSRACDBA_GROUP=dba                                       \
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
    DECLINE_SECURITY_UPDATES=true


-- instalar no RU e OneOFFS  
./runInstaller -applyRU  /u02/patches/36582629/36582781 -applyOneOffs  /u02/patches/36582629/36587798

./runInstaller -silent -applyRU  /u02/dbhome19/36582629/36582781 -applyOneOffs  /u02/dbhome19/36582629/36582629/36587798


./gridSetup.sh -applyRU /u01/app/patches/36233126/36233263 -applyOneOffs /u01/app/patches/36233126/36240578

-- instalar somente o RU do GRID
./gridSetup.sh -applyRU /u01/app/patches/36582629

./gridSetup.sh -silent -applyRU /u01/app/patches/36582629

./gridSetup.sh -applyRU /u01/path/36582629/36582781 -applyOneOffs /u01/path/36582629/36587798


./gridSetup.sh -silent -applyRU /u01/path/36582629

-- verificar AFD suporte
./afddriverstate supported

-- detach home
/u01/app/19.0.0.0/grid/oui/bin/runInstaller -silent -detachHome ORACLE_HOME="/u01/app/19.0.0.0/grid"

/u01/app/19.0.0.0/grid/oui/bin/runInstaller -silent -waitforcompletion -detachHome ORACLE_HOME="/u01/app/19.0.0.0/grid" -local
/u01/app/19.0.0.0/grid/oui/bin/runInstaller -silent -waitforcompletion -detachHome ORACLE_HOME='/u01/app/19.0.0.0/grid' -local



ORADR =
(DESCRIPTION =
  (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.120)(PORT = 1521))
  (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SERVICE_NAME=ORADR)
  )
)

xauth add vmlnxdev002.adcorp.intranet/unix:10  MIT-MAGIC-COOKIE-1  663ec9d1cac5f3603f68c2152197be8a
xauth add vmlnxdev002.adcorp.intranet/unix:11  MIT-MAGIC-COOKIE-1  5c921acb2355e9ff7eb7b09a2b7b979f




xauth add vmlnxhom019/unix:11  MIT-MAGIC-COOKIE-1  79686d9c617a90288c0c4f1a15067585
xauth add vmlnxhom019/unix:10  MIT-MAGIC-COOKIE-1  c27ef8ea499ba9dc726407547805223b
xauth add vmlnxhom019.rootbrasil.intranet/unix:10  MIT-MAGIC-COOKIE-1  95a62edd250aad8b767318b84f367775
xauth add vmlnxhom019.rootbrasil.intranet/unix:11  MIT-MAGIC-COOKIE-1  f3f46ceda8641a94ef9a64ff23f6785f
xauth add vmlnxhom019.rootbrasil.intranet/unix:12  MIT-MAGIC-COOKIE-1  ccedf3fa8d4d18c9ad60236f86069718
xauth add vmlnxhom019.rootbrasil.intranet/unix:13  MIT-MAGIC-COOKIE-1  2944c859dd799201785780a325859867