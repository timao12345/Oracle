Criando usu�rio no banco de dados origem e destino:

create user refresh_syn identified by estacio account unlock ;
grant create session to refresh_syn;
grant exp_full_database to refresh_syn;
grant imp_full_database to refresh_syn;
grant execute on sys.dbms_defer_import_internal to refresh_syn;
grant execute on sys.dbms_export_extension to  refresh_syn;	
grant connect,resource,recovery_catalog_owner to refresh_syn;


Criando Database Link no database Destino com o usu�rio que ira realizar o import:

Enter user-name: REFRESH_SYN/estacio
refresh_syn@orahmgme > create public database link REFRESH_CATALOG connect to lucas identified by "lucas$2024" using 'DBMON';
refresh_syn@orahmgme > select sysdate from dual@REFRESH_CATALOG;
SYSDATE
-------------------
24/09/2015 17:17:46



/*
sys@SYNHMG > conn
Enter user-name: REFRESH_SYN/estacio
refresh_syn@SYNHMG > create database link REFRESH_SYNHMG connect to REFRESH_SYN identified by estacio using 'racnovo';
refresh_syn@SYNHMG > select sysdate from dual@REFRESH_SYNHMG;
SYSDATE
-------------------
24/09/2015 17:20:41

sys@SYNDSV > conn
Enter user-name: refresh_syn/estacio
refresh_syn@SYNDSV > create database link REFRESH_SYNDSV connect to REFRESH_SYN identified by estacio using 'racnovo';
refresh_syn@SYNDSV > select sysdate from dual@REFRESH_SYNDSV;
SYSDATE
-------------------
24/09/2015 17:22:26
*/

Criação de diretorios e grant de leitura e escrita para o diretorio que ira gravar os logs no banco de dados Destino

sys@SYNHMG > create directory LOGS as '/u04';
sys@SYNHMG > grant read, write on directory LOGS to lucas;



Comando de import deve ser executado do servidor de banco de dados destino:


impdp '"/ as sysdba"' NETWORK_LINK=REFRESH_CATALOG logfile=refresh_catalog_imp.log schemas=LUCAS job_name=refresh_catalog_imp directory=LOGS parallel=8 status=60

create tablespace TBS_MONITOR datafile '+DATAC1';

/*
export ORACLE_SID=SYNHMG
impdp REFRESH_SYN/estacio NETWORK_LINK=REFRESH_SYNHMG   logfile=refresh_synchro_imp_SYNHMG_$TIMESTAMP.log schemas=SYNCHRO job_name=refresh_synchro_SYNHMG_imp directory=LOGS parallel=8 status=60

export ORACLE_SID=SYNDSV
impdp REFRESH_SYN/estacio NETWORK_LINK=REFRESH_SYNDSV   logfile=refresh_synchro_imp_SYNDSV_$TIMESTAMP.log schemas=SYNCHRO job_name=refresh_synchro_SYNDSV_imp directory=LOGS parallel=8 status=60 

Possiveis Erros

NOTA:
DataPump Import Of Tables Containing LONG Columns Using NETWORK_LINK Raises The Error ORA-31679 (Doc ID 1470331.1)


ORA-31693: Table data object "SYNCHRO"."COR_PESSOA" failed to load/unload and is being skipped due to error:
ORA-01400: cannot insert NULL into ("SYNCHRO"."COR_PESSOA"."IND_ORGAO_GOVERNAMENTAL")

ORA-31679: Table data object "SYNCHRO"."SAP_ITF_IDOC_XML_STMT" has long columns, and longs can not be loaded/unloaded using a network link

ORA-31679: Table data object "SYNCHRO"."PLAN_TABLE" has long columns, and longs can not be loaded/unloaded using a network link

ORA-31679: Table data object "SYNCHRO"."SAP_ITF_IDOC" has long columns, and longs can not be loaded/unloaded using a network link

ORA-31679: Table data object "SYNCHRO"."SAP_ITF_IDOC_TABLES" has long columns, and longs can not be loaded/unloaded using a network link
*/


Export e import utilizado para as tabelas com campos Long

nohup expdp \"/as sysdba\" job_name=exp_table_synchro_long directory=DP_SYNCHRO dumpfile=exp_table_synchro_long_$TIMESTAMP_%U log=exp_table_synchro_long.log compression=all PARALLEL=8 status=60 tables=SYNCHRO."COR_DOF_APROVACAO",SYNCHRO."ETAX_DOFIDF_DEBUG",SYNCHRO."OBR_GER_PROTOCOLOS",SYNCHRO."PLAN_TABLE",SYNCHRO."SAP_ITF_IDOC",SYNCHRO."SAP_ITF_IDOC_SQL_STMT",SYNCHRO."SAP_ITF_IDOC_TABLES",SYNCHRO."SAP_ITF_IDOC_XML_OUTPUT",SYNCHRO."SAP_ITF_IDOC_XML_STMT",SYNCHRO."SYN_CUSTOMIZACAO" &      
nohup impdp \"/as sysdba\" job_name=imp_table_synchro_long directory=LOGS  dumpfile=exp_table_synchro_long_$TIMESTAMP_%U logfile=imp_table_synchro_long.log PARALLEL=8 status=60 tables=SYNCHRO."COR_DOF_APROVACAO",SYNCHRO."ETAX_DOFIDF_DEBUG",SYNCHRO."OBR_GER_PROTOCOLOS",SYNCHRO."PLAN_TABLE",SYNCHRO."SAP_ITF_IDOC",SYNCHRO."SAP_ITF_IDOC_SQL_STMT",SYNCHRO."SAP_ITF_IDOC_TABLES",SYNCHRO."SAP_ITF_IDOC_XML_OUTPUT",SYNCHRO."SAP_ITF_IDOC_XML_STMT",SYNCHRO."SYN_CUSTOMIZACAO" TABLE_EXISTS_ACTION=REPLACE &      
nohup impdp \"/as sysdba\" job_name=imp_table_synchro_long2 directory=LOGS  dumpfile=exp_COR_PESSOA_$TIMESTAMP_%U logfile=imp_table_synchro_long2.log PARALLEL=8 status=60 tables="SYNCHRO"."COR_PESSOA"

Copiando arquivos

scp exp_COR_PESSOA_* oracle@10.10.20.66:/StageDEV/expdp_logs/ 



