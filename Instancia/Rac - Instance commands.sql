ora.kpvpprd.db-- comandos para SINGLE NODE
srvctl status database -d dbwmpdsj

srvctl stop database -d dbwmpdsj
srvctl start database -d dbwmpdsj


--subir todos recursos
crsctl start resource -all

-- verifica o status do VIP
srvctl status vip -i rdp1

-- status do VIP por node
srvctl status vip -n rdp1

-- verifica a config do VIP, Retorna IP, info de REDE do VIP do node informado apos -n
srvctl config vip -n [nome do servidor]

srvctl config all

srvctl config vip -node exacc01-7jrgw1


srvctl modify database -d ECQ -a "DATAECQ"

-- verificar status de um serviço com crsctl, podendo colocar qualquer serviço com inicio ora.
crsctl status resource ora.dbembpd.svembstd.sv

--To add the instance
srvctl add instance -d db_name -i inst_name -n node_name
srvctl add instance -d racdb -i rac01 -n lnxrac1P

-- to add database single instance
srvctl add database -db kpvqa -oraclehome /u03/app/oracle/product/19.0.0.0/dbhome_2 -dbname kpvqa -diskgroup DATAC02 -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE
srvctl add database -db SDJ -oraclehome /u02/app/oracle/product/19.0.0.0/dbhome_1 -dbname SDJ -diskgroup DATA_SDJ -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE
srvctl add database -db LDT -oraclehome /u03/app/oracle/product/19.0.0.0/dbhome_2 -dbname LDT -diskgroup DATA_LDT -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE
srvctl add database -db PDO -oraclehome /u04/app/oracle/product/19.0.0.0/dbhome_3 -dbname PDO -diskgroup DATA_PDO -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE
srvctl add database -db EDC -oraclehome /u05/app/oracle/product/19.0.0.0/dbhome_4 -dbname EDC -diskgroup DATA_EDC -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE
srvctl add database -db PDS -oraclehome /u06/app/oracle/product/19.0.0.0/dbhome_5 -dbname PDS -diskgroup DATA_PDS -policy AUTOMATIC -startoption OPEN -stopoption IMMEDIATE


srvctl add database -db SDJ -oraclehome /u02/app/oracle/product/19.0.0.0/dbhome_1 -spfile /u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/spfileSDJ.ora -dbname SDJ
srvctl add database -db LDT -oraclehome /u03/app/oracle/product/19.0.0.0/dbhome_2 -spfile /u03/app/oracle/product/19.0.0.0/dbhome_2/dbs/spfileLDT.ora -dbname LDT
srvctl add database -db PDO -oraclehome /u04/app/oracle/product/19.0.0.0/dbhome_3 -spfile /u04/app/oracle/product/19.0.0.0/dbhome_3/dbs/spfilePDO.ora -dbname PDO
srvctl add database -db EDC -oraclehome /u05/app/oracle/product/19.0.0.0/dbhome_4 -spfile /u05/app/oracle/product/19.0.0.0/dbhome_4/dbs/spfileEDC.ora -dbname EDC
srvctl add database -db PDS -oraclehome /u06/app/oracle/product/19.0.0.0/dbhome_5 -spfile /u06/app/oracle/product/19.0.0.0/dbhome_5/dbs/spfilePDS.ora -dbname PDS

srvctl add database -db ECQ -oraclehome /u02/app/oracle/product/19.0.0.0/dbhome_1 -spfile /u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/spfileECQ.ora -dbname ECQ
srvctl modify database -d ECQ -a "DATAECQ"
srvctl add database -db LTH -oraclehome /u03/app/oracle/product/19.0.0.0/dbhome_2 -spfile /u03/app/oracle/product/19.0.0.0/dbhome_2/dbs/spfileLTH.ora -dbname LTH
srvctl modify database -d LTH -a "DATALTH"

