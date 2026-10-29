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

-- fazer start em um serviço de listener, exemplo no crsctl status res -t mostra o serviço com nome "ora.ect.sap_ect1.svc" faça o start com o comando abaixo:
srvctl start service -db ECQ -service sap_ecq1
srvctl start service -db ECQ -service sap_ecq2

-- verifica configurações do scan / listener / VIP
srvctl config scan
srvctl status vip -vip exacc02-sap-dev-db02
srvctl status scan

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


srvctl status scan_listener


-- Add serviço a administração do RAC
-- Caso tenha uma app que precise balancear o load entre os nós do RAC, é necessário criar um serviço para que o listener possa redirecionar a conexão para cada nó.
-- Fonte: https://docs.oracle.com/en/database/oracle/oracle-database/19/racad/workload-management-with-dynamic-database-services.html#GUID-BA90E5A3-140D-40BB-97F7-466E994CA3E5
srvctl add service -db kpvprd -service KPVPRD_APP -preferred kpvprd1,kpvprd2

-- modifica o serviço para que o listener possa redirecionar a conexão para cada nó.
srvctl modify service -db ORCL -service APPSRV -clbgoal SHORT -rlbgoal SERVICE_TIME


--To add SCAN Listener
    Command: srvctl add scan_listener [-l lsnr_name_prefix] [-s] [-p [TCP:]port_list[/IPC:key][/NMP:pipe_name][/TCPS:s_port] [/SDP:port]
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