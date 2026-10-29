-- exemplo 1
userid="/ as sysdba"
DIRECTORY=EXPDP_BDEMP
CLUSTER=N
Parallel=10
dumpfile=BDEMP_08022018_%U.dmp 
filesize=30g
logfile=expdp_BDEMP_08022018.log
compression=all
SCHEMAS=SCHEMA_CANALCONECTA
exclude=STATISTICS,TABLE:"IN('BEHAVIORAL_TEST_RESULT_DOC', 'BEHAVIORAL_TEST_RESULT_EXPECT2', 'DR$CONT_AGENCY$I', 'DR$CONT_AREA$I', 'DR$CONT_ATTACHMENTS$I', 'DR$CONT_AUTHOR$I', 'DR$CONT_CITY$I', 'DR$CONT_DESCRIPTION$I', 'DR$CONT_LOCATIONCITY$I', 'DR$CONT_NEWS$I', 'DR$CONT_ORGANIZER$I', 'DR$CONT_SPHERE$I', 'DR$CONT_TEXT$I', 'DR$CONT_TEXT$K', 'DR$CONT_TEXT$N', 'DR$CONT_TEXT$R', 'DR$CONT_TITLE$I', 'DR$CONT_TITLES$I', 'DR$IDX_ACAC_QUALIFICATION$I', 'DR$IDX_CITY$I', 'DR$IDX_COURSES$I', 'DR$IDX_JOB_OPENING_REGIME$I', 'DR$IDX_JOB_OPENING_TITLE$I', 'DR$IDX_JOB_PRACTICE_AREA$I', 'DR$IDX_KEYWORDS$I', 'DR$IDX_SKILLS$I', 'DR$IDX_WORKING_DEPARTMENT$I', 'DR$IDX_WORKING_DPT_OTHER$I', 'DR$IDX_WORKING_TITLE_OTHER$I', 'DR$IDX_WORKING_TITLE$I', 'CPFSDUPLICADOS', 'CPFSDUPLICADOS2', 'CURSOSDUPLICADOS', 'DEMAIS_STUDENT_DUPLIC')"

create directory EXPDP_BDEMP as '/u03/expdp/expdp_bdemp/';

nohup expdp \"/ as sysdba\" parfile=/u03/expdp/expdp_bdemp/expdp_BDEMP_08022018.par &

-- exemplo 2 import
userid="/ as sysdba"
EXCLUDE='NORMAL_OPTIONS'
dumpfile=dpnoite%u.dmp
logfile=imp_megahom_users.log
directory=DMP_01
REMAP_TABLESPACE=UNDOTBS1:UNDO1,UNDO_2:UNDO02,PDBTEMP:TEMP1
schemas=MGBEN
table_exists_action=replace

nohup impdp PARFILE=parfile_full.par &

-- exemplo 3 import
userid="/ as sysdba"
full=yes
directory=DP2
dumpfile=dpnoite01.dmp
remap_tablespace=pdbtemp:temp
logfile=imp_full_150621.log
exclude=tablespace 
exclude=SCHEMA:"='ANONYMOUS'"
exclude=SCHEMA:"='APEX_050100'"
exclude=SCHEMA:"='APEX_040200'"
exclude=SCHEMA:"='APEX_INSTANCE_ADMIN_USER'"
exclude=SCHEMA:"='APEX_LISTENER'"
exclude=SCHEMA:"='APEX_PUBLIC_USER'"
exclude=SCHEMA:"='APEX_REST_PUBLIC_USER'"
exclude=SCHEMA:"='APPQOSSYS'"
exclude=SCHEMA:"='AUDSYS'"
exclude=SCHEMA:"='C##DBAAS_BACKUP'"
exclude=SCHEMA:"='C##DBAAS_MONITOR'"
exclude=SCHEMA:"='CTXSYS'"
exclude=SCHEMA:"='DBSNMP'"
exclude=SCHEMA:"='DIP'"
exclude=SCHEMA:"='DVF'"
exclude=SCHEMA:"='DVSYS'"
exclude=SCHEMA:"='FLOWS_FILES'"
exclude=SCHEMA:"='GSMADMIN_INTERNAL'"
exclude=SCHEMA:"='GSMCATUSER'"
exclude=SCHEMA:"='GSMUSER'"
exclude=SCHEMA:"='LBACSYS'"
exclude=SCHEMA:"='MDDATA'"
exclude=SCHEMA:"='MDSYS'"
exclude=SCHEMA:"='OJVMSYS'"
exclude=SCHEMA:"='OLAPSYS'"
exclude=SCHEMA:"='ORACLE_OCM'"
exclude=SCHEMA:"='ORDDATA'"
exclude=SCHEMA:"='ORDPLUGINS'"
exclude=SCHEMA:"='ORDSYS'"
exclude=SCHEMA:"='ORDS_METADATA'"
exclude=SCHEMA:"='ORDS_PUBLIC_USER'"
exclude=SCHEMA:"='OUTLN'"
exclude=SCHEMA:"='PDB_ADM'"
exclude=SCHEMA:"='SI_INFORMTN_SCHEMA'"
exclude=SCHEMA:"='SPATIAL_CSW_ADMIN_USR'"
exclude=SCHEMA:"='SPATIAL_WFS_ADMIN_USR'"
exclude=SCHEMA:"='SYS'"
exclude=SCHEMA:"='SYSBACKUP'"
exclude=SCHEMA:"='SYSDG'"
exclude=SCHEMA:"='SYSKM'"
exclude=SCHEMA:"='SYSTEM'"
exclude=SCHEMA:"='WMSYS'"
exclude=SCHEMA:"='XDB'"
exclude=SCHEMA:"='XS$NULL'"
exclude=SCHEMA:"='MGMT_VIEW'"
exclude=SCHEMA:"='EXFSYS'"
exclude=SCHEMA:"='OWBSYS'"
exclude=SCHEMA:"='OWBSYS_AUDIT'"
exclude=SCHEMA:"='APEX_030200'"
exclude=SCHEMA:"='DMSYS'"
exclude=SCHEMA:"='SYSMAN'"
exclude=SCHEMA:"='TSMSYS'"
exclude=SCHEMA:"='WKSYS'"
transform=oid:n,pctspace:0.0001

nohup impdp PARFILE=parfile_full.par &