srvctl add database -db POH -oraclehome /u04/app/oracle/product/19.0.0.0/dbhome_3 -spfile /u04/app/oracle/product/19.0.0.0/dbhome_3/dbs/spfilePOH.ora -dbname POH
srvctl modify database -d POH -a "DATAPOH"

SDJ:/u02/app/oracle/product/19.0.0.0/dbhome_1:N # line added by Agent 
LDT:/u03/app/oracle/product/19.0.0.0/dbhome_2:N # line added by Agent
PDO:/u04/app/oracle/product/19.0.0.0/dbhome_3:N # line added by Agent
EDC:/u05/app/oracle/product/19.0.0.0/dbhome_4:N # line added by Agent
PDS:/u06/app/oracle/product/19.0.0.0/dbhome_5:N # line added by Agent

-- modifica um parametro
srvctl modify database -db SDJ -oraclehome /u02/app/oracle/product/19.0.0.0/dbhome_1
srvctl modify database -db EDC -oraclehome /u05/app/oracle/product/19.0.0.0/dbhome_4
srvctl modify database -db PDO -oraclehome /u04/app/oracle/product/19.0.0.0/dbhome_3
srvctl modify database -db PDS -oraclehome /u06/app/oracle/product/19.0.0.0/dbhome_5


srvctl modify database -db SDJ -spfile /u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/spfileSDJ.ora
srvctl modify database -db PDO -spfile +DATAC2/pdo/parameterfile/spfile.315.1205505421

srvctl modify database -db ECQ -spfile +DATAC3/ECQ/parameterfile/spfile.1997.1210043295

srvctl modify database -db kpvpprd -spfile

srvctl modify database -db kpvstby -spfile
srvctl modify database -db kpvprd -pwfile +DATAC1/KPVPRD/PASSWORD/orapwkpvprd1

+DATAC1/KPVPRD/PASSWORD/orapwkpvprd1

pwcreate --dbuniquename KPVPRD +DATAC1/KPVPRD/PASSWORD/orapwkpvprd1

orapwd file='+DATAC1/KPVPRD/PASSWORD/orapwkpvprd1' ENTRIES=10 DBUNIQUENAME='KPVPRD' FORCE=Y 


-- copiar senha do SO para o ASM
pwcopy /u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/orapwkpvprd1 +DATAC1/KPVPRD/PASSWORD/orapwkpvprd1


--To Remove the instance
srvctl remove instance -d SDJ -i SDJ
srvctl remove instance -d racdb -i rac01

srvctl remove database -db PDO

--To Start the instance
srvctl start instance -d db_name -i inst_names [-o start_options] [-c connect_str|-q]
srvctl start instance -d db_name -i inst_names [-o open]
srvctl start instance -d db_name -i inst_names -o nomount
srvctl start instance -d db_name -i inst_names -o mount
srvctl start instance -d orakpvhm -i orakpvhm1

--To start the instance in Oracle 11g  
srvctl start instance -d db_unique_name {-n node_name -i "instance_name_list"} [-o start_options]
srvctl start instance -d racdb -n lnxrac2
srvctl start instance -d racdb -i "rac02,rac03"

--To stop the instance
srvctl stop instance -d db_name -i inst_names [-o stop_options] [-c connect_str|-q]
srvctl stop instance -d db_name -i inst_names [-o normal]
srvctl stop instance -d db_name -i inst_names -o transactional
srvctl stop instance -d db_name -i inst_names -o immediate
srvctl stop instance -d db_name -i inst_names -o abort
srvctl stop instance -d racdb -i rac03

--To stop the instance in Oracle 11g  
srvctl stop instance -d db_unique_name {[-n node_name]|[-i "instance_name_list"]} [-o stop_options] [-f]
srvctl stop instance -d racdb -n lnxrac1
srvctl stop instance -d racdb -i rac01

--To check the status of the instance
srvctl status instance -d db_name -i inst_names [-f] [-v] [-S level]
srvctl status instance -d racdb -i rac02

