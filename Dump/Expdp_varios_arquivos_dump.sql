

--LIMPAR OS OBJETOS like '%MG%' e like '%MEGA%'

select name from v$database;
 set echo on serveroutput on feed on head on
 declare
 vSQL long;
 vBaseDrop varchar2(10);
 vBaseAtual varchar2(10);
begin
  begin
    select name into vBaseAtual from v$database;
    exception
    when no_data_found then
    dbms_output.put_line('Erro ao encontrar o banco');
  end;
      if '&vBaseDrop' = 'megahom' then
   begin
    for R_OBJ in (SELECT * FROM ALL_OBJECTS WHERE owner like '%MG%' ORDER BY OWNER)
    loop
    vSQL := 'DROP' || ' ' || R_OBJ.OBJECT_TYPE;
    vSQL := vSQL || ' ' || R_OBJ.OWNER;
    vSQL := vSQL || '.' || R_OBJ.OBJECT_NAME;
      if R_OBJ.OBJECT_TYPE = 'TABLE' then
    vSQL := vSQL || ' CASCADE CONSTRAINTS';
   end if;
begin
    for j in (select object_name from dba_objects where object_name = R_OBJ.OBJECT_NAME) loop
    dbms_output.put_line('Dropando .. '||J.OBJECT_NAME);
end loop;
        execute immediate vSQL;
        exception
        when OTHERS then NULL;
   end;
  end loop;
 end;
     else
      dbms_output.put_line('Erro ao encontrar o banco, o atual eh -> '|| vBaseAtual );
 end if;
end;
/



-- estimar tamanho do DUMP
nohup expdp \'/as sysdba \' DIRECTORY=BACKUP_DUMP ESTIMATE_ONLY=YES schemas=GLOBUS609 logfile=expdp_estimate.log &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES logfile=expdp_estimate.log FULL=Y  &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES COMPRESSION_ALGORITHM=HIGH schemas = SONDAWEB &
nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 DIRECTORY=EXPDUMP ESTIMATE_ONLY=YES schemas=GLOBUS609 logfile=expdp_estimate.log &

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@consinco DIRECTORY=DP ESTIMATE_ONLY=YES FULL=Y &
nohup expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=DUMP ESTIMATE_ONLY=YES FULL=Y &

--Criar parfile  vi parfile.txt

directory=tmpdir
dumpfile=dpnoite%U.dmp
logfile=import.log
full=y
exclude=SCHEMA:"='OUTLN'"
exclude=SCHEMA:"='SYSTEM'"
exclude=SCHEMA:"='SYS'"
exclude=SCHEMA:"='SI_INFORMTN_SCHEMA'"
exclude=SCHEMA:"='OLAPSYS'"
exclude=SCHEMA:"='ORDPLUGINS'"
exclude=SCHEMA:"='CTXSYS'"
exclude=SCHEMA:"='ORDSYS'"
exclude=SCHEMA:"='XDB'"
exclude=SCHEMA:"='EXFSYS'"
exclude=SCHEMA:"='ANONYMOUS'"
exclude=SCHEMA:"='ORDDATA'"
exclude=SCHEMA:"='OWBSYS'"
exclude=SCHEMA:"='OWBSYS_AUDIT'"
exclude=SCHEMA:"='APEX_030200'"
exclude=SCHEMA:"='APPQOSSYS'"
exclude=SCHEMA:"='WMSYS'"
exclude=SCHEMA:"='MDSYS'"
exclude=SCHEMA:"='DMSYS'"
exclude=SCHEMA:"='FLOWS_FILES'"
exclude=SCHEMA:"='SYSMAN'"
exclude=SCHEMA:"='DBSNMP'"
exclude=SCHEMA:"='SPATIAL_WFS_ADMIN_USR'"
exclude=SCHEMA:"='SPATIAL_CSW_ADMIN_USR'"
exclude=SCHEMA:"='APEX_PUBLIC_USER'"
exclude=SCHEMA:"='DIP'"
exclude=SCHEMA:"='ORACLE_OCM'"
exclude=SCHEMA:"='MDDATA'"
exclude=SCHEMA:"='XS$NULL'"
exclude=SCHEMA:"='TSMSYS'"
exclude=SCHEMA:"='WKSYS'"
exclude=SCHEMA:"='APEX_050100'"
exclude=SCHEMA:"='APEX_LISTENER'"
exclude=SCHEMA:"='WG5CAD'"
exclude=SCHEMA:"='WG5CLI'"
exclude=SCHEMA:"='WG5CSC'"
exclude=SCHEMA:"='WG5SIS'"
exclude=SCHEMA:"='WG5EDW'"
exclude=SCHEMA:"='APEX_180100'"  
exclude=SCHEMA:"='TESTE'"         
exclude=SCHEMA:"='BACKUPDUMP'"        
exclude=SCHEMA:"='DBM'" 
exclude=SCHEMA:"='PERFSTAT'" 
exclude=SCHEMA:"='GSMADMIN_INTERNAL'"
exclude=SCHEMA:"='BACKUP'"
exclude=SCHEMA:"='OJVMSYS'"
exclude=SCHEMA:"='SOLWMS'"
exclude=SCHEMA:"='XBASESAC'" 



