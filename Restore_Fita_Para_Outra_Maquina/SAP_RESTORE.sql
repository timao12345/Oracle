ECC001.__oracle_base='/u02/app/oracle'#ORACLE_BASE set from environment
ECC002.__oracle_base='/u02/app/oracle'#ORACLE_BASE set from environment
*._disable_directory_link_check=TRUE
*._fix_control='5099019:ON','6055658:OFF','6120483:OFF','6399597:ON','6430500:ON','6972291:ON','7324224:OFF','7658097:ON','8932139:ON','8937971:ON','9196440:ON','9495669:ON','13627489:ON','14255600:ON','14595273:ON','18405517:2','20355502:10','20636003:OFF','22387320:ON','22540411:ON','23738304:OFF','24561942:ON','25643889:ON','26536320:ON','27321179:ON','27466597:ON','28173995:ON','28234255:3','28414968:3','28498976:ON','28558645:ON','28602253:ON','28708585:ON','28835937:ON','28999046:ON','29302565:ON','29304314:ON','29385774:ON','29450812:ON','29487407:ON','29687220:ON','29867728:ON','29930457:ON','30008456:ON','30142527:ON','30195773:ON','30231086:ON','30235691:ON','30249927:ON','30470947:ON','30483217:ON','30537403:ON','30616738:OFF','30776676:ON','30786641:ON','31009032:ON','31082719:ON','31143146:ON','31444353:1','31496840:ON','31821701:ON','31961578:ON','32014520:ON','32107621:ON'#SAP_191200210720_202108 RECOMMENDED SETTINGS
*._kolfuseslf=TRUE
*._log_segment_dump_parameter=FALSE
*._log_segment_dump_patch=FALSE
*._mutex_wait_scheme=1
*._mutex_wait_time=10
*._optim_peek_user_binds=FALSE
*._optimizer_adaptive_cursor_sharing=FALSE
*._optimizer_batch_table_access_by_rowid=FALSE
*._optimizer_extended_cursor_sharing_rel='NONE'
*._optimizer_reduce_groupby_key=FALSE
*._optimizer_use_feedback=FALSE
*._rowsets_enabled=FALSE
*._securefiles_concurrency_estimate=50
*._suppress_identifiers_on_dupkey=TRUE
*._use_single_log_writer='TRUE'
*.audit_file_dest='/u02/ECQ/saptrace/audit'
*.cluster_database=TRUE
*.compatible='19.0.0.0.0'
*.control_file_record_keep_time=30
*.control_files='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/control_01.ctl','/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/control_02.ctl'#Restore Controlfile
*.db_block_size=8192
*.db_cache_size=8512M
*.db_files=2048
*.db_name='ECC'#Reset to original value by RMAN
#*.db_recovery_file_dest='+RECOC1'
#*.db_recovery_file_dest_size=3298534883328
#*.dg_broker_config_file1='+DATAC1/ECC/dgbrokECC1.dat'
#*.dg_broker_config_file2='+DATAC1/ECC/dgbrokECC2.dat'
#*.dg_broker_start=TRUE
*.diagnostic_dest='/u02/ECQ/saptrace'
*.event='10027','10028','10142','10183','10191','10995 level 2','38068 level 100','38085','38087','44951 level 1024','60025'#SAP_19500191015_201911 RECOMMENDED SETTINGS
*.fal_server=''
*.FILESYSTEMIO_OPTIONS='setall'
#ECC001.instance_name='ECC001'
#ECC002.instance_name='ECC002'
#ECC001.instance_number=001
#ECC002.instance_number=002
#ECC001.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.100.12.68)(PORT=1521))'
#ECC002.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.100.12.70)(PORT=1521))'
#*.log_archive_config='dg_config=(ECC,ECC_STBY,ecc_dr)'
#*.log_archive_dest_1='LOCATION=+RECOC1/ECC/oraarch'
#*.log_archive_dest_2='service="ecc_dr"','ASYNC NOAFFIRM delay=0 optional compression=disable max_failure=0 reopen=300 db_unique_name="ecc_dr" net_timeout=30','valid_for=(online_logfile,all_roles)'
#*.log_archive_dest_state_2='ENABLE'
#*.log_archive_format='%t_%s_%r.dbf'
*.log_checkpoints_to_alert=true
*.max_dump_file_size='20000'
*.open_cursors=2000
*.parallel_execution_message_size=16384
*.parallel_threads_per_cpu=1
*.pga_aggregate_limit=24G
*.pga_aggregate_target=12G
*.processes=900
*.query_rewrite_enabled='false'
*.recyclebin='off'
#*.remote_listener='exacc02-scan.rootbrasil.intranet:1521'
*.remote_login_passwordfile='exclusive'
*.replication_dependency_tracking=false
#ECC001.service_names='ECC','ECC001'
#ECC002.service_names='ECC','ECC002'
*.sessions=640
*.sga_max_size=24G
*.shared_pool_size=8640M
*.standby_file_management='AUTO'
*.star_transformation_enabled='true'
#ECC001.thread=001
#ECC002.thread=002
ECC001.undo_tablespace='PSAPUNDO001'
ECC002.undo_tablespace='PSAPUNDO002'


