-- grant no directory
GRANT READ,WRITE ON DIRECTORY DMP_BKP TO DBSKYONE;

[oracle@dm01db03 scripts]$ cat export_syspergamum.sh
#!/bin/bash
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/dbhome_1
export ORACLE_SID=racnovo1
expdp \"/ as sysdba\" directory=DUMPSYN dumpfile=sysperg20052015-A%U.dmp logfile=exp-sysperg20052015_.log FILESIZE=20G schemas=SYSPERGAMUM

FILESIZE=750MB FILE=exp_f1.dmp,exp_f2.dmp, exp_f3.dmp,exp_f4.dmp FULL=Y DIRECT=Y LOG=exp_full.log 

-- DUMP export de tabela, acrescentar mais tabelas caso precise separando por virgulas.
expdp \"/ as sysdba\" directory=RS00871095 dumpfile=RS00871095_%U.dmp logfile=LOG_RS00871095.log TABLES=ODB.PN_MASTER;

expdp \"/ as sysdba\" directory=RS00871095 dumpfile=RS00871095_%U.dmp logfile=LOG_RS00871095.log TABLES=ODB.PN_MASTER,ODB.PN_MASTER02;

-- DUMP export procedure
expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7294003_RANKING.dmp LOGFILE=LOG_C7287906_RANKING.log PROCEDURE=USRCAMPANHA.RANKING

-- DUMP export da estrutura do schema inteiro (CONTENT=METADATA_ONLY )
nohup expdp DIRECTORY=DUMP_WORK_TMP DUMPFILE=C7291881_RM_LIVE.dmp CONTENT=METADATA_ONLY LOGFILE=LOG_C7291881_RM_LIVE.log SCHEMAS=RM_LIVE &

-- DUMP export com compression
nohup expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7298332_SABRECCH.dmp COMPRESSION=ALL LOGFILE=C7298332_LOG_SABRECCH.log SCHEMAS=RM_LIVE &


-- DUMP export somente de um schema
nohup expdp \'/as sysdba \' DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log SCHEMAS=OP1Q &
    -- PDB precisa ter um usuario caso não tenha deve ser criado
   nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log SCHEMAS=OP1Q &


--DUMP export full
nohup expdp \'/as sysdba \' DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log &
    -- PDB
    nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log &



--ORACLE 9i
nohup exp tech4b/dba01dba owner=OP1Q file=CCH0013577_OP1Q.dmp LOG=LOG_CCH0013577_OP1Q.log &

nohup imp tech4b/dba01dba fromuser=OP1Q touser=OP1Q file=CCH0013577_OP1Q.dmp LOG=LOG_CCH0013577_OP1Q.log &


###############################################
EXPDP CONTAINER

SCHEMA
expdp DIRECTORY=SABREODS DUMPFILE=C7292104_CM_ODS.dmp COMPRESSION=ALL LOGFILE=LOG_C7292104_CM_ODS.log SCHEMAS=CM_ODS

PROCEDURE
SELECT DBMS_METADATA.GET_DDL ('PROCEDURE','SELECTHEADSTAR','MM_ODS') DDL FROM DUAL

ENTRAR COM
USU�RIO: USUARIO@CONTAINER
         uoldiveo_dba@SABREODS

##############################################



expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_sit_exemp.dmp LOGFILE=LOG_C7291482_hist_sit_exemp.log TABLES=SYSPERGAMUM.hist_sit_exemp
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_local_exemplar.dmp LOGFILE=LOG_C7291482_hist_local_exemplar.log TABLES=SYSPERGAMUM.hist_local_exemplar
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_bib_exemplar.dmp LOGFILE=LOG_C7291482_hist_bib_exemplar.log TABLES=SYSPERGAMUM.hist_bib_exemplar
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_exemplar_pergamum.dmp LOGFILE=LOG_C7291482_exemplar_pergamum.log TABLES=SYSPERGAMUM.exemplar_pergamum
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_acervo_classificacao.dmp LOGFILE=LOG_C7291482_acervo_classificacao.log TABLES=SYSPERGAMUM.acervo_classificacao


expdp \'/as sysdba \' DIRECTORY=DUMP_CHANGE DUMPFILE=TDTDAZULDB_C7338168.dmp LOGFILE=LOG_TDAZULDB_C7338168.log full=Y

--Criação de directory
create directory C7287492 as '/d01dmp/d01dmp/expdp/C7287492'

create directory DUMP as '/restore_tmp';

create or replace directory DUMP_CHANGE as '/d01dmp/d01dmp/expdp/C7287319'


-- Gerar backup/dump com arquivos de 2gb cada
nohup expdp '"/ as sysdba"' directory=directory_name dumpfile=backup_name_%u.dmp logfile=log_name_%u.log full=yes filesize=2g parallel=3 job_name=expfull &

