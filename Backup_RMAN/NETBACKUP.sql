Instalação do Client NetBackup no Linux
Objetivo
Descrever o procedimento para instalação do Client do Netbackup em servidores Linux.
Informações
O cliente do NetBackup esta localizado no compartilhamento abaixo:
\\VMSERVER832\Netbackup\
O master server do NetBackup é o lnxprd085.
Antes da instalação
Para qualquer versão do SO verifique se o /tmp possui permissão de execução, se não está com o parametro noexec no ponto de montagem, se estiver realizar um remount sem o parâmetro noexec execute a instalação e remonte com o parametro novamente.
Para Red Hat Enterprise Linux 8.x verifique se a libnsl está instalada, caso não esteja instale a mesma:
# yum install libnsl
Procedimento
No servidor onde o cliente será instalado, monte o compartilhamento, conforme exemplo abaixo:
Ex:
# mount -t cifs //10.100.8.132/Netbackup/NetBackup_8.2_Linux /mnt/ -o user=root,domain=rootbrasil.intranet

Entre no diretório:
# cd /mnt/NetBackup_8.2_CLIENTS2/
Execute o instalador para iniciar o processo de instalação.
# ./install
Veritas Installation Script
Copyright (c) 201eritas Technologies LLC. All rights reserved.
Installing NetBackup Client Software
...output omitted...
Do you wish to continue? [y,n] (y) <-Enter para continuar...
...output omitted...
Do you want to install the NetBackup client software
for this client? [y,n] (y) <-Enter para continuar...
This package will install Linux/RedHat2.6.32 client.
This package will install NetBackup client 8.2.
Enter the name of the NetBackup
master server : lnxprd085 <- Coloque o nome do Master Server...
Would you like to use "lnxprdxxx.rootbrasil.intranet"
as the configured name of the NetBackup client? [y,n] (y) <- Enter para continuar...
...output omitted...
CA Certificate received successfully from server lnxprd085.
...output omitted...
Is this correct? [y,n] y<- Enter para continuar...
...output omitted...
Enter the authorization token for lnxprd085 or q to skip: <- Coloque o token informado pelo administrador do netbackup.
...output omitted...
That file can be deleted after you are sure the install was successful.
Finalizada a instalação, desmonte o compartilhamento montando anteriormente:
# umount /mnt
Inicie o Netbackup:
# systemctl daemon-reload
# systemctl enable netbackup
# systemctl start netbackup


-- verificar dados do backup
/usr/openv/netbackup/bin/admincmd/bpimagelist -backupid exacc01-7jrgw1.rootbrasil.intranet_1749764500 -L
/usr/openv/netbackup/bin/admincmd/bpimagelist -backupid exasapprdbkp1_1758801885 -L


/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C exacc01-7jrgw1.rootbrasil.intranet -t 4 -l -R /
/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C exasapprdbkp1 -t 4 -l -R / 
/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C exacc01-kpv-prd-db01 -t 4 -l -R / 
/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C exacc01-kpv-hom-db01 -t 4 -l -R /

/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C vmlnxprd037.adcorp.intranet -t 4 -l -R /


/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C orarcu_55b_gru_4284662918 -t 4 -l -R /

/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C kpvprd_3325602173 -t 4 -l -R /


bplist -C CLIENT_B -t 4 -l /
-- Polices backups Oracle
kiprev prd - ORA_CVP_KIPREV_PROD
    NB_ORA_CLIENT= kpvprd_3325602173

orarcu - ORA_CVP_ORARCU_PROD_EX10
    NB_ORA_CLIENT= orarcu_55b_gru_4284662918

kiprev hom - 
kiprev stby - 
SAP prd -  
    NB_ORA_CLIENT=exasapprdbkp1,  
    NB_ORA_CATALOG_HOST=ecc_1235991203,
    NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
    NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,
    
SAP hom - 
SAV dev -

DBRMAN- ORA_CVP_CATALOG

-- politicas SAP
ORA_CVP_SAP_PROD_POP
ORA_CVP_SAP_PROD_SJP
ORA_CVP_SAP_PROD_ECC
ORA_CVP_SAP_PROD_PSP
ORA_CVP_SAP_PROD_LTP


--backup pra tape
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
    BACKUP CURRENT CONTROLFILE FOR STANDBY;
    release channel c1;
} 

