RUN {
Configure retention policy to redundancy 2;
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
sql 'alter system archive log current';
BACKUP FILESPERSET 10 FORMAT '/u02/duplicate/bkp_orarcu/bkp_database_%d_%T_%t_%s.rman' DATABASE;
BACKUP FORMAT '/u02/duplicate/bkp_orarcu/bkp_spfile_%d_%T_%t_%s.rman' SPFILE;
BACKUP FILESPERSET 30 FORMAT '/u02/duplicate/bkp_orarcu/bkp_archive_%d_%T_%t_%s.rman' ARCHIVELOG ALL;
BACKUP FORMAT '/u02/duplicate/bkp_orarcu/bkp_ctrl_%d_%T_%t_%s.rman' CURRENT CONTROLFILE;
RELEASE CHANNEL ch00;
RELEASE CHANNEL ch01;
RELEASE CHANNEL ch02;
RELEASE CHANNEL ch03;
Crosscheck archivelog all;
Crosscheck backup of database;
Delete noprompt expired backup;
Delete noprompt expired archivelog all;
Delete noprompt obsolete;

}



run {
set controlfile autobackup format for device type disk to '/u02/duplicate/bkp_orarcu/backup-orarcu-%F.rman' ;
BACKUP device type disk format '/u02/duplicate/bkp_orarcu/backup-orarcu-t%T-b%up%pc%c.rman' FULL DATABASE ;
show all ;
report schema ;
report unrecoverable ;
report need backup ;
}


RUN {
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP AS COMPRESSED BACKUPSET FORMAT '/acfs01/bkp_catalog/df_%d_%s_%p.bkp'
DATABASE PLUS ARCHIVELOG;
backup spfile format '/acfs01/bkp_catalog/spfile_catalog_backup_%T_%t_%s.bkp';
backup current controlfile format '/acfs01/bkp_catalog/cf_%d_%t.bkp';
RELEASE CHANNEL ch00;
RELEASE CHANNEL ch01;
RELEASE CHANNEL ch02;
RELEASE CHANNEL ch03;
}

-- backup completo do banco, spfile e controlfile, com compressão, usando 4 canais, e backup dos arquivos de archive log. 
-- O backup é feito em formato backupset, e os arquivos de backup são nomeados com o formato especificado. Após o backup, os canais são liberados.
-- banco de dados do catalogo em mount
run
{
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
ALLOCATE CHANNEL ch04 TYPE DISK;
ALLOCATE CHANNEL ch05 TYPE DISK;
ALLOCATE CHANNEL ch06 TYPE DISK;
ALLOCATE CHANNEL ch07 TYPE DISK;
ALLOCATE CHANNEL ch08 TYPE DISK;
ALLOCATE CHANNEL ch09 TYPE DISK;
ALLOCATE CHANNEL ch10 TYPE DISK;
BACKUP FORMAT '/bkp_catalog/OLD/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/bkp_catalog/OLD/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL;
BACKUP FORMAT '/bkp_catalog/OLD/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE CURRENT CONTROLFILE
spfile format '/bkp_catalog/OLD/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE;
}

-- com archive
run
{
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
BACKUP FORMAT '/bkp_catalog/OLD/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_HOM CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/bkp_catalog/OLD/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_HOM;
BACKUP FORMAT '/bkp_catalog/OLD/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_HOM CURRENT CONTROLFILE
spfile format '/bkp_catalog/OLD/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_HOM
plus archivelog format '/acfs_backup/orarcu_bkp/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_KPVHOM;
}

-- BACKUP com archive ja pra standby
run
{
allocate channel c1 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c2 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c3 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c4 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c5 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c6 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/acfs_backup/apexprd_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEXPRD CURRENT CONTROLFILE FOR STANDBY;
backup as compressed backupset incremental level 0 database format '/acfs_backup/apexprd_bkp/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_APEXPRD;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/acfs_backup/apexprd_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEXPRD CURRENT CONTROLFILE FOR STANDBY
spfile format '/acfs_backup/apexprd_bkp/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_APEXPRD
plus archivelog format '/acfs_backup/apexprd_bkp/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_APEXPRD;
CROSSCHECK ARCHIVELOG ALL;
}

run
{
allocate channel c1 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c2 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c3 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c4 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c5 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
allocate channel c6 type disk format  '/acfs_backup/apexprd_bkp/bkp__%U.rman';
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/acfs_backup/apexprd_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEXSTBY CURRENT CONTROLFILE for standby;
backup as compressed backupset incremental level 0 database format '/acfs_backup/apexprd_bkp/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_APEXSTBY;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/acfs_backup/apexprd_bkp/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEXSTBY CURRENT CONTROLFILE for standby
spfile format '/acfs_backup/apexprd_bkp/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_APEXSTBY
plus archivelog format '/acfs_backup/apexprd_bkp/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_APEXSTBY;
}