--To check the status of the instance in Oracle 11g  
srvctl status instance -d db_unique_name {-n node_name | -i "instance_name_list"} [-f] [-v]
srvctl status instance -d racdb -i "rac01,rac02" -v

--To enable/disable the instance
srvctl enable instance -d db_name -i inst_names
srvctl enable instance -d racdb -i "rac01,rac02"
srvctl disable instance -d db_name -i inst_names
srvctl disable inst -d racdb -i "rac01,rac03"

--To set dependency of instance to ASM
srvctl modify instance -d db_name -i inst_name {-s asm_inst_name|-r} 
srvctl modify instance -d db_unique_name -i instance_name {-n node_name|-z}
srvctl modify instance -d racdb -i rac01 -n lnxrac1
srvctl modify instance -d racdb -i rac01 -z

--To move the database instance
srvctl modify instance -d db_name -i inst_name -n node_name 
srvctl modify instance -d racdb -i rac02 -n lnxrac1

--To remove the database instance
srvctl modify instance -d db_name -i inst_name -r 
srvctl modify instance -d racdb -i rac01 -r

--To get/set/unset the environment configuration of the instance
srvctl getenv instance -d db_name -i inst_name [-t name_list]
srvctl getenv instance -d racdb -i rac01
srvctl setenv instance -d db_name [-i inst_name] {-t "name=val[,name=val,...]" | -T "name=val"}
srvctl setenv instance -d racdb -i rac01 [options]
srvctl unsetenv instance -d db_name [-i inst_name] [-t name_list]
srvctl unsetenv instance -d racdb -i rac01 [-t options]

-- realocar scan_lsitener


[oracle@node2]</home/oracle> srvctl status scan

SCAN VIP scan1 is enabled
SCAN VIP scan1 is running on node node1
SCAN VIP scan2 is enabled
SCAN VIP scan2 is running on node node2

[grid@exacc01-kpv-prd-db01 ~]$ srvctl status scan_listener
SCAN Listener LISTENER_SCAN1 is enabled
SCAN listener LISTENER_SCAN1 is running on node exacc01-kpv-prd-db01
SCAN Listener LISTENER_SCAN2 is enabled
SCAN listener LISTENER_SCAN2 is running on node exacc01-kpv-prd-db01
SCAN Listener LISTENER_SCAN3 is enabled
SCAN listener LISTENER_SCAN3 is running on node exacc01-kpv-prd-db02
[grid@exacc01-kpv-prd-db01 ~]$

srvctl relocate scan_LISTENER -i 1 -n {node desejado baseado na query anterior}


orarcu =
  (DESCRIPTION =
    (ADDRESS_LIST =
    (ADDRESS = (PROTOCOL = TCP)(HOST = exacc01-7jrgw-scan.rootbrasil.intranet)(PORT = 1521))    )
    (CONNECT_DATA =
     (SERVICE_NAME = orarcu.rootbrasil.intranet)
     (UR=A)
    )
  )




#orakpvhm1.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.98.2.117)(PORT=1521))'
#orakpvhm2.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.98.2.119)(PORT=1521))'

(ADDRESS=(PROTOCOL=TCP)(HOST=10.98.5.68)(PORT=1521)), (ADDRESS=(PROTOCOL=TCPS)(HOST=10.98.5.68)(PORT=2484))


alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.98.5.68)(PORT=1521))' scope=both sid='orakpvhm1';
alter system set local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.98.5.70)(PORT=1521))' scope=both sid='orakpvhm2';



-- verifica o owner do grid na coluna ACL
crsctl stat res ora.asm -p
-- seta para o novo
crsctl setperm resource ora.asm -o oracle
crsctl setperm resource ora.asm -g oinstall

-- subir todos recursos dos NOs
crsctl start res -all

-- Realocar o servi�o de listener scan para outro n� --

