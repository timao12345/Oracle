vi /u01/app/oracle/OraBackup/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL.sh

[oracle@dm01db03 sianovo]$ cat /u01/app/oracle/OraBackup/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL.sh
#!/bin/bash
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/11.2.0.4/dbhome_1; export ORACLE_HOME
ORACLE_SID=SIANOVO; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH


rman target / nocatalog @/u01/app/oracle/OraBackup/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL.sql log /u01/app/oracle/OraBackup/logs/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL-$(date +%d%m%Y).log


vi /u01/app/oracle/OraBackup/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL.sql

[oracle@dm01db03 sianovo]$ cat /u01/app/oracle/OraBackup/SIANOVO_BKP_RMAN_FULL_DISCO_PARALLEL.sql
run {
sql 'alter session set optimizer_mode=all_rows';
sql 'alter system archive log current';
allocate channel backup_disk1 type disk;
allocate channel backup_disk2 type disk;
allocate channel backup_disk3 type disk;
allocate channel backup_disk4 type disk;
allocate channel backup_disk5 type disk;
allocate channel backup_disk6 type disk;
allocate channel backup_disk7 type disk;
allocate channel backup_disk8 type disk;
allocate channel backup_disk9 type disk;
allocate channel backup_disk10 type disk;
allocate channel backup_disk11 type disk;
allocate channel backup_disk12 type disk;
allocate channel backup_disk13 type disk;
allocate channel backup_disk14 type disk;
allocate channel backup_disk15 type disk;
backup tag 'SIANOVO' SPFILE format '/stage02/backups/sianovo/SIANOVO_BKP_SPFILE_t%t_s%s_p%p_T%T';
backup incremental level 0 as compressed backupset tag 'SIANOVO' database format '/stage02/backups/sianovo/SIANOVO_BKP_FULL_df_t%t_s%s_p%p_T%T';
backup as compressed backupset tag 'SIANOVO' archivelog all  format '/stage02/backups/sianovo/SIANOVO_BKP_arch_t%t_s%s_p%p_T%T' delete input;
backup current controlfile format '/stage02/backups/sianovo/SIANOVO_cf_%d_%t.bkp';
crosscheck backup device type disk;
crosscheck archivelog all device type disk;
crosscheck backupset;
crosscheck copy;
}


Pode ser usado o full invez do nivel 0 conforme abaixo

BACKUP AS COMPRESSED BACKUPSET DATABASE PLUS ARCHIVELOG;


startup nomount pfile='/u01/app/oracle/product/11.2.0.4/dbhome_1/dbs/initSIANOVO2.ora;

BACKUP AS COMPRESSED BACKUPSET DATABASE PLUS ARCHIVELOG;

backup as compressed backupset tag 'SIANOVO' database format '/u01/app/oracle/backup/SIANOVO_BKP_FULL_df_t%t_s%s_p%p_T%T';
