[24/10/14 - 19:59:09]: Running Script <Arch_All.sh> Using Version 0.2.0.0
# Starting Script at: Fri Oct 24 19:59:09 BRST 2014
Script Name       : /opt/ScriptsNBU/rman/Arch_All.sh
RMAN_LOG_FILE     : /opt/ScriptsNBU/rman/Logs/Arch_All-eladb05g.gtservicos.20141024-19h59.out
NB_ORA_SERV       : d1-netbackup21.gtservicos
NB_ORA_FULL       : 1
NB_ORA_INCR       : 0
NB_ORA_CINC       : 0
NB_ORA_CLASS      : GT_SHA_D_OR_ARC_DIA_08_00
NB_ORA_POLICY     : GT_SHA_D_OR_ARC_DIA_08_00
NB_ORA_SCHED      :
NB_ORA_PC_SCHED   : Arch
NB_ORA_CLIENT     : eladb05g.gtservicos
Backup Type       : Full backup requested
Backup Level      : 0
Starting Backup of: ELADBG1

+ORADATA/eladbg/control01.ctl
+ORAFLASH/eladbg/control02.ctl
+ORAINDX/eladbg/control03.ctl




export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=ELADBG
rman target /

startup force nomount;

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00';
restore controlfile to '/u02/oradata/ELADBG/controlfile/control01.ctl' from 'c-2276415563-20141019-00';
release channel c1;
}



alter database mount;
crosscheck archivelog all;
delete expired archivelog all; 

startup mount;


#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=ELADBG
rman target / log=/home/oracle/restore_tape_ELADBG.log

run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00';
SET NEWNAME FOR DATAFILE 1 to '+ORADATA/eladbg/datafile/system.278.816372191';
SET NEWNAME FOR DATAFILE 2 to '+ORADATA/eladbg/datafile/undotbs1.260.816355925';
SET NEWNAME FOR DATAFILE 3 to '+ORADATA/eladbg/datafile/sysaux.282.816355973';
SET NEWNAME FOR DATAFILE 4 to '+ORADATA/eladbg/datafile/undotbs2.279.816364539';
SET NEWNAME FOR DATAFILE 5 to '+ORADATA/eladbg/datafile/users.270.816363843';
SET NEWNAME FOR DATAFILE 6 to '+ORADATA/eladbg/datafile/elancers.256.816364491';
SET NEWNAME FOR DATAFILE 7 to '+ORADATA/eladbg/datafile/elancers.265.816355935';
SET NEWNAME FOR DATAFILE 8 to '+ORADATA/eladbg/datafile/elancers.259.816364501';
SET NEWNAME FOR DATAFILE 9 to '+ORADATA/eladbg/datafile/elancers_mviews.258.816364531';
SET NEWNAME FOR DATAFILE 10 to '+ORADATA/eladbg/datafile/elancers_xemp_data.275.816371441';
SET NEWNAME FOR DATAFILE 11 to '+ORADATA/eladbg/datafile/undotbs1.280.851102263';
SET NEWNAME FOR DATAFILE 14 to '+ORAINDX/eladbg/datafile/elancers_indx.259.816355953';
SET NEWNAME FOR DATAFILE 15 to '+ORAINDX/eladbg/datafile/elancers_indx.267.816364521';
SET NEWNAME FOR DATAFILE 16 to '+ORAINDX/eladbg/datafile/elancers_mviews_indx.274.816364375';
SET NEWNAME FOR DATAFILE 17 to '+ORAINDX/eladbg/datafile/elancers_xemp_indx.273.816361229';
SET NEWNAME FOR DATAFILE 20 to '+ORADATA/eladbg/datafile/elancers';
SET NEWNAME FOR DATAFILE 21 to '+ORAINDX/eladbg/datafile/elancers_indx.264.816355963';
SET NEWNAME FOR DATAFILE 22 to '+ORAINDX/eladbg/datafile/elancers_indx';
SET NEWNAME FOR DATAFILE 23 to '+ORAINDX/eladbg/datafile/elancers_indx.256.816368753';
SET NEWNAME FOR DATAFILE 24 to '+ORAINDX/eladbg/datafile/elancers_indx.262.816359651';
SET NEWNAME FOR DATAFILE 25 to '+ORAINDX/eladbg/datafile/elancers_indx.263.816368465';
SET NEWNAME FOR DATAFILE 26 to '+ORAINDX/eladbg/datafile/elancers_indx.261.816364547';
SET NEWNAME FOR DATAFILE 27 to '+ORADATA/eladbg/datafile/elancers.277.816362921';
SET NEWNAME FOR DATAFILE 28 to '+ORADATA/eladbg/datafile/elancers_mviews.266.816364551';
SET NEWNAME FOR DATAFILE 29 to '+ORADATA/eladbg/datafile/sysaux.274.816355979';
SET NEWNAME FOR DATAFILE 30 to '+ORADATA/eladbg/datafile/elancers.281.816361435';
SET NEWNAME FOR DATAFILE 31 to '+ORADATA/eladbg/datafile/elancers.271.816364511';
SET NEWNAME FOR DATAFILE 32 to '+ORADATA/eladbg/datafile/elancers.257.816363885';
SET NEWNAME FOR DATAFILE 33 to '+ORADATA/eladbg/datafile/tbs_staspack.273.817495539';
SET NEWNAME FOR DATAFILE 34 to '+ORADATA/eladbg/datafile/tbs_uolqa.267.818701087';
SET NEWNAME FOR DATAFILE 35 to '+ORADATA/eladbg/datafile/ela_logmv.283.821447863';
SET NEWNAME FOR DATAFILE 36 to '+ORADATA/eladbg/datafile/elancers.299.840566485';
SET NEWNAME FOR DATAFILE 37 to '+ORADATA/eladbg/datafile/elancers.268.845028293';
SET NEWNAME FOR DATAFILE 38 to '+ORADATA/eladbg/datafile/elancers.272.847669837';
SET NEWNAME FOR DATAFILE 39 to '+ORADATA/eladbg/datafile/elancers.269.849477043';
SET NEWNAME FOR TEMPFILE 4 to '+ORADATA/eladbg/tempfile/temp.300.844881967';
SET NEWNAME FOR TEMPFILE 5 to '+ORADATA/eladbg/tempfile/temp.301.844882039';
set until time "to_date('19-10-2014 23:00:00','dd-mm-yyyy hh24:mi:ss')";
restore database SKIP TABLESPACE USERS,ELANCERS_MVIEWS,ELANCERS_XEMP_DATA,ELANCERS_INDX,ELANCERS_MVIEWS_INDX,ELANCERS_XEMP_INDX,TBS_STASPACK,TBS_UOLQA,ELA_LOGMV;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
}
exit


ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00';

