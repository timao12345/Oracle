-- Recuperando StandBy Faltando ArchiveLog
-- Na Instancia STANDBY:
-- Verificar qual o SCN Atual
select to_char (min (d.CURRENT_SCN)) from V$DATABASE d
  union
select to_char (max (d.CURRENT_SCN)) from V$DATABASE d
  union
select to_char (min (h.CHECKPOINT_CHANGE#)) from V$DATAFILE_HEADER h
  union
select to_char (max (h.CHECKPOINT_CHANGE#)) from V$DATAFILE_HEADER h
  union
select to_char (min (f.CHECKPOINT_CHANGE#)) from V$DATAFILE f
  union
select to_char (max (f.CHECKPOINT_CHANGE#)) from V$DATAFILE f ;

-- ou somente
select current_scn from v$database;

-- Na Instancia PRODUCAO:
-- Criar um Backup Incremental em um Diretorio Vazio
-- Criar um ControlFile para StandBy
-- Copiar os Arquivos para o Servidor StandBy
mkdir -p /oracle/temp/incremental ;

rman nocatalog target /

backup device type disk incremental from SCN 616394489853
        database format '/oracle/temp/incremental/bkpincscn_%U' ;

sql "alter database create standby controlfile as ''/oracle/temp/incremental/ctrlstby-new.ctl''" ;

-- ou 
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
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
backup device type disk incremental from SCN 616394489853 database format '/backup_acfs/bkp_kpvprd_dr/bkpincscn_%U' ;
}

backup device type disk current controlfile for standby format '/backup_acfs/bkp_kpvprd_dr/ForStandbyControl.bkp' ;




backup as compressed backupset incremental level 0 from SCN 616394489853 
database format '/backup_acfs/bkp_kpvprd_dr/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_KPV;


backup as compressed backupset incremental from scn 616394489853 database format '/oracle/temp/incremental/bkpincscn_%U.bkp';

-- Passar arquivos para o servidor do STANDBY
-- Na Instancia STANDBY:
-- Catalogar os Backups Incrementais

rman nocatalog target /

SHUTDOWN IMMEDIATE;
STARTUP NOMOUNT;

-- Verificar local do controlfile
show parameter control_files

NAME            TYPE    VALUE
control_files string /u01/oradata/standby_cntfile.ctl

-- copiar o novo controlfile para o local do antigo no standby
cp /u01/oraback/ctrlstby-new.ctl /u01/oradata/standby_cntfile.ctl

--subir o Banco e mount
alter database mount;
alter database mount standby database;

-- catalogar os backups
catalog start with '/oracle/temp/incremental';


-- iniciar o recover
RECOVER DATABASE NOREDO;
SHUTDOWN IMMEDIATE;

-- Apagar os Backups Incrementais e Fazer o CROSSCHECK
-- Subir o MRP novamente
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT;




export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'


run{
allocate channel c1 device type disk;
allocate channel c2 device type disk;
allocate channel c3 device type disk;
allocate channel c4 device type disk;
allocate channel c5 device type disk;
allocate channel c6 device type disk;
allocate channel c7 device type disk;
allocate channel c8 device type disk;
allocate channel c9 device type disk;
allocate channel c10 device type disk;
recover database;
}


run {
allocate channel c1 device type disk;
allocate channel c2 device type disk;
allocate channel c3 device type disk;
allocate channel c4 device type disk;
allocate channel c5 device type disk;
allocate channel c6 device type disk;
allocate channel c7 device type disk;
allocate channel c8 device type disk;
allocate channel c9 device type disk;
allocate channel c10 device type disk;
set until time "to_date('10/09/2024 15:00:00','dd/mm/yyyy hh24:mi:ss')";
recover database;
}
