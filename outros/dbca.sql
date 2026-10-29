-- criação de banco modo visual.
dbca

-- criação do banco em modo silent - modo simples - 
dbca -silent -createDatabase                            \
     -templateName General_Purpose.dbc                  \
     -gdbname ${ORACLE_SID} -sid  ${ORACLE_SID}         \
     -characterSet AL32UTF8                             \
     -sysPassword enterDB#123                           \
     -systemPassword enterDB#123                        \
     -createAsContainerDatabase false                   \
     -totalMemory 2000                                  \
     -storageType FS                                    \
     -datafileDestination /u01/db_files                 \
     -emConfiguration NONE                              \
     -ignorePreReqs -sampleSchema true

# Silent mode.
dbca -silent -createDatabase                                                   \
     -templateName General_Purpose.dbc                                         \
     -gdbname ${ORACLE_SID} -sid  ${ORACLE_SID} -responseFile NO_VALUE         \
     -characterSet AL32UTF8                                                    \
     -sysPassword SysPassword1                                                 \
     -systemPassword SysPassword1                                              \
     -createAsContainerDatabase true                                           \
     -numberOfPDBs 1                                                           \
     -pdbName ${PDB_NAME}                                                      \
     -pdbAdminPassword PdbPassword1                                            \
     -databaseType MULTIPURPOSE                                                \
     -memoryMgmtType auto_sga                                                  \
     -totalMemory 2000                                                         \
     -storageType FS                                                           \
     -datafileDestination "${DATA_DIR}"                                        \
     -redoLogFileSize 50                                                       \
     -emConfiguration NONE                                                     \
     -ignorePreReqs

-- via response file
cat /export/home/oracle/db_create.rsp

responseFileVersion=/oracle/assistants/rspfmt_dbca_response_schema_v12.2.0
gdbName=DBACLASS9
sid=KPVPPRD
databaseConfigType=SI
policyManaged=false
createServerPool=false
createAsContainerDatabase=false
templateName=/oracle/app/oracle/product/19.9.0.0/dbhome_1/assistants/dbca/templates/New_Database.dbt
sysPassword=oracle#123	
systemPassword=oracle#123
runCVUChecks=FALSE
dvConfiguration=false
olsConfiguration=false
datafileJarLocation=
datafileDestination=/oradata/{DB_UNIQUE_NAME}/
storageType=FS
characterSet=AL32UTF8
nationalCharacterSet=UTF8
listeners=LISTENER
variables=ORACLE_BASE_HOME=/oracle/app/oracle/product/19.9.0.0/dbhome_1, DB_UNIQUE_NAME=KPVPPRD, ORACLE_BASE=/oracle/app/oracle, PDB_NAME=,DB_NAME=DBACLASS9,ORACLE_HOME=/oracle/app/oracle/product/19.9.0.0/dbhome_1,SID=DBACLASS9
initParams=undo_tablespace=UNDOTBS1,sga_target=10093MB,db_block_size=8192BYTES,log_archive_dest_1='LOCATION=/archive/DBACLASS9',nls_language=AMERICAN,dispatchers=(PROTOCOL=TCP) (SERVICE=DBACLASS9XDB),diagnostic_dest={ORACLE_BASE},
control_files=("/oradata/{DB_UNIQUE_NAME}/control01.ctl", "/oradata/{DB_UNIQUE_NAME}/control02.ctl"),
remote_login_passwordfile=EXCLUSIVE,audit_file_dest={ORACLE_BASE}/admin/{DB_UNIQUE_NAME}/adump,processes=1400,
pga_aggregate_target=3365MB,nls_territory=AMERICA,local_listener=LISTENER,open_cursors=300,log_archive_format=%t_%s_%r.dbf,compatible=19.0.0,db_name=DBACLASS9,audit_trail=db
sampleSchema=false
memoryPercentage=40
databaseType=MULTIPURPOSE
automaticMemoryManagement=false
totalMemory=0  

dbca -silent -createDatabase -responseFile /export/home/oracle/db_create.rsp


select      user_process username,
       "Recursive Calls",
       "Opened Cursors",
       "Current Cursors"
    from  (
       select  nvl(ss.USERNAME,'ORACLE PROC')||'('||se.sid||') ' user_process,
                       sum(decode(NAME,'recursive calls',value)) "Recursive Calls",
                       sum(decode(NAME,'opened cursors cumulative',value)) "Opened Cursors",
                       sum(decode(NAME,'opened cursors current',value)) "Current Cursors"
      from    v$session ss,
                v$sesstat se,
                 v$statname sn
      where   se.STATISTIC# = sn.STATISTIC#
      and     (NAME  like '%opened cursors current%'
      or       NAME  like '%recursive calls%'
      or       NAME  like '%opened cursors cumulative%')
      and     se.SID = ss.SID
      and     ss.USERNAME is not null
      group   by nvl(ss.USERNAME,'ORACLE PROC')||'('||se.SID||') '
   )
   orasnap_user_cursors
   order      by USER_PROCESS,"Recursive Calls"
/