orarcu_55b_gru_4284662918

-- sap prd 
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
    set DBID=3325602173
    restore controlfile to '/tmp/controlfile.bkp' from '/ctrl_dECC_uch44kr0j_s6181265_p1_t1212836883';
    release channel c1;
} 

-- sap hom 
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
    restore controlfile to '/backup_acfs/controlfile.bkp' from '/c-1235991203-20260822-09';
    release channel c1;
} 

run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
    restore controlfile to '/acfs01/ECQ/archives/controlfile.bkp' from '/c-1235991203-20260822-09';
    release channel c1;
} 

-- restore do controlfile direto para o local que está configurado o pfile ou spfile'
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
    restore controlfile to '/tmp/controlfile_tst.bkp' from '/c-3325602173-20260324-22';
    release channel c1;
} 


run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
    SET ARCHIVELOG DESTINATION TO '/tmp';
    restore archivelog from logseq=46741 until logseq=46742 thread 1;
    release channel c1;
}


run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
    set DBID=3325602173;
    set archivelog destination to '+RECOC2/ARCHIVELOG';
    restore archivelog logseq=46741;
    release channel c1;
} 




Mar 17, 2026 9:08:13 AM - begin Restore
Mar 17, 2026 9:08:13 AM - Info bprd (pid=147703) Found (1) files in (1) images for Restore Job ID 6124915.xxx
Mar 17, 2026 9:08:43 AM - restoring from image kpvprd_3325602173_1773669970
Mar 17, 2026 9:08:43 AM - Info bprd (pid=147703) Searched (1) files of (1) files for Restore Job ID 6124915.xxx
Mar 17, 2026 9:08:43 AM - requesting resource @aaaad
Mar 17, 2026 9:08:43 AM - granted resource MediaID=@aaaad;DiskVolume=PureDiskVolume;DiskPool=DP_WORM_CVPNBUWORM01;Path=PureDiskVolume;StorageServer=cvpnbuworm01.adcorp.intranet;MediaServer=cvpnbumedia01.adcorp.intranet
Mar 17, 2026 9:08:58 AM - Info bprd (pid=147703) Restoring from copy 1 of image created Mon Mar 16 11:06:10 2026 from policy ORA_CVP_KIPREV_PROD
Mar 17, 2026 9:09:29 AM - Info bpbrm (pid=2434629) connect failed STATUS (18) CONNECT_FAILED
Mar 17, 2026 9:09:29 AM - Info bpbrm (pid=2434629) status: FAILED, (42) CONNECT_REFUSED; system: (111) Connection refused; FROM 0.0.0.0 TO exacc01-kpv-hom-db01 100.70.52.36 bpcd VIA pbx
Mar 17, 2026 9:09:29 AM - Info bpbrm (pid=2434629) status: FAILED, (42) CONNECT_REFUSED; system: (111) Connection refused; FROM 0.0.0.0 TO exacc01-kpv-hom-db01 100.70.52.36 bpcd VIA vnetd
Mar 17, 2026 9:09:29 AM - Error bpbrm (pid=2434629) bpcd on exacc01-kpv-hom-db01 exited with status 9132: Cannot connect to the host. Verify if the NetBackup services are running on the host.
Mar 17, 2026 9:09:29 AM - Info tar (pid=0) done. status: 9132: Cannot connect to the host. Verify if the NetBackup services are running on the host.
Mar 17, 2026 9:09:29 AM - Error bpbrm (pid=2434629) client restore EXIT STATUS 9132: Cannot connect to the host. Verify if the NetBackup services are running on the host.
Mar 17, 2026 9:09:44 AM - restored from image kpvprd_3325602173_1773669970; restore time: 0:01:01


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
restore controlfile to '/tmp/controlfile_tst.bkp' from '/c-4284662918-20251201-19';
}


run {
    ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_4284662918)';
    restore controlfile to '/tmp/controlfile_tst.bkp' from '/ctrl_dECC_uch44kr0j_s6181265_p1_t1212836883';
    release channel c1;
} 





run {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
set archivelog destination to '/acfs01/arch';
restore archivelog from logseq=338 until logseq=339 thread 1;
release channel c1;
}


run {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';    
    set archivelog destination to '/acfs01/arch';
    restore archivelog logseq=333 thread 1;
    release channel c1;
}   