impdp parfile=parfile.txt


-- grant no directory
GRANT READ,WRITE ON DIRECTORY PLANASUN TO CONSINCO;

[oracle@dm01db03 scripts]$ cat export_syspergamum.sh
#!/bin/bash
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/dbhome_1
export ORACLE_SID=racnovo1
expdp \"/ as sysdba\" directory=ORACLE_BASE dumpfile=RMAN_CATLAOG_BKP.dmp logfile=RMAN_CATLAOG_BKP.log  schemas=RMAN;

FILESIZE=750MB FILE=exp_f1.dmp,exp_f2.dmp, exp_f3.dmp,exp_f4.dmp FULL=Y DIRECT=Y LOG=exp_full.log 

-- DUMP
expdp \"/ as sysdba\" directory=RS00871095 dumpfile=RS00871095_%U.dmp logfile=LOG_RS00871095.log TABLES=ODB.PN_MASTER;

expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_periodicidade.dmp LOGFILE=LOG_C7287492_obr_periodicidade.log TABLES=SYNCHRO.obr_periodicidade
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obrigacao_fiscal.dmp LOGFILE=LOG_C7287492_obr_obrigacao_fiscal.log TABLES=SYNCHRO.obr_obrigacao_fiscal
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obr_ametro.dmp LOGFILE=LOG_C7287492_obr_obr_parametro.log TABLES=SYNCHRO.obr_obr_parametro


--DIRECTORY=diretorio que ser� salvo o arquivo
--DUMPFILE=arquivo dump que sera gerado
--LOGFILE=arquivo de log que ser� gerado
--TABLES=nome da tabela que ser� gerada  *caso seja mais de uma tabela, pode ser add da seguinte forma: TABLES=SYNCHRO.OBR_NFE_CTRL_VERSAO,SYNCHRO.OBR_NFE_CTRL_VERSAO2,...

expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_periodicidade.dmp LOGFILE=LOG_C7287492_obr_periodicidade.log TABLES=SYNCHRO.obr_periodicidade
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obrigacao_fiscal.dmp LOGFILE=LOG_C7287492_obr_obrigacao_fiscal.log TABLES=SYNCHRO.obr_obrigacao_fiscal
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obr_ ametro.dmp LOGFILE=LOG_C7287492_obr_obr_parametro.log TABLES=SYNCHRO.obr_obr_parametro



expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7294003_RANKING.dmp LOGFILE=LOG_C7287906_RANKING.log PROCEDURE=USRCAMPANHA.RANKING

expdp \'/as sysdba \' DIRECTORY=BKP_DIR DUMPFILE=C7294003_SABRECCH.dmp CONTENT=METADATA_ONLY LOGFILE=LOG_C7289430_NFE.log SCHEMAS=NFE


--TRAS APENAS A ESTRUTURA - METADATA_ONLY
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

-- export/import PDB ORARCU
nohup expdp system/T7UcVp20#24#@PDBRCUPRE FULL=Y directory=EXPORT dumpfile=PDBRCUPRE.dmp logfile=PDBRCUPRE.log &
nohup impdp system/T7UcVp20#24#@PDBRCUPRE_A FULL=Y directory=EXPORT dumpfile=PDBRCUPRE.dmp logfile=PDBRCUPRE.log &

PDBRCUPRE_A =
  (DESCRIPTION =
    (ADDRESS_LIST =
    (ADDRESS = (PROTOCOL = TCP)(HOST = exacc01-kpv-hom-db01.adcorp.intranet)(PORT = 1521))    )
    (CONNECT_DATA =
     (SERVICE_NAME = PDBRCUPRE.adcorp.intranet)
     (UR=A)
    )
  )


--ORACLE 9i
nohup exp tech4b/dba01dba owner=OP1Q file=CCH0013577_OP1Q.dmp LOG=LOG_CCH0013577_OP1Q.log &

nohup imp tech4b/dba01dba fromuser=OP1Q touser=OP1Q file=CCH0013577_OP1Q.dmp LOG=LOG_CCH0013577_OP1Q.log &


expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_sit_exemp.dmp LOGFILE=LOG_C7291482_hist_sit_exemp.log TABLES=SYSPERGAMUM.hist_sit_exemp
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_local_exemplar.dmp LOGFILE=LOG_C7291482_hist_local_exemplar.log TABLES=SYSPERGAMUM.hist_local_exemplar
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_hist_bib_exemplar.dmp LOGFILE=LOG_C7291482_hist_bib_exemplar.log TABLES=SYSPERGAMUM.hist_bib_exemplar
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_exemplar_pergamum.dmp LOGFILE=LOG_C7291482_exemplar_pergamum.log TABLES=SYSPERGAMUM.exemplar_pergamum
expdp \'/as sysdba \' DIRECTORY=BACKUP DUMPFILE=C7291482_acervo_classificacao.dmp LOGFILE=LOG_C7291482_acervo_classificacao.log TABLES=SYSPERGAMUM.acervo_classificacao


expdp \'/as sysdba \' DIRECTORY=DUMP_CHANGE DUMPFILE=TDTDAZULDB_C7338168.dmp LOGFILE=LOG_TDAZULDB_C7338168.log full=Y


nohup expdp \'/as sysdba \' directory=dump_apex dumpfile=apex_bkp_full.dmp logfile=log_apex_bkp_full.log full=Y &
nohup expdp system/password schemas=SCHEMA directory=EXP_DIR dumpfile=schema_12c.dmp logfile=schema_12c.log version=12.2 content=all

nohup expdp \'/as sysdba \' directory=dump_apex dumpfile=apex_bkp_full.dmp logfile=log_apex_bkp_full.log schemas=flows_files,apex_public_user,apex_instance_admin_user,apex_180100,spatial_csw_admin_usr &
impdp \'/as sysdba \' directory=dump_apex dumpfile=apex_bkp_full.dmp logfile=log_apex_imp.log  version=12.2 schemas=APEX_180100 content=METADATA_ONLY transform=oid:n

expdp \'/as sysdba \' DIRECTORY=DUMP_APEX DUMPFILE=APEX_BKP_FULL.dmp LOGFILE=LOG_APEX_BKP_FULL.log schemas=APEX_180100 version=12.2
exp '"/ as sysdba"' file=/u02/backup/APEX_BKP_FULL.dmp LOG=LOG_APEX_EXP.log FULL=Y

impdp system/password \
  directory=EXP_DIR \
  dumpfile=schema_12c.dmp \
  logfile=imp_meta.log \
  content=METADATA_ONLY \
  transform=oid:n
imp '"/ as sysdba"' file=APEX_BKP_FULL.dmp LOG=LOG_APEX_IMP.log FULL=Y
 
impdp \'/as sysdba \'
directory=KVIDA
dumpfile=CVP01.V6313.DMP 
logfile=CVP01.V6313.IMPDP.LOG 
remap_tablespace=KIPREV_DATA1:<SUA_TABLESPACE_PARA_DADOS> 
remap_tablespace=KIPREV_IND1:<SUA_TABLESPACE_PARA_INDICES>


--Criação de directory
create directory DUMP as '/acfs01/dbaas_acfs/bkp_dump';

create directory DUMP as '/restore_tmp';

create or replace directory DUMP_CHANGE as '/d01dmp/d01dmp/expdp/C7287319'


-- Gerar backup/dump com arquivos de 2gb cada
nohup expdp '"/ as sysdba"' directory=directory_name dumpfile=backup_name_%u.dmp logfile=log_name_%u.log full=yes filesize=2g parallel=3 job_name=expfull &

nohup expdp '"/ as sysdba"' directory=directory_name dumpfile=backup_name_%u.dmp logfile=log_name_%u.dmp filesize=2g job_name=expfull &

nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=backup_name_%u.dmp logfile=log_import.log REMAP_TABLESPACE=DADOS:SYSTEM REMAP_SCHEMA=oracle:system;

-- hml
expdp \'/as sysdba \'  directory=DUMP001 dumpfile=BKP_RF_BUT0CC.dmp logfile=BKP_RF_BUT0CC.log tables=SAPSR3.BUT0CC

--prd
expdp \'/as sysdba \'  directory=DUMP dumpfile=BKP_RF_BUT0CC.dmp logfile=BKP_RF_BUT0CC.log tables=SAPSR3.BUT0CC

exp \'/as sysdba \'  directory=DUMP file=CCH0013577_OP1Q.dmp LOG=LOG_CCH0013577_OP1Q.log tables=SAPSR3.BUT0CC


