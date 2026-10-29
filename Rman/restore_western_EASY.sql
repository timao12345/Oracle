***backup em produção
#!/bin/bash
export ORACLE_SID=EASY1
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /replicacao/EASY/backupfull_EASY1.log 2>&1
run{
allocate channel c1 device type disk format '/replicacao/EASY/%d_%I_%p_%s';
backup as compressed backupset database plus archivelog;
backup current controlfile  format '/replicacao/EASY/controlfile_atual.bkp';
}
exit
EOF

***backup em homologação
#!/bin/bash
export ORACLE_SID=EASY
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /oradata/bkp/EASY/hom/backupfull_EASY.log 2>&1
run{
allocate channel c1 device type disk format '/oradata/bkp/EASY/hom/%d_%I_%p_%s';
backup as compressed backupset database plus archivelog;
backup current controlfile  format '/oradata/bkp/EASY/hom/controlfile_atual.bkp';
}
exit
EOF


***TRANSFERENCIA DE ARQUIVOS
Utilize su máquina

***gerar setnewname na produção 
select 'SET NEWNAME FOR DATAFILE '||FILE#||' to '|| chr(39) || NAME || chr(39)||';' from v$datafile; 
select 'SET NEWNAME FOR TEMPFILE '||FILE#||' to '|| chr(39) || NAME || chr(39)||';' from v$tempfile; 




***restore
blackout nimsof 
shutdown immediate;
Limpar antigos datafiles+archives )  /oradata/flash_recovery_area
)
/oradata/flash_recovery_area


startup nomount;
restore controlfile from '/oradata/bkp/EASY/prod/controlfile_atual.bkp';
alter database mount;
crosscheck backup;
delete noprompt  expired backup;
crosscheck archivelog all;
delete noprompt expired archivelog all;
catalog start with '/oradata/bkp/EASY/prod' ;

#!/bin/bash
export ORACLE_SID=EASY
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /oradata/bkp/EASY/prod/restore_EASY.log 2>&1
run {
allocate channel c1 device type disk;
SET NEWNAME FOR DATAFILE 1 to '/oradata/EASY/EASY/system.349.833910503';
SET NEWNAME FOR DATAFILE 2 to '/oradata/EASY/EASY/sysaux.351.833910569';
SET NEWNAME FOR DATAFILE 3 to '/oradata/EASY/EASY/undotbs1.338.833910615';
SET NEWNAME FOR DATAFILE 4 to '/oradata/EASY/EASY/users.340.833910639';
SET NEWNAME FOR DATAFILE 5 to '/oradata/EASY/EASY/easyspedepc_data.362.833910613';
SET NEWNAME FOR DATAFILE 6 to '/oradata/EASY/EASY/easyspedepc_index.339.833910639';
SET NEWNAME FOR DATAFILE 7 to '/oradata/EASY/EASY/easyirpj_data.352.833910503';
SET NEWNAME FOR DATAFILE 8 to '/oradata/EASY/EASY/easyirpj_index.350.833910569';
SET NEWNAME FOR DATAFILE 9 to '/oradata/EASY/EASY/undotbs2.283.833911297';
SET NEWNAME FOR TEMPFILE 1 to '/oradata/EASY/EASY/tempfile/temp.336.833910909';
restore database;
SWITCH DATAFILE ALL;
SWITCH TEMPFILE ALL;
}

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



alter database rename file '+ORADATA/easy/onlinelog/group_1.341.833910899'  to '/oradata/EASY/EASY/redo1a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_1.261.833910901'  to '/oradata/EASY/EASY/redo1b.rdo';

alter database rename file '+ORAFRA/easy/onlinelog/group_2.286.833910903'  to '/oradata/EASY/EASY/redo2a.rdo';
alter database rename file '+ORADATA/easy/onlinelog/group_2.354.833910903'  to '/oradata/EASY/EASY/redo2b.rdo';

alter database rename file '+ORADATA/easy/onlinelog/group_3.355.833910905'  to '/oradata/EASY/EASY/redo3a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_3.290.833910905'  to '/oradata/EASY/EASY/redo3b.rdo';

alter database rename file '+ORADATA/easy/onlinelog/group_4.289.833911851'  to '/oradata/EASY/EASY/redo4a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_4.796.833912221'  to '/oradata/EASY/EASY/redo4b.rdo';

alter database rename file '+ORADATA/easy/onlinelog/group_5.342.833911867'  to '/oradata/EASY/EASY/redo5a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_5.304.833912235'  to '/oradata/EASY/EASY/redo5b.rdo';

alter database rename file '+ORADATA/easy/onlinelog/group_6.361.833911869'  to '/oradata/EASY/EASY/redo6a.rdo';
alter database rename file '+ORAFRA/easy/onlinelog/group_6.642.833912237'  to '/oradata/EASY/EASY/redo6b.rdo';



rman target /

#!/bin/bash
export ORACLE_SID=EASY
export NLS_DATE_FORMAT=DD/MM/YYYY-HH24:MI
rman target / <<EOF >> /oradata/bkp/EASY/prod/recover_EASY.log 2>&1
run {
allocate channel c1 device type disk;
recover database;
}



select * from v$recover_file;

alter database open resetlogs


alter user EASYSPEDEPC	 identified by "kZMh$3382";
alter user EASYSPEDEPC_USER identified by  "FzcH$3782";
alter user EASYIRPJ     identified by   "KsE8Y$23";
alter user EASYIRPJ_USER identified by "FLg%0356";

	

***acompanhamento
SELECT sid, serial#, opname, sofar, totalwork,
      round(sofar/totalwork*100,2) "% Complete", time_remaining
FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
  AND opname NOT LIKE 'RMAN: aggregate%'
  AND sofar <> totalwork
  AND totalwork != 0;