--subir o banco em nomount force com o rman
rman target /
startup force nomount;

-- restore controlfile e spfile (vai direto para o directorio $ORACLE_HOME/DBS)

restore spfile to pfile '/u04/app/oracle/product/19.0.0.0/dbhome_3/dbs/pfilePOH.ora' from '/bkp3/BKP_SPFILE_POH_2m3hqjm7_86_20250215.rmam';


restore controlfile from '/bkp3/BKP_CONTROLFILE_POH_2l3hqjm7_85_20250215.rmam'; 



-- apos fazer o mount fazer o catalog dos backups
catalog start with '/bkp_sap_dev/SDJ_BKP/'; -- ok
catalog start with '/bkp_sap_dev/PDS_BKP/'; -- ok
catalog start with '/bkp_sap_dev/PDO_BKP/'; -- ok
catalog start with '/bkp_sap_dev/EDC_BKP/'; -- ok
catalog start with '/bkp_sap_dev/LDT_BKP/'; -- ok

-rwxr-x--x. 1 oracle asmadmin 462315088 Jan 23 16:19 oracle

dentro da pasta bin do home do oracle o arquivo oracle deve ter a permissão -rwsr-s--x. (6751) e deve pertencer ao grupo asmadmin.

chown oracle:asmadmin oracle
chmod 6751 oracle

ll /u03/app/oracle/product/19.0.0.0/dbhome_2/bin/oracle
ll /u04/app/oracle/product/19.0.0.0/dbhome_3/bin/oracle
ll /u02/app/oracle/product/19.0.0.0/dbhome_1/bin/oracle
ll /u05/app/oracle/product/19.0.0.0/dbhome_4/bin/oracle
ll /u06/app/oracle/product/19.0.0.0/dbhome_5/bin/oracle

# Mudar parametros recomendados pelo SAP
# APLICAR OS PARAMETROS DO BANCO....
 
 
ALTER SYSTEM SET "_FIX_CONTROL"=
'5099019:ON','6055658:OFF','6120483:OFF','6399597:ON','6430500:ON','6972291:ON',
'7324224:OFF','7658097:ON','8932139:ON','8937971:ON','9196440:ON','9495669:ON',
'13627489:ON','14255600:ON','14595273:ON','18405517:2','20355502:10','20636003:OFF',
'22387320:ON','22540411:ON','23738304:OFF','24561942:ON','25643889:ON','26536320:ON',
'27321179:ON','27466597:ON','28173995:ON','28234255:3','28414968:3','28498976:ON',
'28558645:ON','28602253:ON','28708585:ON','28835937:ON','28999046:ON','29302565:ON',
'29304314:ON','29385774:ON','29450812:ON','29487407:ON','29687220:ON','29867728:ON',
'29930457:ON','30008456:ON','30142527:ON','30195773:ON','30231086:ON','30235691:ON',
'30249927:ON','30470947:ON','30483217:ON','30537403:ON','30616738:OFF','30776676:ON',
'30786641:ON','31009032:ON','31082719:ON','31143146:ON','31444353:1','31496840:ON',
'31821701:ON','31961578:ON','32014520:ON','32107621:ON'
COMMENT='SAP_191200210720_202108 RECOMMENDED SETTINGS'
SCOPE=SPFILE;
 
 
ALTER SYSTEM SET EVENT='10027','10028','10142','10183','10191','10995 level 2','38068 level 100','38085','38087','44951 level 1024','60025' COMMENT='SAP_19500191015_201911 RECOMMENDED SETTINGS' SCOPE=SPFILE;


-- criar os scripts padrão para restore.

run {
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
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-10' to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-10';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-4'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-4';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-5'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-5';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-6'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-6';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-7'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-7';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-8'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-8';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPSR3DB_FNO-9'  to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPSR3DB_FNO-9';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-PSAPUNDO_FNO-3'   to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-PSAPUNDO_FNO-3';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-SYSAUX_FNO-11'    to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-SYSAUX_FNO-11';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-SYSAUX_FNO-12'    to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-SYSAUX_FNO-12';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-SYSAUX_FNO-2'     to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-SYSAUX_FNO-2';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-SYSTEM_FNO-1'     to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-SYSTEM_FNO-1';
SET NEWNAME FOR DATAFILE '/oracle/SDJ/sapdata1/data_D-SDJ_TS-SYSTEM_FNO-13'    to '+DATA_SDJ/SDJ/datafile/data_D-SDJ_TS-SYSTEM_FNO-13';
restore database;
SWITCH DATAFILE ALL;
}

