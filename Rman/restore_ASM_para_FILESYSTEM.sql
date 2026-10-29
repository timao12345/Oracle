***backup em produ��o
#!/bin/bash
export ORACLE_SID=ORCL
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /replicacao/EASY/backupfull_EASY1.log 2>&1
run{
allocate channel c1 device type disk format '/u01/backup/%d_%I_%p_%s';
backup as compressed backupset database plus archivelog;
backup current controlfile  format '/u01/backup/controlfile_atual.bkp';
}

-- Transferir os backups para o servidor destino.



***gerar setnewname na produ��o 
select 'SET NEWNAME FOR DATAFILE '||FILE#||' to '|| chr(39) || NAME || chr(39)||';' from v$datafile; 
select 'SET NEWNAME FOR TEMPFILE '||FILE#||' to '|| chr(39) || NAME || chr(39)||';' from v$tempfile; 

SET NEWNAME FOR DATAFILE 1 to '/u01/oradata/ORCL/system.257.1144435385';
SET NEWNAME FOR DATAFILE 3 to '/u01/oradata/ORCL/sysaux.258.1144435427';
SET NEWNAME FOR DATAFILE 4 to '/u01/oradata/ORCL/undotbs1.259.1144435451';
SET NEWNAME FOR DATAFILE 7 to '/u01/oradata/ORCL/users.260.1144435453';
SET NEWNAME FOR TEMPFILE 1 to '/u01/oradata/ORCL/temp.265.1144435521';

SET NEWNAME FOR TEMPFILE 3 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-3';
SET NEWNAME FOR TEMPFILE 4 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-4';
SET NEWNAME FOR TEMPFILE 5 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-5';
SET NEWNAME FOR TEMPFILE 6 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-6';
SET NEWNAME FOR TEMPFILE 7 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-7';
SET NEWNAME FOR TEMPFILE 8 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-8';
SET NEWNAME FOR TEMPFILE 9 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-9';
SET NEWNAME FOR TEMPFILE 10 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-10';
SET NEWNAME FOR TEMPFILE 11 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-11';
SET NEWNAME FOR TEMPFILE 12 to '+DATA_SDJ/SDJ/tempfile/data_D-SDJ_TS-PSAPTEMP_FNO-12';

--- Realizando start da instancia (com o FORCE se não tiver ainda spfile/pfile e for restaurar o spfile/pfile do bkp), e conectando no rman
export ORACLE_SID=ORCL
rman target /
startup nomount force;

-- Restaurar o spfile do backup do controlfile pois vai junto
restore spfile to pfile '/u01/app/oracle/product/19.0.0.0/dbhome_1/dbs/initORCL.ora' from '/backup_rman/restore/c-2622018584-20191111-00';

restore spfile to pfile '/bkp_sap_dev/Backup_Full_SDJ_19012025' from '/bkp_sap_dev/';


restore spfile to pfile '/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/pfileSDJ.ora' from '/bkp_sap_dev/Backup_Full_SDJ_19012025/BKP_SPFILE_SDJ_343fltfl_100_20250120.rmam';

-- ou criar um pfile a partir do spfile de prod e mandar para o servidor destino, somente terá que mudar os locais do filesyste
-- nesse caso foi copiado e ediatado um pfile manual, e apos o banco subir criado o spfile a partir do pfile.

-- Restaurar o controlfile a partir do backup feito em PROD
restore controlfile from '/u01/backup/controlfile_atual.bkp';
alter database mount;
crosscheck backup;
delete noprompt  expired backup;
crosscheck archivelog all;
delete noprompt expired archivelog all;

-- Catalogar o local aonde está os backups feitos de prod
catalog start with '/u01/backup/' ;

-- Fazer o restore, nesse caso veio de um ASM para filesystem por isso o set new name.
export ORACLE_SID=ORCL
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target /
run {
allocate channel c1 device type disk;
SET NEWNAME FOR DATAFILE 1 to '/u01/oradata/ORCL/system.257.1144435385';
SET NEWNAME FOR DATAFILE 3 to '/u01/oradata/ORCL/sysaux.258.1144435427';
SET NEWNAME FOR DATAFILE 4 to '/u01/oradata/ORCL/undotbs1.259.1144435451';
SET NEWNAME FOR DATAFILE 7 to '/u01/oradata/ORCL/users.260.1144435453';
SET NEWNAME FOR TEMPFILE 1 to '/u01/oradata/ORCL/temp.265.1144435521';
restore database;
SWITCH DATAFILE ALL;
SWITCH TEMPFILE ALL;
}

--Verifica os logfiles
SELECT * FROM V$LOGFILE ORDER BY 1;
      GROUP# STATUS  TYPE    MEMBER                                                       IS_
---------- ------- ------- ------------------------------------------------------------ ---
         1         ONLINE  +ORADATA/easy/onlinelog/group_1.341.833910899                NO
         1         ONLINE  +ORAFRA/easy/onlinelog/group_1.261.833910901                 NO
         2         ONLINE  +ORAFRA/easy/onlinelog/group_2.286.833910903                 NO
         2         ONLINE  +ORADATA/easy/onlinelog/group_2.354.833910903                NO
         3         ONLINE  +ORADATA/easy/onlinelog/group_3.355.833910905                NO
         3         ONLINE  +ORAFRA/easy/onlinelog/group_3.290.833910905                 NO
         4         ONLINE  +ORADATA/easy/onlinelog/group_4.289.833911851                NO
         4         ONLINE  +ORAFRA/easy/onlinelog/group_4.796.833912221                 NO
         5         ONLINE  +ORADATA/easy/onlinelog/group_5.342.833911867                NO
         5         ONLINE  +ORAFRA/easy/onlinelog/group_5.304.833912235                 NO
         6         ONLINE  +ORADATA/easy/onlinelog/group_6.361.833911869                NO
         6         ONLINE  +ORAFRA/easy/onlinelog/group_6.642.833912237                 NO

-- Fazer o rename dos logfiles
alter database rename file '+ORADATA/easy/onlinelog/group_1.341.833910899'  to '/oradata/EASY/EASY/redo1a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_1.261.833910901'  to '/oradata/EASY/EASY/redo1b.rdo';

alter database rename file '+DATA/ORCL/ONLINELOG/group_1.262.1144435499'  to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y2_.log';                  
alter database rename file '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y3_.log' to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y3_.log';  
alter database rename file '+DATA/ORCL/ONLINELOG/group_2.263.1144435499'  to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y4_.log';                       
alter database rename file '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_2_lf8271yy_.log' to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y5_.log';  
alter database rename file '+DATA/ORCL/ONLINELOG/group_3.264.1144435499' to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y6_.log';                      
alter database rename file '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_3_lf82720o_.log' to '/u01/app/oracle/recovery_area/ORCL/onlinelog/o1_mf_1_lf8271y7_.log';  

-- Agora fazer o recover;
rman target /

#!/bin/bash
export ORACLE_SID=EASY
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /oradata/bkp/EASY/prod/recover_EASY.log 2>&1
run {
allocate channel c1 device type disk;
recover database;
}


-- ## antes de fazer o open reset logs, mudar o parametro do db_create_file_dest para o novo local (deve estar com spfile correto ou mudar manualmente o pfile)
db_create_file_dest
alter system set db_create_file_dest='/u01/oradata/ORCL'
select * from v$recover_file;

alter database open resetlogs;