exp TABLES=SAPSR3.BUT0CC FILE=bkp_SAPSR3.BUT0CC.dmp


nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=BKP_RF_BUT0CC.dmp logfile=BKP_RF_BUT0CC.log tables=SAPSR3.BUT0CC



nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=OBJECT_KIPREV_DEV.dmp logfile=log_import_dev_261224.log


nohup impdp '"/ as sysdba"' directory=DUMP_RCU dumpfile=full_rcu_export.dmp logfile=log_import_rcu.log
nohup impdp '"/ as sysdba"' directory=DUMP_BDWEB dumpfile=full_BDWEB_export.dmp logfile=log_import_bdweb.log

impdp '"/ as sysdba"' directory=DUMP_BDWEB dumpfile=full_BDWEB_export.dmp logfile=log_import_bdweb.log SCHEMAS=APEX_040200

SELECT o.status, o.object_id, o.object_type, o.owner||'.'||object_name 
FROM dba_objects o, dba_datapump_jobs j 
WHERE o.owner=j.owner_name
AND o.object_name=j.job_name; 

--PARFILE gerar arquivo para ver estimativa de tamanho do DUMP

expdp parfile=DUMP_TRAX.par

--NO BANCO EXECUTAR O COMANDO PARA VERIFICAR QUAL O JOB EM EXECUÇÃOO
set lines 800 pages 5000
col OWNER_NAME for a25
col JOB_NAME for a35
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
nohup expdp 'DBSKYONE/Sky#n35eCwr7t!' directory=EXPDUMP ESTIMATE_ONLY=YES FULL=Y &

nohup expdp \'/as sysdba@MEGABILD \' DIRECTORY=DUMP DUMPFILE=RS00884043_SONDANET_SONDAWEB.dmp LOGFILE=RS00884043_SONDANET_SONDAWEB_LOG.log VERSION=11.2 schemas=SONDAWEB &

nohup expdp sys@ORAPDB1 DIRECTORY=RCU_DEV_DIR DUMPFILE=DMP_ORARCU_07072025.dmp LOGFILE=DMP_ORARCU_07072025_LOG.log FULL=Y &
nohup impdp '"sys@PDBRCUPRD as sysdba"' DIRECTORY=RCU_DUMP DUMPFILE=DMP_ORARCU_07072025.dmp LOGFILE=DMP_ORARCU_07072025_LOG_Import.log &


nohup expdp '"/ as sysdba"' directory=DMP_DB dumpfile=backup_PERFSTAT.dmp logfile=log_bkp_PERFSTAT.log schemas=PERFSTAT &


nohup impdp \'/as sysdba \' directory=DUMP dumpfile=restore_table_RS00859701.dat LOGFILE=LOG_import_RS00859701.log TABLES=TOTVSRECH.SE2040,TOTVSRECH.Z08040,TOTVSRECH.Z0D040

remap_table=schema.table_name:new_table


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

-- 577271 backup (SANTO ANTONIO TRANSPORTES)
nohup expdp '"/ as sysdba"' directory=EXPDUMP dumpfile=GLOBUS179_091021.dmp logfile=log_expdp_GLOBUS179.log schemas=GLOBUS179 EXCLUDE=STATISTICS &
nohup expdp '"/ as sysdba"' directory=EXPDUMP dumpfile=GLOBUS179_091021-11.dmp logfile=log_expdp_GLOBUS179-11.log schemas=GLOBUS179 EXCLUDE=STATISTICS VERSION=11.2.0.4 &

-- 591724 REFRESH HOMOLOG
nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 directory=EXPDUMP dumpfile=HOMOLOG.dmp logfile=HOMOLOG_LOG.log schemas=HOMOLOG EXCLUDE=STATISTICS &

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 directory=EXPDUMP dumpfile=AGROCP.dmp logfile=AGROCP_LOG.log schemas=AGROCP EXCLUDE=STATISTICS &

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 directory=EXPDUMP dumpfile=AGROCP.dmp logfile=AGROCP_LOG_IMPDP.log remap_schema=AGROCP:HOMOLOG remap_tablespace=SIAGRI_DATA:HOMOLOG transform=OID:N &

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@pdb directory=EXP_IMP dumpfile=EXPDP_GDT_06112021.DMP logfile=EXPDP_GDT_06112021_LOG.DMP SCHEMAS=PADRAO,LINNER,SUPERVISOR,SIMPLIFICACAO,TERRA  &

expdp '"/ as sysdba"' directory=DUMP dumpfile=SIAGRI_NATRI.dmp logfile=SIAGRI_NATRI_L.log schemas=NUTRI EXCLUDE=STATISTICS

