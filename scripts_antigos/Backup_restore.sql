[dbtb775anew oracle@matera1]/replicacao/scripts> cat backup_MATERA.sh

-- Backup

#!/bin/bash
export ORACLE_SID=matera1
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI

rman target / <<EOF >> /replicacao/MATERA/backupfull_matera.log 2>&1

run{
allocate channel c1 device type disk format '/replicacao/MATERA/%d_%I_%p_%s.bkp';
sql 'alter system archive log current';
backup as compressed backupset database plus archivelog;
backup current controlfile  format '/replicacao/MATERA/controlfile_%u.bkp';
}

exit
EOF

-- Restore

#!/bin/bash
export ORACLE_SID=change
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI

rman target / <<EOF >> /replicacao/restore/CHANGE/restore_change.log 2>&1

run{
catalog start with '/replicacao/restore/CHANGE/' noprompt;
restore database;
recover database;
}

exit
EOF
