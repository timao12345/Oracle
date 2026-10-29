RUN {

 Configure retention policy to redundancy 2;

 ALLOCATE CHANNEL ch00 TYPE DISK;

 ALLOCATE CHANNEL ch01 TYPE DISK;

 ALLOCATE CHANNEL ch02 TYPE DISK;

 ALLOCATE CHANNEL ch03 TYPE DISK;

 sql 'alter system archive log current';

 BACKUP FILESPERSET 10 FORMAT '/backup/rman/full/prodata/bkp_database_%d_%T_%t_%s.rman' DATABASE;

 BACKUP FORMAT '/backup/rman/full/prodata/bkp_spfile_%d_%T_%t_%s.rman' SPFILE;

 BACKUP FILESPERSET 30 FORMAT '/backup/rman/full/prodata/bkp_archive_%d_%T_%t_%s.rman' ARCHIVELOG ALL;

 BACKUP FORMAT '/backup/rman/full/prodata/bkp_ctrl_%d_%T_%t_%s.rman' CURRENT CONTROLFILE;

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
