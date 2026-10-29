[dbtb775anew oracle@matera1]/replicacao/scripts> cat backup_MATERA.sh

-- Backup

#!/bin/bash
export ORACLE_SID=matera1
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI

rman target / <<EOF >> /replicacao/MATERA/backupfull_matera.log 2>&1

run{
ALLOCATE CHANNEL ch1 TYPE disk format '/u02/backup/%d_%I_%p_%s.bkp' MAXPIECESIZE 100G;
sql 'alter system archive log current';
backup as compressed backupset database plus archivelog;
backup current controlfile  format '/dump/sinter-bkp/controlfile-%u';
RELEASE CHANNEL ch1;
}

exit
EOF



-- Restore

#!/bin/bash
export ORACLE_SID=change
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI

rman target / <<EOF >>/u02/backup/restore_change.log 2>&1

run{
catalog start with '/u02/backup' noprompt;
restore database;
recover database;
}

exit
EOF



run {
allocate channel c1 device type disk format '/dump/sinter-bkp/%u.bkp';
SET CONFIGURE CONTROLFILEAUTOBACKUP FORMAT FOR DEVICE TYPE 'DISK' TO '/dump/sinter-bkp/%u'   
backup current controlfile  format '/dump/sinter-bkp/controlfile-01.bkp';
release channel c1;
}


RUN{
  ALLOCATE CHANNEL ch1 TYPE DISK MAXPIECESIZE 10G;
  BACKUP  CURRENT CONTROLFILE  FORMAT '/dump/sinter-bkp/controlfile-%u.bkp'
  SPFILE  FORMAT '/dump/sinter-bkp/spfile-01.ora';
  RELEASE CHANNEL ch1;
}

backup current controlfile;