-- servidores backup
100.70.52.10 cvpnbuprimary01.adcorp.intranet
100.70.52.11 cvpnbumedia01.adcorp.intranet
100.70.52.12 cvpnbuworm01.adcorp.intranet

1556
13782
13784
443

13724

curl -vv telnet://100.70.52.10:13724
curl -vv telnet://100.70.52.10:1556
curl -vv telnet://100.70.52.10:13782
curl -vv telnet://100.70.52.10:13720
curl -vv telnet://100.70.52.10:443

curl -vv telnet://100.70.52.38:13724
curl -vv telnet://100.70.52.38:1556
curl -vv telnet://100.70.52.38:13782
curl -vv telnet://100.70.52.38:13720
curl -vv telnet://100.70.52.38:443


SERVER = cvpnbuprimary01.adcorp.intranet
SERVER = cvpnbumedia01.adcorp.intranet
SERVER = cvpnbuworm01.adcorp.intranet
CLIENT_NAME = vmlnxhom015.adcorp.intranet
CONNECT_OPTIONS = localhost 1 0 2
NB_FIPS_MODE = DISABLE
MEDIA_SERVER = cvpnbuworm01.adcorp.intranet
MEDIA_SERVER = cvpnbumedia01.adcorp.intranet
SERVICE_USER = root


SERVER = cvpnbuprimary01.adcorp.intranet
SERVER = cvpnbumedia01.adcorp.intranet
SERVER = cvpnbuworm01.adcorp.intranet
CLIENT_NAME = exacc03-kpv-drs-db01
CONNECT_OPTIONS = localhost 1 0 2
NB_FIPS_MODE = DISABLE
MEDIA_SERVER = cvpnbuworm01.adcorp.intranet
MEDIA_SERVER = cvpnbumedia01.adcorp.intranet
SERVICE_USER=root


curl --interface eth0 https://exemplo.com
curl -vvv --interface bondeth0 100.70.52.10:1556

curl -vvv --interface bondeth0 telnet://100.70.52.10:13724
curl -vvv --interface bondeth0 telnet://100.70.52.10:1556
curl -vvv --interface bondeth0 telnet://100.70.52.10:13782
curl -vvv --interface bondeth0 telnet://100.70.52.10:13720
curl -vvv --interface bondeth0 telnet://100.70.52.10:443

1556/tcp (PBX) - comunicação principal entre todos os componentes NetBackup.
13724/tcp (vnetd) - transferência de dados e controle.
13782/tcp (bpcd) - inicialização de conexões de backup/restore.
13720/tcp (bpjava-msvc) - usado em algumas operações administrativas.


-- valida certificado / força validação do certificado

/usr/openv/netbackup/bin - linux
./nbcertcmd -getCACertificate
./nbcertcmd -getCertificate 
./nbcertcmd -getcrl

/usr/openv/netbackup/bin/nbcertcmd -getCACertificate -server cvpnbuprimary01.adcorp.intranet

./nbcertcmd -getCertificate -server cvpnbuprimary01.adcorp.intranet -token OCHKHIGPFPTHEHUQ


-- select para trazer todas informações que o netbackup precisa para configurar o backup.
set lines 1000 pages 500
select name,db_unique_name,dbid from v$database;
select instance_name,host_name from v$instance;


-- cria usuario container
create user C##ORACLE_BKP identified by "Ekl09#BZp01" CONTAINER=ALL;
account unlock;

-- cria usuario padrão
create user oracle_bkp identified by "SKA04P#Bzp11" ;
alter user oracle_bkp account unlock;

-- quando for container
grant connect to C##ORACLE_BKP  CONTAINER=ALL;
grant resource to C##ORACLE_BKP  CONTAINER=ALL;
grant sysbackup to C##ORACLE_BKP  CONTAINER=ALL;
grant sysdba to C##ORACLE_BKP  CONTAINER=ALL;
GRANT DBA TO C##ORACLE_BKP  CONTAINER=ALL;
grant create session to C##ORACLE_BKP  CONTAINER=ALL;

-- quando for não container
grant connect to ORACLE_BKP;
grant resource to ORACLE_BKP;
grant sysbackup to ORACLE_BKP;
grant create session to ORACLE_BKP;
grant sysdba to ORACLE_BKP; 
GRANT DBA TO ORACLE_BKP;