run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'bkp_ELADBG_ELADBG1_46272_1_861495160';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'bkp_ELADBG_ELADBG1_46274_1_861495463';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'bkp_ELADBG_ELADBG1_46275_1_861495530';
}

run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'bkp_ELADBG_ELADBG1_46273_1_861495297';
}



Tentar com este do dia 26
run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'bkp_ELADBG_ELADBG1_46429_1_861929272';
}

***recover
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=ELADBG 
rman target / log=/home/oracle/recover_tape_ELADBG_ARCH.log
run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00';
set until time "to_date('19-10-2014 22:00:00','dd-mm-yyyy hh24:mi:ss')";
recover database SKIP TABLESPACE USERS,ELANCERS_MVIEWS,ELANCERS_XEMP_DATA,ELANCERS_INDX,ELANCERS_MVIEWS_INDX,ELANCERS_XEMP_INDX,TBS_STASPACK,TBS_UOLQA,ELA_LOGMV;
release channel c1;
}





SELECT * FROM V$LOGFILE ORDER BY 1;

alter database rename file '+ORAFLASH/eladbg/onlinelog/group_1.445.816373217' to '/u02/oradata/ELADBG/group_1.445.816373217'; 
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_2.366.816373235' to '/u02/oradata/ELADBG/group_2.366.816373235';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_3.370.816373255' to '/u02/oradata/ELADBG/group_3.370.816373255';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_4.427.816373275' to '/u02/oradata/ELADBG/group_4.427.816373275';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_11.494.816373371' to '/u02/oradata/ELADBG/group_11.494.816373371';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_5.353.816373291' to '/u02/oradata/ELADBG/group_5.353.816373291';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_12.326.816373427' to '/u02/oradata/ELADBG/group_12.326.816373427';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_6.488.816373307' to '/u02/oradata/ELADBG/group_6.488.816373307';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_13.336.816373453' to '/u02/oradata/ELADBG/group_13.336.816373453';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_14.324.816373475' to '/u02/oradata/ELADBG/group_14.324.816373475';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_15.337.816373495' to '/u02/oradata/ELADBG/group_15.337.816373495';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_16.331.816373519' to '/u02/oradata/ELADBG/group_16.331.816373519';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_7.490.816373323' to '/u02/oradata/ELADBG/group_7.490.816373323';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_8.333.816373339' to '/u02/oradata/ELADBG/group_8.333.816373339';
alter database rename file '+ORAFLASH/eladbg/onlinelog/group_17.281.816373537' to '/u02/oradata/ELADBG/group_17.281.816373537';
alter database rename file '+ORADATA/eladbg/onlinelog/group_1.284.826148047'  to '/u02/oradata/ELADBG/group_1.284.826148047';
alter database rename file '+ORADATA/eladbg/onlinelog/group_2.285.826148077'  to '/u02/oradata/ELADBG/group_2.285.826148077';
alter database rename file '+ORADATA/eladbg/onlinelog/group_3.286.826148093'  to '/u02/oradata/ELADBG/group_3.286.826148093';
alter database rename file '+ORADATA/eladbg/onlinelog/group_4.287.826148109'  to '/u02/oradata/ELADBG/group_4.287.826148109';
alter database rename file '+ORADATA/eladbg/onlinelog/group_5.288.826148123'  to '/u02/oradata/ELADBG/group_5.288.826148123';
alter database rename file '+ORADATA/eladbg/onlinelog/group_6.289.826148137'  to '/u02/oradata/ELADBG/group_6.289.826148137';
alter database rename file '+ORADATA/eladbg/onlinelog/group_7.290.826148151'  to '/u02/oradata/ELADBG/group_7.290.826148151';
alter database rename file '+ORADATA/eladbg/onlinelog/group_8.291.826148165'  to '/u02/oradata/ELADBG/group_8.291.826148165';
alter database rename file '+ORADATA/eladbg/onlinelog/group_11.292.826148177' to '/u02/oradata/ELADBG/group_11.292.826148177';
alter database rename file '+ORADATA/eladbg/onlinelog/group_12.293.826148191' to '/u02/oradata/ELADBG/group_12.293.826148191';
alter database rename file '+ORADATA/eladbg/onlinelog/group_13.294.826148203' to '/u02/oradata/ELADBG/group_13.294.826148203';
alter database rename file '+ORADATA/eladbg/onlinelog/group_14.295.826148219' to '/u02/oradata/ELADBG/group_14.295.826148219';
alter database rename file '+ORADATA/eladbg/onlinelog/group_15.296.826148231' to '/u02/oradata/ELADBG/group_15.296.826148231';
alter database rename file '+ORADATA/eladbg/onlinelog/group_16.297.826148249' to '/u02/oradata/ELADBG/group_16.297.826148249';
alter database rename file '+ORADATA/eladbg/onlinelog/group_17.298.826148263' to '/u02/oradata/ELADBG/group_17.298.826148263';





