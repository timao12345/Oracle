[oracle@dm01db03 scripts]$ cat export_syspergamum.sh
#!/bin/bash
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/dbhome_1
export ORACLE_SID=racnovo1
expdp \"/ as sysdba\" directory=DUMPSYN dumpfile=sysperg20052015-A%U.dmp logfile=exp-sysperg20052015_.log FILESIZE=20G schemas=SYSPERGAMUM

FILESIZE=750MB FILE=exp_f1.dmp,exp_f2.dmp, exp_f3.dmp,exp_f4.dmp FULL=Y DIRECT=Y LOG=exp_full.log 

expdp \"/ as sysdba\" directory=RS00871095 dumpfile=RS00871095_%U.dmp logfile=LOG_RS00871095.log TABLES=ODB.PN_MASTER;




expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_periodicidade.dmp LOGFILE=LOG_C7287492_obr_periodicidade.log TABLES=SYNCHRO.obr_periodicidade
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obrigacao_fiscal.dmp LOGFILE=LOG_C7287492_obr_obrigacao_fiscal.log TABLES=SYNCHRO.obr_obrigacao_fiscal
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obr_ ametro.dmp LOGFILE=LOG_C7287492_obr_obr_parametro.log TABLES=SYNCHRO.obr_obr_parametro


--DIRECTORY=diretorio que ser� salvo o arquivo
--DUMPFILE=arquivo dump que sera gerado
--LOGFILE=arquivo de log que ser� gerado
--TABLES=nome da tabela que ser� gerada  *caso seja mais de uma tabela, pode ser add da seguinte forma: TABLES=SYNCHRO.OBR_NFE_CTRL_VERSAO,SYNCHRO.OBR_NFE_CTRL_VERSAO2,...

expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_periodicidade.dmp LOGFILE=LOG_C7287492_obr_periodicidade.log TABLES=SYNCHRO.obr_periodicidade
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obrigacao_fiscal.dmp LOGFILE=LOG_C7287492_obr_obrigacao_fiscal.log TABLES=SYNCHRO.obr_obrigacao_fiscal
expdp \'/as sysdba \' DIRECTORY=C7287492 DUMPFILE=C7287492_obr_obr_ ametro.dmp LOGFILE=LOG_C7287492_obr_obr_parametro.log TABLES=SYNCHRO.obr_obr_parametro



expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7294003_RANKING.dmp LOGFILE=LOG_C7287906_RANKING.log PROCEDURE=USRCAMPANHA.RANKING



EXPDP SCHEMA ' OWNER ' 

expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7294003_SABRECCH.dmp CONTENT=METADATA_ONLY LOGFILE=LOG_C7289430_NFE.log SCHEMAS=NFE



*TRAS APENAS A ESTRUTURA - METADATA_ONLY
expdp DIRECTORY=DUMP_WORK_TMP DUMPFILE=C7291881_RM_LIVE.dmp CONTENT=METADATA_ONLY LOGFILE=LOG_C7291881_RM_LIVE.log SCHEMAS=RM_LIVE





expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7298332_SABRECCH.dmp COMPRESSION=ALL LOGFILE=C7298332_LOG_SABRECCH.log SCHEMAS=RM_LIVE


expdp \'/as sysdba \' DIRECTORY=DATA_PUMP DUMPFILE=C7298332_SABRECCH.dmp LOGFILE=C7298332_LOG_SABRECCH.log SCHEMAS=RM_LIVE


expdp \'/as sysdba \' DIRECTORY=EXPORT DUMPFILE=RS00512939_dbsedocs.dmp LOGFILE=LOG_RS00512939_dbsedocs.log SCHEMAS=EDOCS

expdp \'/as sysdba \' DIRECTORY=EXPORT DUMPFILE=RS00512939_dbsenior.dmp LOGFILE=LOG_RS00512939_dbsenior.log SCHEMAS=VETORH



expdp \'/as sysdba \' DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log SCHEMAS=OP1Q



***ORACLE 9i
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


expdp \'/as sysdba \' DIRECTORY=DUMP DUMPFILE=CCH0013577_OP1Q.dmp LOGFILE=LOG_CCH0013577_OP1Q.log TABLES=USRCAMPANHA.RANKING


BACKUP

DUMP_DIR

C7287906



create directory C7287492 as '/d01dmp/d01dmp/expdp/C7287492'

create directory DUMP as '/restore_tmp';



create or replace directory DUMP_CHANGE as '/d01dmp/d01dmp/expdp/C7287319'


DPUMP           /d01dmp/bkp_expdp

/d01dmp/

C7286948



/d01dmp/d01dmp/expdp


/tmp/C7287319


/d01dmp/d01dmp/expdp/C7287319


10.100.3.10 /home/dcadmin/C7287319/dump



****************************************************************

        PARFILE

expdp parfile=DUMP_TRAX.par

***NO BANCO EXECUTAR O COMANDO PARA VERIFICAR QUAL O JOB EM EXECU��O
select * from dba_datapump_jobs;

***AP�S SAIR DO BANCO E EXECUTAR O COMANDO ABAIXO PARA VERIFICAR A EXECU��O
expdp attach=SYS_EXPORT_SCHEMA_15 


nohup expdp \'/as sysdba \' DIRECTORY=DUMP_CHANGE DUMPFILE=RS00884043_SONDANET.dmp LOGFILE=RS00884043_SONDANET_LOG.log full=Y &
nohup expdp "'/ as sysdba'" DIRECTORY=BACKUP_DUMP dumpfile=DUMP_UOL_BACKUP2.dmp logfile=DUMP_UOL_BACKUP_LOG2.log schemas=UOLDIVEO_DBA &
nohup expdp \'/as sysdba \' DIRECTORY=BACKUP_DUMP DUMPFILE=DUMP_UOL_BACKUP3.dmp LOGFILE=DUMP_UOL_BACKUP_LOG3.log TABLES=UOLDIVEO_DBA.LOG_EVENT,UOLDIVEO_DBA.LOG_DESC &

nohup expdp \'/as sysdba \' DIRECTORY=BACKUP_DUMP ESTIMATE_ONLY=YES schemas=UOLDIVEO_DBA logfile=expdp_estimate.log &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES logfile=expdp_estimate.log FULL=Y  &
nohup expdp \'/as sysdba \' DIRECTORY=DUMP ESTIMATE_ONLY=YES COMPRESSION_ALGORITHM=HIGH schemas = SONDAWEB &


nohup expdp \'/as sysdba \' DIRECTORY=DUMP DUMPFILE=RS00884043_SONDANET_SONDAWEB.dmp LOGFILE=RS00884043_SONDANET_SONDAWEB_LOG.log VERSION=11.2 schemas=SONDAWEB &
