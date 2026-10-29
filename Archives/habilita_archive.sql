
NAME      INSTANCE_NAME    OPEN_MODE            LOG_MODE
--------- ---------------- -------------------- ------------
MIDWPRD   midwprd1         READ WRITE           NOARCHIVELOG
MIDWPRD   midwprd2         READ WRITE           NOARCHIVELOG


SQL> archive log list;
Database log mode              No Archive Mode
Automatic archival             Disabled
Archive destination            USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     33771
Current log sequence           33772


alter system set log_archive_dest_1='LOCATION=+RECOC1 VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=KPVPRD' scope=spfile sid='*';
alter system set log_archive_format='%d_%I_%T_%s_%p'.arc scope=spfile;
alter system set db_recovery_file_dest_size=500G scope=spfile;

--alter system set cluster_database=false scope=spfile;

./srvctl stop database -d MIDWPRD


echo $ORACLE_SID
export ORACLE_SID=midwprd1

startup mount;

SQL> alter database archivelog;

Database altered.

alter system switch logfile;

valida o reco

./srvctl start database -d BPO1ORA



##########################################################################################################
Ok
select distinct NAME, i.INSTANCE_NAME, OPEN_MODE, LOG_MODE from gv$database, gv$instance i order by 2;

Ok
alter system set db_recovery_file_dest_size=500G scope=spfile sid='*';


1. The following steps need to be taken to enable archive logging in a RAC database environment:
-- shutdown immediate all database instances

$ srvctl stop database -d MIDWPRD

-- startup database in mount mode

$ srvctl start database -d MIDWPRD -o mount

-- enable archive logging

echo $ORACLE_SID
export ORACLE_SID=midwprd1

$ sqlplus / as sysdba

sql> alter database archivelog;

sql> exit;

-- stop database

$ srvctl stop database -d MIDWPRD

-- restart all database instances

$ srvctl start database -d MIDWPRD

-- verify archiving is enabled/disabled by means of:

sql> archive log list;




