shutdown immediate;

startup mount exclusive restrict;

drop database;

CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' MAXPIECESIZE 2 G FORMAT   '%d_%I_%U_%T_%t' 
PARMS  'SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so ENV=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)';


run {
        set decryption identified by "#Ruop19023@#!" ;
        ALLOCATE channel t1 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t2 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t3 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t4 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t5 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t6 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t7 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t8 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		ALLOCATE channel t9 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so, SBT_PARMS=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
        set until time "to_date('20/03/2025 23:07:39','DD/MM/YYYY HH24:MI:SS')";
		set newname for database to '/oracle/oradata/extrabc5hml/%b';
		restore database;
		switch datafile all;
		switch tempfile all;
		recover database delete archivelog;
		}





allocate channel ch01 type 'SBT_TAPE' parms 'ENV=(TDPO_OPTFILE=/tivoli/tsmcl/tdpo_db_cl.opt)';



#spfile
/oracle/product/11.2.0/db_2/dbs/spfileextrabc5hml.ora

#controlfile
/oracle/oradata/extrabc5hml/control.ctl

#redu log
SELECT * FROM V$LOGFILE;

GROUP# STATUS  TYPE    MEMBER                                                            IS_
---------- ------- ------- ----------------------------------------------------------------- ---
         3         ONLINE  /oracle/oradata/extrabc5hml/redo03b.dbf                           NO
         3         ONLINE  /oracle/oradata/extrabc5hml/redo03a.dbf                           NO
         2         ONLINE  /oracle/oradata/extrabc5hml/redo02b.dbf                           NO
         2         ONLINE  /oracle/oradata/extrabc5hml/redo02a.dbf                           NO
         1         ONLINE  /oracle/oradata/extrabc5hml/redo01b.dbf                           NO
         1         ONLINE  /oracle/oradata/extrabc5hml/redo01a.dbf                           NO
         4         ONLINE  /oracle/oradata/extrabc5hml/redo04a.dbf                           NO
         4         ONLINE  /oracle/oradata/extrabc5hml/redo04b.dbf                           NO
         5         ONLINE  /oracle/oradata/extrabc5hml/redo05a.dbf                           NO
         5         ONLINE  /oracle/oradata/extrabc5hml/redo05b.dbf                           NO
         6         ONLINE  /oracle/oradata/extrabc5hml/redo06a.dbf                           NO
         6         ONLINE  /oracle/oradata/extrabc5hml/redo06b.dbf                           NO
         7         ONLINE  /oracle/oradata/extrabc5hml/redo07a.dbf                           NO
         7         ONLINE  /oracle/oradata/extrabc5hml/redo07b.dbf                           NO
         8         ONLINE  /oracle/oradata/extrabc5hml/redo08a.dbf                           NO
         8         ONLINE  /oracle/oradata/extrabc5hml/redo08b.dbf                           NO
         9         ONLINE  /oracle/oradata/extrabc5hml/redo09a.dbf                           NO
         9         ONLINE  /oracle/oradata/extrabc5hml/redo09b.dbf                           NO
        10         ONLINE  /oracle/oradata/extrabc5hml/redo10a.dbf                           NO
        10         ONLINE  /oracle/oradata/extrabc5hml/redo10b.dbf                           NO
        11         ONLINE  /oracle/oradata/extrabc5hml/redo11a.dbf                           NO
        11         ONLINE  /oracle/oradata/extrabc5hml/redo11b.dbf                           NO
        12         ONLINE  /oracle/oradata/extrabc5hml/redo12a.dbf                           NO
        12         ONLINE  /oracle/oradata/extrabc5hml/redo12b.dbf                           NO
        13         ONLINE  /oracle/oradata/extrabc5hml/redo13a.dbf                           NO
        13         ONLINE  /oracle/oradata/extrabc5hml/redo13b.dbf                           NO
        14         ONLINE  /oracle/oradata/extrabc5hml/redo14a.dbf                           NO
        14         ONLINE  /oracle/oradata/extrabc5hml/redo14b.dbf                           NO
        15         ONLINE  /oracle/oradata/extrabc5hml/redo15a.dbf                           NO
        15         ONLINE  /oracle/oradata/extrabc5hml/redo15b.dbf                           NO
        16         ONLINE  /oracle/oradata/extrabc5hml/redo16a.dbf                           NO
        16         ONLINE  /oracle/oradata/extrabc5hml/redo16b.dbf                           NO
        17         ONLINE  /oracle/oradata/extrabc5hml/redo17a.dbf                           NO
        17         ONLINE  /oracle/oradata/extrabc5hml/redo17b.dbf                           NO
        18         ONLINE  /oracle/oradata/extrabc5hml/redo18a.dbf                           NO
        18         ONLINE  /oracle/oradata/extrabc5hml/redo18b.dbf                           NO
        19         ONLINE  /oracle/oradata/extrabc5hml/redo19a.dbf                           NO
        19         ONLINE  /oracle/oradata/extrabc5hml/redo19b.dbf                           NO
        20         ONLINE  /oracle/oradata/extrabc5hml/redo20a.dbf                           NO
        20         ONLINE  /oracle/oradata/extrabc5hml/redo20b.dbf                           NO
        21         ONLINE  /oracle/oradata/extrabc5hml/redo21a.dbf                           NO
        21         ONLINE  /oracle/oradata/extrabc5hml/redo21b.dbf                           NO
        22         ONLINE  /oracle/oradata/extrabc5hml/redo22a.dbf                           NO
        22         ONLINE  /oracle/oradata/extrabc5hml/redo22b.dbf                           NO
        23         ONLINE  /oracle/oradata/extrabc5hml/redo23a.dbf                           NO
        23         ONLINE  /oracle/oradata/extrabc5hml/redo23b.dbf                           NO
        24         ONLINE  /oracle/oradata/extrabc5hml/redo24a.dbf                           NO
        24         ONLINE  /oracle/oradata/extrabc5hml/redo24b.dbf                           NO