create user oracle_bkp identified by "SKA04P#Bzp11" ;
alter user oracle_bkp account unlock;
grant connect to ORACLE_BKP;
grant resource to ORACLE_BKP;
grant sysbackup to ORACLE_BKP;
grant create session to ORACLE_BKP;



LISTENER =(DESCRIPTION_LIST =(DESCRIPTION =(ADDRESS = (PROTOCOL = IPC)(KEY = LISTENER))(ADDRESS = (PROTOCOL = TCP)(HOST = 100.70.52.30)(PORT = 1521))))

run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
set newname for datafile  1 to '+DATAC1/ORARCUSTBY/DATAFILE/system.285.1204301647';
set newname for datafile  2 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/system.274.1204301413';
set newname for datafile  3 to '+DATAC1/ORARCUSTBY/DATAFILE/sysaux.294.1204301627' ;
set newname for datafile  4 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/sysaux.265.1204301413';
set newname for datafile  5 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs1.286.1204301667';
set newname for datafile  6 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/undotbs1.291.1204301413';
set newname for datafile  7 to '+DATAC1/ORARCUSTBY/DATAFILE/users.284.1204301685';
set newname for datafile  8 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs2.293.1204301627';
set newname for datafile  9 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/system.305.1204302005';
set newname for datafile 10 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/sysaux.299.1204302015';
set newname for datafile 11 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undotbs1.300.1204302025';
set newname for datafile 12 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undo_2.301.1204302035';
set newname for datafile 13 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/users.304.1204302005';
set newname for datafile 14 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_mds.1248.1205714379';
set newname for datafile 15 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_wls.1247.1205714381';
set newname for datafile 16 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_ums.1246.1205714381';
set newname for datafile 17 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_iau.1245.1205714383';
set newname for datafile 18 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_stb.1244.1205714385';
set newname for datafile 19 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_opss.1243.1205714385';
restore database;
switch datafile all;
}

run {
ALLOCATE CHANNEL c1 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c2 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c3 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c4 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c5 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c6 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c7 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c8 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c9 TYPE  'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c11 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
sql 'alter session set nls_date_format="YYYY-MM-DD HH24:MI:SS"';
recover database;
}



--backup pra tape
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
    BACKUP CURRENT CONTROLFILE FOR STANDBY;
    release channel c1;
} 


run {
ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/acfs_backup/orarcu_bkp/ctrl_standby_rcu_%U.ctl';
RELEASE CHANNEL c1;
}

run
{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP CURRENT CONTROLFILE FOR STANDBY;
backup as compressed backupset incremental level 0 database tag BKP_FULL_RCU plus archivelog;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP CURRENT CONTROLFILE FOR STANDBY;
}

-- backup ORARCU CDB FULL
run
{
allocate channel c1 type disk format  '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';
allocate channel c2 type disk format  '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';
allocate channel c3 type disk format  '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/acfs_backup/orarcu_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_RCU CURRENT CONTROLFILE FOR STANDBY;
backup as compressed backupset incremental level 0 database format '/acfs_backup/orarcu_bkp/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_RCU;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/acfs_backup/orarcu_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_RCU CURRENT CONTROLFILE FOR STANDBY
spfile format '/acfs_backup/orarcu_bkp/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_RCU
plus archivelog format '/acfs_backup/orarcu_bkp/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_RCU;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
}

-- geraro por IA nao testado
RUN {
    ALLOCATE CHANNEL c1 DEVICE TYPE DISK FORMAT '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';
    ALLOCATE CHANNEL c2 DEVICE TYPE DISK FORMAT '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';
    ALLOCATE CHANNEL c3 DEVICE TYPE DISK FORMAT '/acfs_backup/orarcu_bkp/bkp_rcu_%U.rman';

    # 1. Força a escrita de tudo que está em memória para o disco
    SQL 'ALTER SYSTEM CHECKPOINT';
    SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';

    # 2. Backup Full (CDB + PDBs)
    BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 0 
    DATABASE FORMAT '/acfs_backup/orarcu_bkp/BKP_FULL_%d_%u_%s_%T.rman' 
    TAG BKP_FULL_RCU;

    # 3. Backup dos Archivelogs gerados durante o Full (crucial para o Recover no destino)
    SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';
    BACKUP ARCHIVELOG ALL FORMAT '/acfs_backup/orarcu_bkp/BKP_ARCH_%d_%u_%s_%T.rman' TAG BKP_ARCH_RCU;

    # 4. O PASSO MAIS IMPORTANTE: Controlfile FOR STANDBY e SPFILE por último
    BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/acfs_backup/orarcu_bkp/BKP_CONTROLFILE_STANDBY_%d_%u_%s_%T.rman' TAG BKP_CONTROLFILE_RCU;
    BACKUP SPFILE FORMAT '/acfs_backup/orarcu_bkp/BKP_SPFILE_%d_%u_%s_%T.rman' TAG BKP_SPFILE_RCU;

    RELEASE CHANNEL c1;
    RELEASE CHANNEL c2;
    RELEASE CHANNEL c3;
}