--- /*/---
run
{
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
BACKUP FORMAT '/bkp_catalog/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/bkp_catalog/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL;
BACKUP FORMAT '/bkp_catalog/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE CURRENT CONTROLFILE
spfile format '/bkp_catalog/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE;
}


run{
ALLOCATE CHANNEL ch00 TYPE DISK;
ALLOCATE CHANNEL ch01 TYPE DISK;
ALLOCATE CHANNEL ch02 TYPE DISK;
ALLOCATE CHANNEL ch03 TYPE DISK;
set newname for datafile 1 to '+DATAC4/DBRMAN/DATAFILE/system.270.1230891433' ;
set newname for datafile 2 to '+DATAC4/DBRMAN/DATAFILE/tbs_monitor.276.1230891323' ;
set newname for datafile 3 to '+DATAC4/DBRMAN/DATAFILE/sysaux.275.1230891339' ;
set newname for datafile 4 to '+DATAC4/DBRMAN/DATAFILE/undotbs1.277.1230891323' ;
set newname for datafile 5 to '+DATAC4/DBRMAN/DATAFILE/tbs_catalogo.265.1230891433' ;
set newname for datafile 7 to '+DATAC4/DBRMAN/DATAFILE/users.274.1230891339' ;
set newname for datafile 8 to '+DATAC4/DBRMAN/DATAFILE/undotbs2.266.1230892683' ;
restore database;
switch datafile all;
recover database;
}

alter system set control_files='+DATAC1/DBRMAN/CONTROLFILE/current.261.1230939363','+RECO/DBRMAN/CONTROLFIL/current.259.1230939363' scope=spfile;



run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
set newname for datafile 1 to '+DATAC4/DBRMAN/DATAFILE/system.270.1230891433' ;
set newname for datafile 2 to '+DATAC4/DBRMAN/DATAFILE/tbs_monitor.276.1230891323' ;
set newname for datafile 3 to '+DATAC4/DBRMAN/DATAFILE/sysaux.275.1230891339' ;
set newname for datafile 4 to '+DATAC4/DBRMAN/DATAFILE/undotbs1.277.1230891323' ;
set newname for datafile 5 to '+DATAC4/DBRMAN/DATAFILE/tbs_catalogo.265.1230891433' ;
set newname for datafile 7 to '+DATAC4/DBRMAN/DATAFILE/users.274.1230891339' ;
set newname for datafile 8 to '+DATAC4/DBRMAN/DATAFILE/undotbs2.266.1230892683' ;
restore database;
switch datafile all;
}

/c-4127483320-20260201-00

run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
restore controlfile to '/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/control_file_01.cf' from '/c-4127483320-20260406-00';
release channel ch1;
} 



/usr/openv/netbackup/bin/bplist -S cvpnbuprimary01.adcorp.intranet -C vmlnxprd037.adcorp.intranet -t 4 -l -R /



run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
SET UNTIL TIME "TO_DATE('05/04/2026 23:00:00','DD/MM/YYYY HH24:MI:SS')";
set newname for datafile 1 to '+DATAC4/DBRMANTST/DATAFILE/system.270.1230891433';
set newname for datafile 2 to '+DATAC4/DBRMANTST/DATAFILE/tbs_monitor.276.1230891323';
set newname for datafile 3 to '+DATAC4/DBRMANTST/DATAFILE/sysaux.275.1230891339';
set newname for datafile 4 to '+DATAC4/DBRMANTST/DATAFILE/undotbs1.277.1230891323';
set newname for datafile 5 to '+DATAC4/DBRMANTST/DATAFILE/tbs_catalogo.265.1230891433';
set newname for datafile 7 to '+DATAC4/DBRMANTST/DATAFILE/users.274.1230891339';
set newname for datafile 8 to '+DATAC4/DBRMANTST/DATAFILE/undotbs2.266.1230892683';
RESTORE DATABASE;
SWITCH DATAFILE ALL;
RECOVER DATABASE;
}


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=dbrman,NB_ORA_POLICY=ORA_CVP_CATALOG,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxprd037.adcorp.intranet)';
SET UNTIL TIME "TO_DATE('05/04/2026 12:00:00','DD/MM/YYYY HH24:MI:SS')";
RECOVER DATABASE;
}