srvctl relocate scan_listener -scannumber 3 -node prdst2dbn02

-- stop listener de um nó somente
srvctl stop listener -n rac1 -l ora.rac1.LISTENER_rac1.lsnr
srvctl stop listener -n rac2 -l ora.rac2.LISTENER_rac2.lsnr

-- start listener de um nó somente
srvctl start listener -n rac1 -l ora.rac1.LISTENER_rac1.lsnr
srvctl start listener -n rac2 -l ora.rac2.LISTENER_rac2.lsnr

-- iniciar diskgroup em 1 ou mais nós
srvctl start diskgroup -diskgroup diskgroup1 -node "mynode1,mynode2"
srvctl stop diskgroup -diskgroup diskgroup1 -node "mynode1,mynode2"

-- subir banco em nós diferentes.
srvctl start database -d portalce -n sdbmid03

srvctl start instance -i 

srvctl stop service -d dbembpd -s dbembpd2 -i instance

-- verifica configurações do scan / listener / VIP
srvctl config scan
srvctl status vip -vip lnxdberpmtp1
--verifica como ta configurado no /etc/hosts
cat /etc/hosts | grep -i vip


--  Start DB
srvctl start instance -db [nomeDB] -i [nome banco que tem em cada servidor usando "ps -ef|grep pmon"]

srvctl start instance -db rdp -i rdp1
srvctl start instance -db rdp -i inst_names
srvctl start instance -db rdp -i inst_names
srvctl start instance -db rdp -i inst_names
srvctl start instance -d racdb -n lnxrac2

-- comando full para baixar e subir
srvctl start instance -d rdp -i "x8rd01dbadm01,x8rd01dbadm02,x8rd01dbadm03,x8rd01dbadm04"
srvctl stop instance -d rdp -i "rdp1,rdp2,rdp3,rdp4"

-- status intance

srvctl status instance -db [nomeDB] -i [nome banco que tem em cada servidor usando "ps -ef|grep pmon"]

srvctl status instance -db dberpmtp_gru1g7 -i DBERPMTP

srvctl status instance -db rdp -i "rdp1,rdp2,rdp3,rdp4"
srvctl status instance -db rdp -i rdp1
srvctl status instance -db rdp -i rdp2
srvctl status instance -db rdp -i rdp3
srvctl status instance -db rdp -i rdp4

--To Start the instance
-- srvctl start instance -d [nome do serviço do rac e não o nome do node/rac] -i [instancia o nome do BD de cada nó] 

srvctl start instance -db rdp -i rdp1 [-o start_options] [-c connect_str|-q]
srvctl start instance -db rdp -i rdp1 [-o open]
srvctl start instance -db rdp -i rdp1 -o nomount
srvctl start instance -db rdp -i rdp1 -o mount

srvctl start instance -d rdp -i rdp1

-- stop the instance
srvctl stop instance -db rdp -i rdp1 [-o stop_options] [-c connect_str|-q]
srvctl stop instance -db rdp -i rdp1 [-o normal]
srvctl stop instance -db rdp -i rdp1 -o transactional
srvctl stop instance -db rdp -i rdp1 -o immediate
srvctl stop instance -db rdp -i rdp1 -o abort

srvctl stop instance -d rdp -i rac01