RECOVER DATABASE SKIP TABLESPACE us

SQL> select tablespace_name from dba_tablespaces;

TABLESPACE_NAME
------------------------------
SELECT SUM(BYTES/1024/1024/1024) FROM DBA_DATA_FILES WHERE TABLESPACE_NAME IN ('SYSTEM','UNDOTBS1','SYSAUX','ELANCERS','UNDOTBS1')

RECOVER DATABASE SKIP TABLESPACE us

SQL> select tablespace_name from dba_tablespaces;

TABLESPACE_NAME
------------------------------
 SKIP TABLESPACE UNDOTBS2,USERS,ELANCERS_MVIEWS,ELANCERS_XEMP_DATA,ELANCERS_INDX,ELANCERS_MVIEWS_INDX,ELANCERS_XEMP_INDX,TBS_STASPACK,TBS_UOLQA,ELA_LOGMV
RECOVER DATABASE SKIP TABLESPACE UNDOTBS2,USERS,ELANCERS_MVIEWS,ELANCERS_XEMP_DATA,ELANCERS_INDX,ELANCERS_MVIEWS_INDX,ELANCERS_XEMP_INDX,TBS_STASPACK,TBS_UOLQA,ELA_LOGMV

15 rows selected.


select 'SET NEWNAME FOR DATAFILE '||FILE#||' to '|| chr(39) || name || chr(39)||';' from v$datafile where 'TS#' not in ('USERS','ELANCERS_MVIEWS','ELANCERS_XEMP_DATA','ELANCERS_INDX','ELANCERS_MVIEWS_INDX','ELANCERS_XEMP_INDX','TBS_STASPACK','TBS_UOLQA,ELA_LOGMV');

