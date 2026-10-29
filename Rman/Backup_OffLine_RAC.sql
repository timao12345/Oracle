/opt/scripts/backup_uol_full_offline-GemcoHO.sh GEMCOHO1 GEMCOHO 


vi backup_uol_full_offline-newrnet.sh


#!/bin/ksh
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.3/oradev
export ORACLE_SID=newrnet1
START_DATE=$(date +"%d.%m.%Y")
START_TIME=$(date +"%H.%M")
export LOG=/opt/scripts/logs/bkp_DATABASE_"$START_DATE"_"$START_TIME"_"${ORACLE_SID}".log
export PATH=$(echo "$PATH:$ORACLE_HOME/bin")
export DATABASE_NAME=NEWRNET


# LIMPAR ARQUIVOS MAIOR QUE 15 DIAS
##/usr/bin/find /backup/LOGS/ -noleaf -name "bkp_DATABASE*" -mtime +15 | xargs /bin/rm -f

# STOP/START Instance para bkp offline
/u01/app/11.2.0.3/grid/bin/srvctl stop instance -d $DATABASE_NAME -i newrnet1
/u01/app/11.2.0.3/grid/bin/srvctl start instance -d $DATABASE_NAME -i newrnet1 -o mount

#RMAN
rman target / msglog $LOG << EOF
run
{
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
allocate channel c11 device type disk;
allocate channel c12 device type disk;
allocate channel c13 device type disk;
allocate channel c14 device type disk;
allocate channel c15 device type disk;
allocate channel c16 device type disk;
allocate channel c17 device type disk;
allocate channel c18 device type disk;
allocate channel c19 device type disk;
allocate channel c20 device type disk;
backup spfile format '/backup/GEMCOHOM/NEWRNET/sp_file_%d_s%s_p%p_t%t';
backup as compressed backupset section size 106453M database format='/backup/GEMCOHOM/NEWRNET/DATABASE_%d_s%s_p%p_t%t';
backup current controlfile format '/backup/GEMCOHOM/NEWRNET/CONTROL_FILE_%U';
release channel c1;
release channel c2;
release channel c3;
release channel c4;
release channel c5;
release channel c6;
release channel c7;
release channel c8;
release channel c9;
release channel c10;
release channel c11;
release channel c12;
release channel c13;
release channel c14;
release channel c15;
release channel c16;
release channel c17;
release channel c18;
release channel c19;
release channel c20;
}


exit;
EOF

#Start Instance
/u01/app/11.2.0.3/grid/bin/srvctl stop instance -d $DATABASE_NAME -i newrnet1
/u01/app/11.2.0.3/grid/bin/srvctl start instance -d $DATABASE_NAME -i newrnet1


