
/*
Esse tipo de backup é ideal fazer com banco em mount pois não leva os archives caso queira bkp full pelo rman com archives abaixo também temos o comando.*/
-- ECC
run{
allocate channel c1 type disk format '/u02/backup/bkp_ECC_%U.rman';
allocate channel c2 type disk format '/u02/backup/bkp_ECC_%U.rman';
allocate channel c3 type disk format '/u02/backup/bkp_ECC_%U.rman';
allocate channel c4 type disk format '/u02/backup/bkp_ECC_%U.rman';
allocate channel c5 type disk format '/u02/backup/bkp_ECC_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/u02/backup/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECC CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/u02/backup/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_ECC;
BACKUP FORMAT '/u02/backup/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECC CURRENT CONTROLFILE
spfile format '/u02/backup/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_ECC;
}

-- POP
run{
allocate channel c1 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c2 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c3 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c4 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c5 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c6 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c7 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c8 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
allocate channel c9 type disk format '/backup_acfs_sap/POP/bkp_POP_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs_sap/POP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_POP CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs_sap/POP/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_POP;
BACKUP FORMAT '/backup_acfs_sap/POP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_POP CURRENT CONTROLFILE
spfile format '/backup_acfs_sap/POP/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_POP;
}

-- PSP
run{
allocate channel c1 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c2 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c3 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c4 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c5 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c6 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c7 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c8 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c9 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs_sap/PSP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_PSP CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs_sap/PSP/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_PSP;
BACKUP FORMAT '/backup_acfs_sap/PSP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_PSP CURRENT CONTROLFILE
spfile format '/backup_acfs_sap/PSP/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_PSP;
}

-- LTP
run{
allocate channel c1 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c2 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c3 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c4 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c5 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c6 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c7 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c8 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c9 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs_sap/LTP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_LTP CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs_sap/LTP/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_LTP;
BACKUP FORMAT '/backup_acfs_sap/LTP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_LTP CURRENT CONTROLFILE
spfile format '/backup_acfs_sap/LTP/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_LTP;
}

-- SJP
run{
allocate channel c1 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c2 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c3 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c4 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c5 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c6 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c7 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c8 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
allocate channel c9 type disk format '/backup_acfs_sap/ECC/bkp_ECC_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs_sap/SJP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_SJP CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs_sap/SJP/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_SJP;
BACKUP FORMAT '/backup_acfs_sap/SJP/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_SJP CURRENT CONTROLFILE
spfile format '/backup_acfs_sap/SJP/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_SJP;
}

-- com archive
run
{
allocate channel c1 type disk format  '/bkp_acfs/backup_apex/bkp_apex_prd_%U.rman';
allocate channel c2 type disk format  '/bkp_acfs/backup_apex/bkp_apex_prd_%U.rman';
allocate channel c3 type disk format  '/bkp_acfs/backup_apex/bkp_apex_prd_%U.rman';
allocate channel c4 type disk format  '/bkp_acfs/backup_apex/bkp_apex_prd_%U.rman';
allocate channel c5 type disk format  '/bkp_acfs/backup_apex/bkp_apex_prd_%U.rman';
CROSSCHECK ARCHIVELOG ALL;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/bkp_acfs/backup_apex/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEX_DEV CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/bkp_acfs/backup_apex/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_APEX_DEV;
CROSSCHECK ARCHIVELOG ALL;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/bkp_acfs/backup_apex/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEX_DEV CURRENT CONTROLFILE
spfile format '/bkp_acfs/backup_apex/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_APEX_DEV
plus archivelog format '/bkp_acfs/backup_apex/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_APEX_DEV;
}


-- comando abaixo banco precisa estar em mount para não precisar levar os archives.
run
{
allocate channel c1 type disk format  '/u02/backup/bkp_apex_prd_%U.rman';
allocate channel c2 type disk format  '/u02/backup/bkp_apex_prd_%U.rman';
allocate channel c3 type disk format  '/u02/backup/bkp_apex_prd_%U.rman';
allocate channel c4 type disk format  '/u02/backup/bkp_apex_prd_%U.rman';
allocate channel c5 type disk format  '/u02/backup/bkp_apex_prd_%U.rman';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/u02/backup/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEX_PRD CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/u02/backup/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_APEX_PRD;
BACKUP FORMAT '/u02/backup/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_APEX_PRD CURRENT CONTROLFILE
spfile format '/u02/backup/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_APEX_PRD;
}