SET NEWNAME FOR DATAFILE 1 to '+ORADATA/eladbg/datafile/system.278.816372191';
SET NEWNAME FOR DATAFILE 2 to '+ORADATA/eladbg/datafile/undotbs1.260.816355925';
SET NEWNAME FOR DATAFILE 3 to '+ORADATA/eladbg/datafile/sysaux.282.816355973';
SET NEWNAME FOR DATAFILE 4 to '+ORADATA/eladbg/datafile/undotbs2.279.816364539';
SET NEWNAME FOR DATAFILE 5 to '+ORADATA/eladbg/datafile/users.270.816363843';
SET NEWNAME FOR DATAFILE 6 to '+ORADATA/eladbg/datafile/elancers.256.816364491';
SET NEWNAME FOR DATAFILE 7 to '+ORADATA/eladbg/datafile/elancers.265.816355935';
SET NEWNAME FOR DATAFILE 8 to '+ORADATA/eladbg/datafile/elancers.259.816364501';
SET NEWNAME FOR DATAFILE 9 to '+ORADATA/eladbg/datafile/elancers_mviews.258.816364531';
SET NEWNAME FOR DATAFILE 10 to '+ORADATA/eladbg/datafile/elancers_xemp_data.275.816371441';
SET NEWNAME FOR DATAFILE 11 to '+ORADATA/eladbg/datafile/undotbs1.280.851102263';
SET NEWNAME FOR DATAFILE 14 to '+ORAINDX/eladbg/datafile/elancers_indx.259.816355953';
SET NEWNAME FOR DATAFILE 15 to '+ORAINDX/eladbg/datafile/elancers_indx.267.816364521';
SET NEWNAME FOR DATAFILE 16 to '+ORAINDX/eladbg/datafile/elancers_mviews_indx.274.816364375';
SET NEWNAME FOR DATAFILE 17 to '+ORAINDX/eladbg/datafile/elancers_xemp_indx.273.816361229';
SET NEWNAME FOR DATAFILE 20 to '+ORADATA/eladbg/datafile/elancers';
SET NEWNAME FOR DATAFILE 21 to '+ORAINDX/eladbg/datafile/elancers_indx.264.816355963';
SET NEWNAME FOR DATAFILE 22 to '+ORAINDX/eladbg/datafile/elancers_indx';
SET NEWNAME FOR DATAFILE 23 to '+ORAINDX/eladbg/datafile/elancers_indx.256.816368753';
SET NEWNAME FOR DATAFILE 24 to '+ORAINDX/eladbg/datafile/elancers_indx.262.816359651';
SET NEWNAME FOR DATAFILE 25 to '+ORAINDX/eladbg/datafile/elancers_indx.263.816368465';
SET NEWNAME FOR DATAFILE 26 to '+ORAINDX/eladbg/datafile/elancers_indx.261.816364547';
SET NEWNAME FOR DATAFILE 27 to '+ORADATA/eladbg/datafile/elancers.277.816362921';
SET NEWNAME FOR DATAFILE 28 to '+ORADATA/eladbg/datafile/elancers_mviews.266.816364551';
SET NEWNAME FOR DATAFILE 29 to '+ORADATA/eladbg/datafile/sysaux.274.816355979';
SET NEWNAME FOR DATAFILE 30 to '+ORADATA/eladbg/datafile/elancers.281.816361435';
SET NEWNAME FOR DATAFILE 31 to '+ORADATA/eladbg/datafile/elancers.271.816364511';
SET NEWNAME FOR DATAFILE 32 to '+ORADATA/eladbg/datafile/elancers.257.816363885';
SET NEWNAME FOR DATAFILE 33 to '+ORADATA/eladbg/datafile/tbs_staspack.273.817495539';
SET NEWNAME FOR DATAFILE 34 to '+ORADATA/eladbg/datafile/tbs_uolqa.267.818701087';
SET NEWNAME FOR DATAFILE 35 to '+ORADATA/eladbg/datafile/ela_logmv.283.821447863';
SET NEWNAME FOR DATAFILE 36 to '+ORADATA/eladbg/datafile/elancers.299.840566485';
SET NEWNAME FOR DATAFILE 37 to '+ORADATA/eladbg/datafile/elancers.268.845028293';
SET NEWNAME FOR DATAFILE 38 to '+ORADATA/eladbg/datafile/elancers.272.847669837';
SET NEWNAME FOR DATAFILE 39 to '+ORADATA/eladbg/datafile/elancers.269.849477043';








15 rows selected.







dcamin
dhc!@#

su -
Excelencia@2012