SET DBID=225413891;

set decryption identified by "#Ruop19023@#!" ;

run {   
        ALLOCATE channel t1 DEVICE TYPE SBT PARMS='SBT_LIBRARY=/oracle/opc_extrabc5/refresh_bc5/lib/libopc.so ENV=(OPC_PFILE=/oracle/opc_extrabc5/refresh_bc5/opcORCL.ora)' ;
		RESTORE CONTROLFILE FROM AUTOBACKUP maxdays 1;
	}


nohup rman target / restore_backup.sh >> restore_extrabom07022022.log &




---- BKP Disco Kiprev modificavel para standby ou não, somente tirar opção de standby
run
{
allocate channel c1 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c2 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c3 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c4 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c5 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c6 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c7 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c8 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c9 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c10 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c11 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c12 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c13 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c14 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c15 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c16 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c17 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c18 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c19 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c20 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
backup as compressed backupset incremental level 0 database format '/backup_acfs/bkp_kpvprd_dr/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_KPV_STBY
current controlfile for standby format '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rmam' tag BKP_CONTROLFILE_KPV_KPV_STBY
spfile format '/backup_acfs/bkp_kpvprd_dr/BKP_SPFILE_%d_%u_%s_%T.rmam' tag BKP_SPFILE_KPV_KPV_STBY
plus archivelog format '/backup_acfs/bkp_kpvprd_dr/BKP_ARCH_%d_%u_%s_%T.rmam' tag BKP_ARCH_KPV_STBY;
}


backup as compressed backupset incremental level 0 database format '/backup_acfs/bkp_kpvprd_dr/BKP_FULL_%d_%u_%s_%T.rman' plus archivelog tag BKP_FULL_KPV;
BACKUP FORMAT '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE FOR STANDBY
spfile format '/backup_acfs/bkp_kpvprd_dr/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_KPV;

sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE for standby;
backup as compressed backupset incremental level 0 database format '/backup_acfs/bkp_kpvprd_dr/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_KPV;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE for standby
spfile format '/backup_acfs/bkp_kpvprd_dr/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_KPV
plus archivelog format '/backup_acfs/bkp_kpvprd_dr/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_KPV;


-- testar no ambiente de DEV antes do restore
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
    set DBID=3325602173
    set archivelog destination to '/u04';
    restore archivelog logseq=109759 thread 1;
    release channel c1;
} 

## teste restore arch para DEV
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
    restore controlfile to '/u04/' from '/ctrl_dORAKPVHM_unq3aic6e_s8954_p1_t1185493198';
    release channel c1;
} 

rman target / catalog CVP_KPV_HML/OraCvpHml123456#@DBRMAN