nohup expdp '"/ as sysdba"' directory=directory_name dumpfile=backup_name_%u.dmp logfile=log_name_%u.dmp filesize=2g job_name=expfull &

nohup expdp '"/ as sysdba"' directory=DUMP dumpfile=backup_name_%u.dmp logfile=log_dump_teste.dmp filesize=100m schemas=oracle &

nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=backup_name_%u.dmp logfile=log_import.log REMAP_TABLESPACE=DADOS:SYSTEM REMAP_SCHEMA=oracle:system;

--PARFILE gerar arquivo para ver estimativa de tamanho do DUMP

expdp parfile=DUMP_TRAX.par

--NO BANCO EXECUTAR O COMANDO PARA VERIFICAR QUAL O JOB EM EXECUÇÃOO
set lines 800 pages 5000
col OWNER_NAME for a25
col JOB_NAME for a25
col OPERATION for a8
col JOB_MODE for a5
select * from dba_datapump_jobs;

--APÓS SAIR DO BANCO E EXECUTAR O COMANDO ABAIXO PARA VERIFICAR A EXECUÇÃO
expdp attach=SYS_EXPORT_SCHEMA_15 


nohup expdp \'/as sysdba \' DIRECTORY=DUMP_CHANGE DUMPFILE=RS00884043_SONDANET.dmp LOGFILE=RS00884043_SONDANET_LOG.log full=Y &
nohup expdp "'/ as sysdba'" DIRECTORY=BACKUP_DUMP dumpfile=DUMP_UOL_BACKUP2.dmp logfile=DUMP_UOL_BACKUP_LOG2.log schemas=UOLDIVEO_DBA &
nohup expdp \'/as sysdba \' DIRECTORY=BACKUP_DUMP DUMPFILE=DUMP_UOL_BACKUP3.dmp LOGFILE=DUMP_UOL_BACKUP_LOG3.log TABLES=UOLDIVEO_DBA.LOG_EVENT,UOLDIVEO_DBA.LOG_DESC &

nohup expdp \'/as sysdba \' DIRECTORY=BACKUP_DUMP ESTIMATE_ONLY=YES schemas=UOLDIVEO_DBA logfile=expdp_estimate.log &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES logfile=expdp_estimate.log FULL=Y  &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES COMPRESSION_ALGORITHM=HIGH schemas = SONDAWEB &
nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@ORAPDB1 DIRECTORY=EXPDUMP ESTIMATE_ONLY=YES &

nohup expdp \'/as sysdba@MEGABILD \' DIRECTORY=DUMP DUMPFILE=RS00884043_SONDANET_SONDAWEB.dmp LOGFILE=RS00884043_SONDANET_SONDAWEB_LOG.log VERSION=11.2 schemas=SONDAWEB &

nohup expdp '"/ as sysdba"' directory=DMP_DB dumpfile=backup_PERFSTAT.dmp logfile=log_bkp_PERFSTAT.log schemas=PERFSTAT &


nohup impdp \'/as sysdba \' directory=DUMP dumpfile=restore_table_RS00859701.dat LOGFILE=LOG_import_RS00859701.log TABLES=TOTVSRECH.SE2040,TOTVSRECH.Z08040,TOTVSRECH.Z0D040

remap_table=schema.table_name:new_table

--- Recover table com RMAN
recover table TOTVSRECH.SE2040,TOTVSRECH.Z08040,TOTVSRECH.Z0D040
UNTIL TIME "to_date('26/05/2020 02:05:31','DD/MM/YYYY hh24:mi:ss')"
AUXILIARY DESTINATION '/oradata/backup/export/RS00859701'
DATAPUMP DESTINATION '/oradata/backup/export/RS00859701/DUMP'
DUMP FILE 'restore_table_RS00859701.dat'
NOTABLEIMPORT;

remap table SCOTT.T1:T1_DROP; 

expdp \'/ as sysdba \' directory=DUMP DUMPFILE=restore_table_RS00859701.dmp LOGFILE=expdp_table.log
TABLES=TOTVSRECH.SE2040, TOTVSRECH.Z08040,TOTVSRECH.Z0D040
TO_DATE('260520','ddmmyy')  

-- // --

nohup sqlplus "/ as sysdba" @script_rebuild.sql &


nohup expdp \'/as sysdba \' directory=DUMP_CHANGE dumpfile=C7333637_T7344839_backup_table_PN_MASTER.dmp LOGFILE=C7333637_T7344839_backup_table_PN_MASTER_LOG.log TABLES=ODB.PN_MASTER &
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_periodicidade.dmp LOGFILE=LOG_C7287492_obr_periodicidade.log TABLES=SYNCHRO.obr_periodicidade


