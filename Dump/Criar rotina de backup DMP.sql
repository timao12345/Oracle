---- rotina de backup DMP siagri


-- destino dos backups.
\\SIAG-AGROCP-WEB\Backup
\\10.101.112.220\Backup

-- criar usuario no banco pra executar caso seja necessário
create user SKY_BKP identified by SKY_BKPSKY_BKP01;

grant connect to SKY_BKP;
grant resource to SKY_BKP;
grant DBA to SKY_BKP;

-- Criar directorie.
create or replace directory DMPNOITE AS '/u01/dump/agrocp-ORCL/'

-- criar script .sh

expdp  '"/ as sysdba@ORCLP"' directory=DMPNOITE dumpfile=dmpnoite_agrocp.dmp logfile=log_dmp_agrocp.log full=Y

-- ou criar parfile
directory=DMPNOITE 
dumpfile=dmpnoite_agrocp.dmp 
logfile=log_dmp_agrocp.log
exclude=STATISTICS
full=Y

-- local dos scripts e dump
scripts se encontram em /u01/dump/scripts/backup_dmp.sh 

DUMP serão gerados em /u01/dump/agrocp-ORCL/

-- chamar o parfile
expdp / as sysdba@ORCLP parfile='/u01/dump/scripts/dmp_agrocp.par';

-- arquivo .sh
#!/bin/bash
export ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/dbhome_1
export ORACLE_BASE=/u01/app/oracle
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export ORACLE_SID=ORCL

find /u02/export -name "*.dmp" -mtime +1 -delete

expdp SKY_BKP/SKY_BKPSKY_BKP01@PDB1 directory=DMPNOITE dumpfile=dmpnoite_agrocp.dmp logfile=log_dmp_agrocp.log exclude=STATISTICS full=Y 

-- colocar o script na crontab

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed


#min #hour #DM #M #DW #ExecUser #command
00   22  *   *   *   oracle  /home/oracle/scripts/backup_full_ECT.sh




05   23  *   *   6   oracle /home/oracle/dba/scripts/rman_backup.sh -i SDJ -t BACKUP_MAINTENANCE
10   23  *   *   6   oracle /home/oracle/dba/scripts/rman_backup.sh -i LDT -t BACKUP_MAINTENANCE
15   23  *   *   6   oracle /home/oracle/dba/scripts/rman_backup.sh -i PDO -t BACKUP_MAINTENANCE
20   23  *   *   6   oracle /home/oracle/dba/scripts/rman_backup.sh -i EDC -t BACKUP_MAINTENANCE
25   23  *   *   6   oracle /home/oracle/dba/scripts/rman_backup.sh -i PDS -t BACKUP_MAINTENANCE