impdp 'DBSKYONE/Sky#n35eCwr7t!'@nutri directory=DUMP dumpfile=SIAGRI_NATRI.dmp logfile=SIAGRI_NATRI_LOG_IMPDP.log remap_schema=NUTRI:NUTRI remap_tablespace=SIAGRI_DATA:SIAGRI_DATA

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@megacolorado directory=DP dumpfile=megacolorado.dmp logfile=megacolorado_export.log full=y EXCLUDE=STATISTICS;

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@TSTCOLORADO directory=DP dumpfile=megacolorado.dmp logfile=megacolorado_impdp.log full=y &

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@TSTCOLORADO directory=DP dumpfile=megacolorado.dmp logfile=megacolorado_impdp.log remap_tablespace=PDBTEMP:TEMP schemas=BACKUP,IGORDBM,STM,LBACSYS,MGSYS,MGWPD,GSMADMIN_INTERNAL,MGFRO,MGINS,MGEBS,MGPROJ,MGLOJ,MGESC,MGCSP,MGGER,MGRMT,MGCSC,WMSYS,MEGASOA,DBM,MGORC,MGNFE,MGCRR,MGBAL,MGCTT,MGCBA,MGCLI,MGWEB,ORDDATA,MGCTO,MGOPF,MGPGE,DBM_LOG,MGPGC,MGECF,MGATI,MEGAECF,MGRH,MGMAN,MEGAECF14,MGTRA,MGEMP,MGVEN,MDSYS,MGCWB,MGADO,MGAGR,MGNFS,MGADM,MEGA,MGCSZ,MGTRF,MGCRM,MGCMR,MGMAG,MGINT,MGCUSTOM,CWEB,MGPGW,MGADT,MGFIN,MGCON,MGREL,MGGLO,MGCAR,MGDBM &

--#608016 ti@santoniotransp.com.br
nohup expdp '"/ as sysdba"' directory=EXPDUMP dumpfile=Dump_Schema_GLOBUS179_04_12_21.dmp logfile=Log_Export_GLOBUS179_04_12_21.log schemas=GLOBUS179 EXCLUDE=STATISTICS VERSION=11.2.0.4 &

-- #613980 Acesso banco de dados
nohup expdp '"/ as sysdba"' directory=DUMP dumpfile=dump_jcturismo_full.dmp logfile=dump_jcturismo_full_log.log full=Y EXCLUDE=STATISTICS VERSION=11.2.0.4 &



-- #618853 Atualização de Base
impdp '"/ as sysdba"' directory=DMP_NOW dumpfile=dpnoite_arcoiris%U.dmp logfile=import_dump_ARCOIRIS.log schemas=ARCOIRIS &


--ASUN #621012 Atualização Banco Base de Teste

nohup expdp '"/ as sysdba"' directory=DUMP filesize=100g dumpfile=bkp_consinco_asun_%U.dmp logfile=bkp_consinco_asun_log.log schemas=CONSINCO parallel=3 exclude=statistics &

nohup impdp '"/ as sysdba"' directory=DUMP2 dumpfile=bkp_consinco_asun_%U.dmp logfile=impdp_bkp_consinco_asun_log.log VERSION=12.0 schemas=CONSINCO &


nohup expdp '"/ as sysdba"' directory=DUMP dumpfile=bkp_table_asun_%U.dmp logfile=expdp_bkp_table_asun_log.log tables=CONSINCO.PDV_MOVTOFINANCEIRO,CONSINCO.PDV_DOCTOITEM,CONSINCO.MRL_PRODUTOEMPEXPED_RC147990,CONSINCO.MRL_PRODUTOEMPRESA,CONSINCO.MON_AUXITEMREMOVIDO,CONSINCO.AS_INATIVARMIX exclude=statistics &

impdp '"/ as sysdba"' directory=DUMP2 dumpfile=bkp_table_asun_%U.dmp logfile=impdp_bkp_table_asun_log.log tables=CONSINCO.PDV_MOVTOFINANCEIRO,CONSINCO.PDV_DOCTOITEM,CONSINCO.MRL_PRODUTOEMPRESA,CONSINCO.MON_AUXITEMREMOVIDO VERSION=19.0


exp 'DBSKYONE/Sky#n35eCwr7t!' TABLES=CONSINCO.MON_AUXITEMREMOVIDO FILE=bkp_MON_AUXITEMREMOVIDO_asun_01.dmp


imp '"/ as sysdba"' FILE=bkp_MON_AUXITEMREMOVIDO_asun_01.dmp FROMUSER=CONSINCO TABLES=MON_AUXITEMREMOVIDO