-- DUMP DO PDP
export ORACLE_PDB_SID=ADMDB01P 

echo $ORACLE_PDB_SID
\'/ as sysdba@CONSINCO \'
nohup expdp LUCSKY/LUCSKY@CONSINCO directory=BACKUP_DMPNOITE dumpfile=ADMDB01P_FULL.dmp logfile=ADMDB01P_LOG.log FULL=Y &
LUCSKY/LUCSKY@ADMDB01P
BACKUP_DMPNOITE

#515504 (07/06) Atualização da Base Homologação
nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=dpnoite%U.dmp logfile=impdp_MEGABILD.log  &

create or replace directory DMP_01 as '/oracle/dump_bild';

nohup impdp '"/ as sysdba"' directory=DMP_01 dumpfile=dpnoite%u.dmp logfile=imp_megahom.log REMAP_TABLESPACE=UNDOTBS1:UNDO1 REMAP_TABLESPACE=UNDO_2:UNDO02 REMAP_TABLESPACE=PDBTEMP:TEMP1 exclude=SCHEMA:"IN('SYS','SYSMAN','SYSTEM','OUTLN','ORDDATA')" table_exists_action=replace &
nohup impdp '"/ as sysdba"' directory=DMP_01 dumpfile=dpnoite%u.dmp logfile=imp_megahom.log REMAP_TABLESPACE=UNDOTBS1:UNDO1,UNDO_2:UNDO02,PDBTEMP:TEMP1 exclude=SCHEMA:"IN('SYS','SYSMAN','SYSTEM','OUTLN','ORDDATA')" table_exists_action=replace &

nohup impdp '"/ as sysdba"' directory=DMP_01 dumpfile=dpnoite%u.dmp logfile=imp_megahom.log REMAP_TABLESPACE=UNDOTBS1:UNDO1,UNDO_2:UNDO02,PDBTEMP:TEMP1 
schemas=MGBEN table_exists_action=replace &

nohup impdp PARFILE=parfile_full.par &

nohup impdp '"/ as sysdba"' directory=DP2 dumpfile=dpnoite%u.dmp logfile=imp_megahom.log REMAP_TABLESPACE=UNDOTBS1:UNDO1,UNDO_2:UNDO02,PDBTEMP:TEMP1 

nohup expdp '"/ as sysdba"' directory=BACKUP_DMPNOITE dumpfile=bkp-NDD_CONNECTOR-TBPROCESSDATA.dmp logfile=LOG_tab-NDD_CONNECTOR-TBPROCESSDATA.log TABLES=NDD_CONNECTOR.TBPROCESSDATA &



expdp dbskyone@PDB1 directory=DMPNOITE dumpfile=agrocp_dmp.dmp logfile=expdp_agrocp_treino.log schemas=AGROCP exclude=statistics


impdp dbskyone@PDB1 directory=DMPNOITE dumpfile=agrocp_dmp.dmp logfile=impdp_agrocp_treino.log schemas=AGROCP remap_schema=AGROCP:GRUPOCP remap_tablespace=SIAGRI_DATA:TREINO transform=OID:N


userid="grupocp/8w6-gzN#FtQ3cWF@PDB1"
dumpfile=agrocp_dmp.dmp
logfile=impdp_agrocp_treino.log
directory=DMPNOITE
remap_schema=AGROCP:GRUPOCP
REMAP_TABLESPACE=SIAGRI_DATA:TREINO
schemas=AGROCP
transform=OID:N
[oracle@agrocp scripts]$

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@ORAPDB1 directory=EXPDUMP dumpfile=BKP_GLOBUS72-19-08-21.dmp logfile=log_GLOBUS72.log schemas=GLOBUS72 VERSION=11.2.0.4 &

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@ORAPDB1 directory=EXPDUMP dumpfile=BKP_CONSULTA72-13-08-21.dmp logfile=log_consulta72.log schemas=CONSULTA72 &

impdp '"/ as sysdba"' directory=DMP dumpfile=AGROZAP_2021_08_17_19_00_32.dmp logfile=imp_AGROZAP.log

nohup impdp '"/ as sysdba"' directory=DMP dumpfile=AGROZAP_2021_08_17_19_00_32.dmp logfile=imp_AGROZAP.log &

nohup 
expdp 'DBSKYONE/Sky#n35eCwr7t!'@CONSINCO directory=DMP_BKP dumpfile=BKP_RF_NOTAMESTRE_21.dmp logfile=log_nota_mestre_21.log tables=CONSINCO.RF_NOTAMESTRE