--To add SCAN Listener
    Command: srvctl add scan_listener [-l lsnr_name_prefix] [-s] [-p "[TCP:]port_list[/IPC:key][/NMP:pipe_name][/TCPS:s_port] [/SDP:port]"
    Example: srvctl add scan_listener -l scanlistener01
    
--To Remove Scan Listener
    Command: srvctl remove scan_listener [-f]
    Example: srvctl remove scan_listener -f

--To Start Scan Listener
    Command: srvctl start scan_listener [-n node_name] [-i ordinal_number]
    Example: srvctl start scan_listener -n lnxrac1 -i 1

--To Stop Scan Listener
    Command: srvctl stop scan_listener [-i ordinal_number] [-f]
    Example: srvctl stop scan_listener -i 3

--To check the status of Scan Listner
    Command: srvctl status scan_listener [-i ordinal_number]
    Example: srvctl status scan_listener -i 1

--To Enable Scan Listener
    Command: srvctl enable scan_listener [-i ordinal_number]
    Example: srvctl enable scan_listener -i 2

--To Disable Scan Listener
    Command: srvctl disable scan_listener [-i ordinal_number]
    Example: srvctl disable scan_listener -i 1

--To Configure Scan Listener
    Command: srvctl config scan_listener [-i ordinal_number]15923
    Example: srvctl config scan_listener -i 3

--To Modify Scan Listener
    Command: srvctl modify scan_listener {-p [TCP:]port[/IPC:key][/NMP:pipe_name] [/TCPS:s_port][/SDP:port] -u }
    Example: srvctl modify scan_listener -u -p TCP:1521

--To relocate Scan Listener
    Command: srvctl relocate scan_listener -i ordinal_number [-n node_name]
    Example: srvctl relocate scan_listener -i 1 -n lnxrac2


-- verifica quais discos estão alocados para o ASM, logar com ROOT
oracleasm querydisk /dev/sd*
-- outros comandos uteis
oracleasm start
oracleasm stop
oracleasm restart
oracleasm enable
oracleasm disable
oracleasm configure
oracleasm createdisk vol1 /u01/app/oracle/data
oracleasm deletedisk
oracleasm querydisk
oracleasm listdisks
oracleasm scandisks
oracleasm status

-- O oifcfg precisa ser usado pelo usuario root, setar a instancia do +ASM, esse comando é usado para ferramenta para alteração dos IPs Público e Interconnect.
[root@exacc02-sap-hom-db02 ~]# oifcfg iflist
bondeth0  10.98.4.0
clre0  100.107.8.0
bondeth1  100.70.52.0
eth0  169.254.200.8
clre1  100.107.8.0
stre0  100.107.0.0
stre1  100.107.0.0

-- Retorna os interconects usados para o cluster, nesse caso o clre0 e clre1 estão configurados para interconnect, o bondeth0 é o publico.
[root@exacc02-sap-hom-db02 ~]# oifcfg getif
bondeth0  10.98.4.0  global  public
clre0  100.107.8.0  global  cluster_interconnect,asm
clre1  100.107.8.0  global  cluster_interconnect,asm
[root@exacc02-sap-hom-db02 ~]#


-- Voting disk, disco onde ficam armazenados os voting files é o centro do "ping" dos nodes, 
-- ele pode ter vários mirrors e também pode ser gerenciado a partir de qualquer node do cluster

[grid@exacc02-sap-hom-db01 ~]$ crsctl query css votedisk
##  STATE    File Universal Id                File Name Disk group
--  -----    -----------------                --------- ---------
 1. ONLINE   057675f8a1524fa5bf869d7acfa43752 (o/100.107.0.9;100.107.0.10/DATAC3_CD_04_gru146110exdcl01) [DATAC3]
 2. ONLINE   afe8a2ffa96b4f05bf16540a805c2ea4 (o/100.107.0.11;100.107.0.12/DATAC3_CD_03_gru146110exdcl02) [DATAC3]
 3. ONLINE   65ddad53cb6e4f4fbfe66fc6974e208b (o/100.107.0.13;100.107.0.14/DATAC3_CD_10_gru146110exdcl03) [DATAC3]
 4. ONLINE   94352bc963b24f67bf962bb07a171b39 (/dev/exadata_quorum/QD_DATAC3_EXACC02SAPHOMDB01) [DATAC3]
 5. ONLINE   36d032a9fa874fb7bfc7773c8c54ed60 (/dev/exadata_quorum/QD_DATAC3_EXACC02SAPHOMDB02) [DATAC3]