expdp '"/ as sysdba"' directory=DUMP dumpfile=bkp_MON_AUXITEMREMOVIDO_asun_02.dmp logfile=expdp_table_asun_log.log tables=CONSINCO.MON_AUXITEMREMOVIDO exclude=statistics

impdp '"/ as sysdba"' directory=DUMP2 dumpfile=bkp_MON_AUXITEMREMOVIDO_asun_02.dmp logfile=impdp_table_asun_log.log tables=CONSINCO.MON_AUXITEMREMOVIDO
bkp_MON_AUXITEMREMOVIDO_asun_02.dmp


expdp \"/ as sysdba\" directory=EXPDUMP dumpfile=EXP_CENTRAL_3112021.DMP logfile=EXP_CENTRAL_31122021.LOG schemas=CENTRAL EXCLUDE=STATISTICS flashback_time=systimestamp




-- #636114 Refresh na Base TESTE


expdp \"/ as sysdba\" directory=ORACLE_BASE dumpfile=RMAN_CATLAOG_BKP.dmp logfile=RMAN_CATLAOG_BKP.log  schemas=RMAN;

impdp \"/ as sysdba\" directory=ORACLE_BASE dumpfile=RMAN_CATLAOG_BKP.dmp logfile=RMAN_CATLAOG_IMP.log schemas=RMAN remap_schema=RMAN:CVP_KPV_PRD transform=OID:N



expdp 'dbskyone/Sky#n35eCwr7t!'@orcl_pdb directory=expdump dumpfile=EXP_AMERICA_24022022.DMP logfile=EXP_AMERICA_24022022.LOG schemas=AMERICA exclude=statistics



nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@UNIAGRO directory=DUMP dumpfile=UNIAGRO_FULL.dmp logfile=UNI_FULL_LOG.log full = Y EXCLUDE=STATISTICS

----

nohup expdp \"/ as sysdba\" directory=DUMP dumpfile=san_michel_03-03-22_%U.dmp logfile=log_bkp_sanmichel.log FILESIZE=20G full=Y EXCLUDE=STATISTICS &

----

nohup impdp '"/ as sysdba"' directory=DMP_01 dumpfile=dpnoite%U.dmp logfile=impdp_bkp_bild_log.log schemas=BILD &

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@IMPORTbild directory=EXPDUMP dumpfile=dptables_now.dmp logfile=megahom_log_tables.log tables=BILD.MEG_TEMP_E251GA010AC00,BILD.MEG_TEMP_E249GA010AC00,BILD.MEG_TEMP_E241GA010AC00,BILD.MEG_TEMP_E229GA010AC00,BILD.MEG_TEMP_M228GAC010A00,BILD.MEG_TEMP_M242GAC010A00,BILD.MEG_TEMP_M248GAC010A00,BILD.MEG_TEMP_M250GAC010A00 EXCLUDE=STATISTICS &


impdp '"/ as sysdba"' directory=DMP_01 dumpfile=dptables_now.dmp logfile=megahom_log_tables.log tables=BILD.MEG_TEMP_E251GA010AC00,BILD.MEG_TEMP_E249GA010AC00,BILD.MEG_TEMP_E241GA010AC00,BILD.MEG_TEMP_E229GA010AC00,BILD.MEG_TEMP_M228GAC010A00,BILD.MEG_TEMP_M242GAC010A00,BILD.MEG_TEMP_M248GAC010A00,BILD.MEG_TEMP_M250GAC010A00

--#674995
expdp 'DBSKYONE/Sky#n35eCwr7t!'@XEPDB1 directory=BACKUP dumpfile=conexao_agro.dmp logfile=expdp_conexao_agro.log schemas=CONEXAO EXCLUDE=STATISTICS
expdp DBSKYONE@XEPDB1 directory=BACKUP dumpfile=conexao_agro.dmp logfile=expdp_conexao_agro.log schemas=CONEXAO EXCLUDE=STATISTICS

impdp DBSKYONE@XEPDB1 directory=BACKUP dumpfile=conexao_agro.dmp logfile=impdp_conexao_agro.log remap_schema=CONEXAO:TREINO remap_tablespace=SIAGRI_DATA:TREINO transform=OID:N

-- #681073 Copia dos Objetos owner consinco.

nohup expdp '"/ as sysdba"' directory=DUMP dumpfile=asun-bkp-full-%U.dmp logfile=asun-bkp-full.log schemas=CONSINCO filesize=100G EXCLUDE=STATISTICS &



