SOP e RHP - eu devo fazer

-- ## Substituir o caminha para o local do seu arquivo.

Exemplo no doc  ' /mnt/bkpnfs/cloudbkp/RHP/gap'  deve ser substituido para o seu caminho  exemplo : '/mnt/bkpnfs/jonas_bkp/'


1. On the standby database, stop the managed recovery process (MRP):


SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
 

2. On the standby database, find the SCN which will be used for the incremental
backup at the primary database:


SELECT MIN(FIRST_NONLOGGED_SCN) FROM V$DATAFILE WHERE FIRST_NONLOGGED_SCN > 0;


3. In RMAN, connect to the primary database and create an incremental backup
from the SCN derived in the previous step:

 
Certificar-se de que o parametro de encrypt esteja off:


CONFIGURE ENCRYPTION FOR DATABASE OFF;


Criar script o /home/oracle/bkp_incremetal.sql

vi /home/oracle/bkp_incremetal_rhp.sql

run{
allocate channel dsk01 device type disk;
allocate channel dsk02 device type disk;
allocate channel dsk03 device type disk;
allocate channel dsk04 device type disk;
allocate channel dsk05 device type disk;
allocate channel dsk06 device type disk;
allocate channel dsk07 device type disk;
allocate channel dsk08 device type disk;
allocate channel dsk09 device type disk;
allocate channel dsk10 device type disk;
allocate channel dsk11 device type disk;
allocate channel dsk12 device type disk;
allocate channel dsk13 device type disk;
allocate channel dsk14 device type disk;
allocate channel dsk15 device type disk;
allocate channel dsk16 device type disk;
BACKUP INCREMENTAL FROM SCN 62461364724
DATABASE FORMAT '/mnt/bkpnfs/cloudbkp/RHP/gap/ForStandby_%U' tag 'FORSTANDBY';
}


Executar o processo em segundo plano.

nohup rman target / cmdfile=/home/oracle/bkp_incremental_rhp.sql  msglog=/home/oracle/bkp_incremental_rhp.log &

See Also: Oracle Database Backup and Recovery Advanced 'User's Guide
for more information about RMAN incremental backups


4. Transfer all backup sets created on the primary system to the standby system (note
that there may be more than one backup file created). For example:
SCP /tmp/ForStandby_* standby:/tmp

 

5. Connect to the standby database as the RMAN target, and catalog all incremental
backup pieces:

 
RMAN> CATALOG START WITH '/mnt/bkpnfs/cloudbkp/RHP/gap/ForStandby';
 

6. Recover the standby database with the cataloged incremental backup:

 
run{
allocate channel dsk01 device type disk;
allocate channel dsk02 device type disk;
allocate channel dsk03 device type disk;
allocate channel dsk04 device type disk;
allocate channel dsk05 device type disk;
allocate channel dsk06 device type disk;
allocate channel dsk07 device type disk;
allocate channel dsk08 device type disk;
RECOVER DATABASE NOREDO;}

 


7. In RMAN, connect to the primary database and create a standby control file
backup:




RUN {
allocate channel dsk01 device type disk;
allocate channel dsk02 device type disk;
allocate channel dsk03 device type disk;
allocate channel dsk04 device type disk;
allocate channel dsk05 device type disk;
allocate channel dsk06 device type disk;
allocate channel dsk07 device type disk;
allocate channel dsk08 device type disk;
BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/backup_acfs_sap/POP/ctrl_pop.bkp';
}

 

8. Copy the standby control file backup to the standby system. For example:
SCP /tmp/ForStandbyCTRL.bck standby:/tmp

 

9. Shut down the standby database and startup nomount:


RMAN> SHUTDOWN;
RMAN> STARTUP NOMOUNT;



10. In RMAN, connect to standby database and restore the standby control file:

 

RMAN> RESTORE STANDBY CONTROLFILE FROM '/mnt/bkpnfs/cloudbkp/RHP/gap/ForStandbyCTRL.bck';

 

11. Shut down the standby database and startup mount:

 

RMAN> SHUTDOWN;
RMAN> STARTUP MOUNT;

 



12. If the primary and standby database data file directories are different, then in
RMAN, connect to the standby database, catalog the standby data files, and switch
the standby database to use the just-cataloged data files. For example:

 

RMAN> CATALOG START WITH '+DATAC1/RHP_iad3jj/DATAFILE/';
RMAN> SWITCH DATABASE TO COPY;

 

13 - no Standby ajustar o parametro LOG_FILE_NAME_CONVERT para corrigir o local do grupo de redo.


For example, LOG_FILE_NAME_CONVERT='+DISGROUP_NAME/DB_UNIQUE_NAME_PRODUCAO/REDO/','+DISGROUP_NAME/DB_UNIQUE_NAME_STB/REDO/'.



outro exemplo abaixo.

alter system set LOG_FILE_NAME_CONVERT='+DATAC1/RHP_gru1q6/ONLINELOG/','+DATAC1/RHP_iad3jj/ONLINELOG/' scope=spfile sid='*';


14. On the standby database, clear all standby redo log groups (there may be more than 3):

select group#, member from v$logfile where type = 'STANDBY';
       101
+DATAC1/sjp_iad3zw/onlinelog/group_101.1453.1070302503
 
       102
+DATAC1/sjp_iad3zw/onlinelog/group_102.1454.1070302505
 
       103
+DATAC1/sjp_iad3zw/onlinelog/group_103.1455.1070302505
 
       104
+DATAC1/sjp_iad3zw/onlinelog/group_104.1456.1070302505
 
       105
+DATAC1/sjp_iad3zw/onlinelog/group_105.1457.1070302505
 
       106
+DATAC1/sjp_iad3zw/onlinelog/group_106.1458.1070302505


 ALTER DATABASE CLEAR LOGFILE GROUP 101;
 ALTER DATABASE CLEAR LOGFILE GROUP 102;
 ALTER DATABASE CLEAR LOGFILE GROUP 103;
 ALTER DATABASE CLEAR LOGFILE GROUP 104;
 ALTER DATABASE CLEAR LOGFILE GROUP 105;
 ALTER DATABASE CLEAR LOGFILE GROUP 106;
 

15. On the standby database, restart MRP:

SQL> ALTER DATABASE RECOVER MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT FROM SESSION;