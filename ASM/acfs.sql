-- 
asmcmd volinfo -G RECOC3 /backup_acfs
asmcmd volinfo --all
--
srvctl start filesystem -d /dev/asm/backup_acfs-337 -n exasapdrs1

asmcmd volcreate -G DATAC1 -s 8000G backup_sap
 
-- Deve ser formatado a partir do valor que pegou no comando volinfo
mkfs -t acfs /dev/asm/backup_sap-399
 
-- monta no servidor atual na pasta desejada
mount -t acfs /dev/asm/backup_sap-399 /backup_acfs_sap


-- fazer o registro RAC/Cluster (registro ACFS/CRS):
/sbin/acfsutil registry -a /dev/asm/backup_sap-399 /backup_acfs_sap -u oracle


-- com usuario grid, aumentar o ACFS sem desmonstar, coloque o valor final que deseja com o acfsutil é possivel aumentar tendo espaço no DISKGROUP com 
acfsutil size 6T /acfs_backup
acfsutil size 500G /backup_acfs

--comandos uteis
acfsutil info fs /backup_acfs
asmcmd volinfo -G DATAC1 backup_acfs




run
{
allocate channel c1 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c2 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c3 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c4 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c5 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c6 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c7 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
allocate channel c8 type disk format  '/backup_acfs/ECT/bkp_ECT_%U.rman';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/backup_acfs/ECT/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECT CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs/ECT/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_ECT;
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/backup_acfs/ECT/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECT CURRENT CONTROLFILE
spfile format '/backup_acfs/ECT/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_ECT
plus archivelog format '/backup_acfs/ECT/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_ECT;
}


run{
allocate channel c1 device type disk format '/work-tmp/prod/%d_%I_%p_%s';
backup as compressed backupset database plus archivelog;
backup current controlfile for standby format '/work-tmp/prod/controlfile_atual.bkp';
}