nohup impdp '"/ as sysdba"' directory=DUMP01 dumpfile=asun-bkp-full-%U.dmp logfile=asun-impdp.log schemas=CONSINCO &

-- #689448 Migração de banco de dados - Suzantur (Parceiro Praxio)

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 DIRECTORY=EXPDUMP dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=logfile_suzantur-GLOBUS609.log schemas=GLOBUS609 EXCLUDE=STATISTICS &

nohup impdp '"/ as sysdba"' DIRECTORY=EXPDUMP2 dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=impdp_suzantur-GLOBUS609.log schemas=GLOBUS609 VERSION=19.10 &


impdp '"/ as sysdba"' DIRECTORY=EXPDUMP2 dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=impdp_suzantur-GLOBUS609.log schemas=GLOBUS609 VERSION=19.10


impdp '"/ as sysdba"' DIRECTORY=EXPDUMP2 dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=impdp_suzantur-GLOBUS609.log tables=GLOBUS609.TRR_OPERACAOFISCAL_ESTADOS VERSION=19.10


fabricio.bressan@skyone.soluções

-- importa somentefunction,package,procedure,index,view,grant,constraint separadas caso ocorra erros
impdp '"/ as sysdba"' DIRECTORY=EXPDUMP2 dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=impdp_01.log include=function,package,procedure,index,view,grant,constraint

-- importa somente type,trigger, sequences separadas caso ocorra erros
impdp '"/ as sysdba"' DIRECTORY=EXPDUMP2 dumpfile=suzantur-GLOBUS609_bkp-27-03-22.dmp logfile=impdp_01.log schemas=GLOBUS609 include=type,trigger,sequence

expdp \"/ as sysdba\" DIRECTORY=DUMP_ARC dumpfile=EXP_ARCOIRIS_07032022.DMP logfile=EXP_ARCOIRIS_07032022.LOG schemas=ARCOIRIS EXCLUDE=STATISTICS

impdp \"/ as sysdba\" DIRECTORY=DUMP_ARC dumpfile=dpnoite_arcoiris01_11-03-2022.dmp,dpnoite_arcoiris02_11-03-2022.dmp,dpnoite_arcoiris03_11-03-2022.dmp logfile=IMP_ARCOIRIS_07032022.LOG schemas=ARCOIRIS



impdp \"/ as sysdba\" DIRECTORY=DUMP_ARC dumpfile=dpnoite_arcoiris01_11-03-2022.dmp,dpnoite_arcoiris02_11-03-2022.dmp,dpnoite_arcoiris03_11-03-2022.dmp logfile=IMP_ARCOIRIS_07032022.LOG schemas=ARCOIRIS

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@PIERRE directory=DUMP01 dumpfile=dpdump-SMARTCDB-SMARTSRV-17042022_2200_01.dmp logfile=log_impdp_pierre.log &


impdp 'DBSKYONE/Sky#n35eCwr7t!'@PIERRE directory=DUMP01 dumpfile=dpdump-SMARTCDB-SMARTSRV-17042022_2200_01.dmp logfile=impdp_table.log TABLES=AUDSYS."AMGT$DP$AUD$UNIFIED"

impdp 'DBSKYONE/Sky#n35eCwr7t!'@PIERRE directory=DUMP01 dumpfile=dpdump-SMARTCDB-SMARTSRV-17042022_2200_01.dmp logfile=impdp_table.log schemas=AUDSYS TABLES="AMGT$DP$AUD$UNIFIED"


expdp '"/ as sysdba"' directory=BACKUP_DMPNOITE dumpfile=EXP_SENIORH_290422_%u.dmp logfile=EXP_SENIORH_290422.log schemas=SENIORRH exclude=statistics &


nohup impdp '"/ as sysdba"' directory=IMP_SENIOR dumpfile=EXP_SENIORH_290422_01.dmp logfile=impdp_SENIORRH_29-04-22.log schemas=SENIORRH &


nohup expdp '"/ as sysdba"' directory=BACKUP_DMPNOITE dumpfile=EXP_ASSISTE_290422_01.dmp logfile=expdp_ASSISTE_04-05-22.log schemas=ASSISTE exclude=statistics &

nohup impdp '"/ as sysdba"' directory=IMP_SENIOR dumpfile=EXP_ASSISTE_290422_01.dmp logfile=impdp_ASSISTE_04-05-22.log schemas=ASSISTE &



nohup expdp  '"/ as sysdba"' DIRECTORY=EXPDP dumpfile=CIARAMA_now.dmp logfile=expdp_CIARAMA01.log schemas=CIARAMA  exclude=statistics &