-- fazer o recover.
run {
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
sql 'alter session set nls_date_format="YYYY-MM-DD HH24:MI:SS"';
recover database;
}


/bkp_sap_dev/Backup_Full_EDC_18012025


----- apos finalizar o restore, criar diretorios se necessario para os arquivos que serao criados ao abrir a base (TEMP/REDO)
####------ Validar todos caminhos
select N
  from (select name N from v$controlfile
         union all
        select member N from v$logfile
         union all
        select name N from v$datafile
         union all
        select name N from v$tempfile)
  order by N ;

###### - Monta Comandos para Renomear DataFiles (sqplus), SE NECESS�RIO
######
######   Necessario quando os Diretorios da base de Origem forem Diferentes
######   Os datafiles sao feitos acima pelo NEWNAMEs, porem os REDOs e TEMPs dependendo da forma feita não, entao fazer aqui. (segundo e terceiro select)
######
select ' alter database rename file '''|| f.NAME ||''' to ''XXX'|| f.NAME ||''' ; '
from V$DATAFILE f
order by f.NAME ;

select ' alter database rename file '''|| f.MEMBER ||''' to ''XXX'|| f.MEMBER ||''' ; '
from V$LOGFILE f
order by f.MEMBER ;

select ' alter database rename file '''|| f.NAME ||''' to ''XXX'|| f.NAME ||''' ; '
from V$TEMPFILE f
order by f.NAME ;

-- Abrir o banco
alter database disable block change tracking;
alter database flashback off;
alter database open resetlogs;

-- recriar TEMP
SELECT property_name, property_value FROM database_properties WHERE property_name='DEFAULT_TEMP_TABLESPACE';
SELECT tablespace_name, file_name, bytes/1024/1024 MB, status FROM dba_temp_files;
create temporary tablespace PSAPTEMP1 tempfile '+DATAPOH' size 1000M autoextend on next 100M maxsize 32767M;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE PSAPTEMP;
DROP TABLESPACE PSAPTEMP1 INCLUDING CONTENTS AND DATAFILES;

-- criar a nova tablespace nova.
CREATE TEMPORARY TABLESPACE PSAPTEMP1 TEMPFILE '+DATA_SDJ' SIZE 32767M AUTOEXTEND ON NEXT 10M;

-- Alterar para a tablespace nova
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE PSAPTEMP;

-- se mudar nome da tablespace precisa fazer o Switch all existing users para nova temp tablespace.
BEGIN
  FOR cur_user IN (SELECT username FROM dba_users WHERE temporary_tablespace = 'TEMP') LOOP
    EXECUTE IMMEDIATE 'ALTER USER ' || cur_user.username || ' TEMPORARY TABLESPACE temp';
  END LOOP;
END;
/

DROP TABLESPACE  PSAPTEMP1 INCLUDING CONTENTS AND DATAFILES;

-- incluid datafiles suficiente.

alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;






10.100.9.75:/backup/backup_EDC/

10.100.8.226

mount -t nfs -v 10.100.9.75:/backup/ /bkp

export GRID_HOME=/u01/app/19.0.0.0/grid
export GRID_BASE=/u01/app/grid
export ORACLE_HOME=$GRID_HOME
export ORACLE_BASE=$GRID_BASE
export ORACLE_SID=+ASM1
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export TNS_ADMIN=$ORACLE_HOME/network/admin

export ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1
export ORACLE_SID=ECQ
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_BASE=/u02/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

export ORACLE_HOME=/u04/app/oracle/product/19.0.0.0/dbhome_3
export ORACLE_SID=POH
export ORACLE_BASE=/u04/app/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib



[INS-44010] Installer has detected that Oracle Restart is not running.
Action 
 - Perform one of the following, before executing the configuration tools
 - Run the Installer on the node where Oracle Restart is running from this Oracle home - Open a terminal, 
log in as root or Administrator, change directory to this Oracle Restart home, and start Oracle Restart by entering this command: crsctl start has


cp -pR /u01/app/19.0.0.0/grid/ /u01/app/19.0.0/grid/


rm -rf /etc/init.d/oracleafd
rm -rf /etc/systemd/system/oracleafd.service
rm -rf /etc/oracleafd.conf
rm -rf /lib/modules/$(uname -r)/extra/oracleafd*

find /lib/modules/$(uname -r) -name "oracleafd.ko"