expdp DBSKYONE@CONSINCO directory=DMP_BKP dumpfile=BKP_RF_NOTAMESTRE_21.dmp logfile=log_nota_mestre_21.log tables=CONSINCO.RF_NOTAMESTRE


 expdp system/password schemas=JOB_USER directory=EXPORT_DIR dumpfile=JOB_USER.dmp logfile=expdpJOB_USER.log

 nohup impdp '"/ as sysdba"' directory=BACKUP_DMPNOITE dumpfile=dpnoite%u.dmp logfile=imp_megahom.log REMAP_TABLESPACE=UNDOTBS1:UNDO1,UNDO_2:UNDO02,PDBTEMP:TEMP1 


nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@ORCLEL_PDB1 directory=DMP dumpfile=ELASFILPRD.DMP logfile=elasfilprd_logIMPDP.log &

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@ORCLEL_PDB1 directory=DMP dumpfile=ELASFILTST.DMP logfile=elasfiltst_logIMPDP.log &


nohup expdp '"/ as sysdba"' directory=DATA_PUMP_DIR dumpfile=humanus.dmp logfile=humanus_expdp.log schemas=HUMANUS &
nohup impdp '"/ as sysdba"' directory=DATA_PUMP_IMPDP dumpfile=humanus.dmp logfile=humanus_impdp.log schemas=HUMANUS &



expdp '"/ as sysdba"' directory=DMP dumpfile=futura31-08-21.dmp logfile=futura-log.log schemas=FUTURA

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@ARCOMIX directory=TEMP_DPDIR dumpfile=FUTURA31-08-21.DMP logfile=futura-log-impdp.log REMAP_TABLESPACE=FUTURA:TSD_CONSINCO REMAP_SCHEMA=FUTURA:GENF &

expdp 'DBSKYONE/Sky#n35eCwr7t!'@ARCOMIX directory=TEMP_DPDIR dumpfile=GENF-08-21.dmp logfile=GENF-log.log schemas=GENF;

expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=TEMP_DPDIR filesize=30000M dumpfile=GENF-08-21.dmp logfile=GENF-log.log schemas=GENF;

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=PRDDB filesize=30000M dumpfile=coruripe_refresh_08-09-21.dmp logfile=coruripe_log_expdp_08-09-21.log schemas=SIEM_CORP,SIEM_CFL,SIEM_ITU,SIEM_CAR,SIEM_LIM,SIEM_COR EXCLUDE=STATISTICS &

nohup expdp '"/ as sysdba"' directory=PRDDB filesize=30000M dumpfile=coruripe_refresh_08-09-21.dmp logfile=coruripe_log_expdp_08-09-21.log schemas=SIEM_CORP,SIEM_CFL,SIEM_ITU,SIEM_CAR,SIEM_LIM,SIEM_COR EXCLUDE=STATISTICS &

nohup impdp  '"/ as sysdba"' directory=PRDDB dumpfile=coruripe_refresh_08-09-21.dmp logfile=coruripe_log_impdp_08-09-21.log schemas=SIEM_CORP,SIEM_CFL,SIEM_ITU,SIEM_CAR,SIEM_LIM,SIEM_COR &


nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 directory=EXPDUMP filesize=50g dumpfile=lefosse%U.dmp logfile=lefosse_log_expdp.log EXCLUDE=STATISTICS full=Y &
nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@PDBP01 directory=BACKUP dumpfile=lefosse%U.dmp logfile=lefosse_log_impdp.log schemas=SISJURI,MIGRACAO,SISJURIHML,LDESK,LDESK_CUSTOM &


nohup expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=EXPDUMP ESTIMATE_ONLY=YES FULL=Y &

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@ORAPDB1 directory=EXPDUMP dumpfile=COMANDO_DIESEL_571049.dmp logfile=log_expdp_FULL.log EXCLUDE=STATISTICS schemas=GLOBUS574 VERSION=11.2.0.4 &

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@ORAPDB1 directory=EXPDUMP dumpfile=agrotec.dmp logfile=log_impdp_agrotecnica.log remap_schema=AGROTEC:TREINO remap_tablespace=SIAGRI_DATA:TREINO transform=OID:N &


nohup expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=EXPDUMP dumpfile=centraladubos_280921.dmp logfile=log_expdp_centraladubos.log full=y flashback_time=systimestamp EXCLUDE=STATISTICS &

consistent=y
flashback_time=systimestamp


nohup impdp '"/ as sysdba"' directory=EXPDUMP dumpfile=ECF-13_59_39.dmp logfile=ECF-13_59_39_LOG.log remap_schema=GDE_ECF:GDE_ECF remap_tablespace=GDE_ECF:TSD_LALUR transform=OID:N &