impdp  '"/ as sysdba"' DIRECTORY=BACKUP dumpfile=FULL_-04-06-22.dmp logfile=impdp_CIARAMA01.log remap_schema=CIARAMA:TESTE transform=OID:N &

--#750080 [Migração] Backup/Restore - Siagri (Tamburi)


expdp  '"/ as sysdba"' DIRECTORY=BACKUP dumpfile=BKP_TAM-CON-TES-ARMZ-04-06-22.dmp logfile=expdp_tamburi.log 
schemas=TAMBURI,CONTABIL,TESTE,ARMZ exclude=statistics

nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@TAMBURI DIRECTORY=DUMP dumpfile=BKP_TAM-CON-TES-ARMZ-04-06-22.dmp logfile=impdp_tamburi.log &

-- 754362
expdp  '"/ as sysdba"' DIRECTORY=EXPDUMP dumpfile=BKP_FULL_STRACTA_080622.dmp logfile=expdp_sctracta_080622.log full=Y exclude=statistics &


nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@TAMBURI DIRECTORY=DUMP dumpfile=BKP_TAM-CON-TES-ARMZ-04-06-22.dmp logfile=impdp_tamburi.log &

EXPDUMP

 
nohup expdp  '"/ as sysdba"' DIRECTORY=EXP2 dumpfile=GLOBUS483_20-06-22_FULL.dmp logfile=EXPDP_GLOBUS483_20-06-22.log schemas=GLOBUS483 VERSION=11.2 &

#771405 Dump PRD para DEV

nohup expdp 'DBSKYONE/Sky#n35eCwr7t!'@PDB1 directory=DP dumpfile=EXP_lefosse_PRD_771405_300622.dmp logfile=EXP_lefosse_PRD_771405_300622.log EXCLUDE=STATISTICS full=Y &
schemas=LDESK,SISJURI,MIGRACAO,SISJURIHML,LDESK_CUSTOM &


nohup impdp 'DBSKYONE/Sky#n35eCwr7t!'@DEVDB directory=EXPDUMP dumpfile=EXP_lefosse_PRD_771405_300622.dmp logfile=IMPDP_tables.log TABLES=SISJURI.TSC00_1253339931,SISJURI.TSC00_1681626871,SISJURI.TSC00_1088105611,SISJURI.TSC00_215184671,SISJURI.TSC00_2011178691,SISJURI.TSC00_2165241611,SISJURI.TSC00_2294179411,SISJURI.TSC00_2318341481,SISJURI.TSC00_922585881,SISJURI.TSC01_1253339931,SISJURI.TSC01_1238330651,SISJURI.TSC01_215184671,SISJURI.TSC02_1238330651,SISJURI.TSC06_215184671,SISJURI.TSC07_215184671,SISJURI.TSC10_215184671,SISJURI.TSC11_215184671,SISJURI.TSC13_2172551521,SISJURI.TSC16_215184671,SISJURI.TSC17_215184671,SISJURI.TSC20_215184671,SISJURI.TSC21_215184671 &

TABLES=SISJURI.TSC00_1253339931,SISJURI.TSC00_1681626871,SISJURI.TSC00_1088105611,SISJURI.TSC00_215184671,SISJURI.TSC00_2011178691,SISJURI.TSC00_2165241611,SISJURI.TSC00_2294179411,SISJURI.TSC00_2318341481,SISJURI.TSC00_922585881,SISJURI.TSC01_1253339931,SISJURI.TSC01_1238330651,SISJURI.TSC01_215184671,SISJURI.TSC02_1238330651,SISJURI.TSC06_215184671,SISJURI.TSC07_215184671,SISJURI.TSC10_215184671,SISJURI.TSC11_215184671,SISJURI.TSC13_2172551521,SISJURI.TSC16_215184671,SISJURI.TSC17_215184671,SISJURI.TSC20_215184671,SISJURI.TSC21_215184671 &

-- #772201 Restauração de dump
nohup impdp '"/ as sysdba"'  directory=DUMP_ARC dumpfile=dpnoite_arcoiris01_11-06-2022.dmp,dpnoite_arcoiris02_11-06-2022.dmp,dpnoite_arcoiris03_11-06-2022.dmp logfile=IMPDP_ARCOMIX_01-07-22.log schemas=ARCOIRIS &



nohup impdp '"/ as sysdba"' directory=BACKUP_DMPNOITE dumpfile=dpnoite_dia2.dmp logfile=impdp_dpnoite_dia2.log schemas=CONSINCO remap_schema=CONSINCO:DBSKYONE_IMPDP CONTENT=METADATA_ONLY transform=OID:N &