-- restore ORARCUSTBY
run {
ALLOCATE CHANNEL c1 DEVICE TYPE DISK FORMAT '/acfs01/orarcubkp/bkp_rcu_%U.rman';
ALLOCATE CHANNEL c2 DEVICE TYPE DISK FORMAT '/acfs01/orarcubkp/bkp_rcu_%U.rman';
ALLOCATE CHANNEL c3 DEVICE TYPE DISK FORMAT '/acfs01/orarcubkp/bkp_rcu_%U.rman';
set newname for datafile  1 to '+DATAC1/ORARCUSTBY/DATAFILE/system.285.1204301647';
set newname for datafile  2 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/system.274.1204301413';
set newname for datafile  3 to '+DATAC1/ORARCUSTBY/DATAFILE/sysaux.294.1204301627' ;
set newname for datafile  4 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/sysaux.265.1204301413';
set newname for datafile  5 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs1.286.1204301667';
set newname for datafile  6 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/undotbs1.291.1204301413';
set newname for datafile  7 to '+DATAC1/ORARCUSTBY/DATAFILE/users.284.1204301685';
set newname for datafile  8 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs2.293.1204301627';
set newname for datafile  9 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/system.305.1204302005';
set newname for datafile 10 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/sysaux.299.1204302015';
set newname for datafile 11 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undotbs1.300.1204302025';
set newname for datafile 12 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undo_2.301.1204302035';
set newname for datafile 13 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/users.304.1204302005';
set newname for datafile 14 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_mds.1248.1205714379';
set newname for datafile 15 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_wls.1247.1205714381';
set newname for datafile 16 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_ums.1246.1205714381';
set newname for datafile 17 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_iau.1245.1205714383';
set newname for datafile 18 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_stb.1244.1205714385';
set newname for datafile 19 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_opss.1243.1205714385';
restore database;
switch datafile all;
}



run {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
set newname for datafile  1 to '+DATAC1/ORARCUSTBY/DATAFILE/system.285.1204301647';
set newname for datafile  2 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/system.274.1204301413';
set newname for datafile  3 to '+DATAC1/ORARCUSTBY/DATAFILE/sysaux.294.1204301627' ;
set newname for datafile  4 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/sysaux.265.1204301413';
set newname for datafile  5 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs1.286.1204301667';
set newname for datafile  6 to '+DATAC1/ORARCUSTBY/38069C47A2C3D0CDE0634301620A908E/DATAFILE/undotbs1.291.1204301413';
set newname for datafile  7 to '+DATAC1/ORARCUSTBY/DATAFILE/users.284.1204301685';
set newname for datafile  8 to '+DATAC1/ORARCUSTBY/DATAFILE/undotbs2.293.1204301627';
set newname for datafile  9 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/system.305.1204302005';
set newname for datafile 10 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/sysaux.299.1204302015';
set newname for datafile 11 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undotbs1.300.1204302025';
set newname for datafile 12 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undo_2.301.1204302035';
set newname for datafile 13 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/users.304.1204302005';
set newname for datafile 14 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_mds.1248.1205714379';
set newname for datafile 15 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_wls.1247.1205714381';
set newname for datafile 16 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_ums.1246.1205714381';
set newname for datafile 17 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_iau.1245.1205714383';
set newname for datafile 18 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_stb.1244.1205714385';
set newname for datafile 19 to '+DATAC1/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_opss.1243.1205714385';
restore database;
switch datafile all;
}