SET LONG 10000
SET PAGES 0

select dmbs_metadata.get_ddl('&OBJECT_TYPE','&OBJECT_NAME','&OWNER') FROM DUAL;

--PACKAGE
--select dbms_metadata.get_ddl('PACKAGE','NFSE_PADRAO_TBW_PKG','SYNCHRO') DDL FROM DUAL;

--PROCEDURE
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_RIO_JANEIRO_IMP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_RIO_JANEIRO_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_RECIFE_IMP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_RECIFE_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_QUEIMADOS_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_NFE_MACAE_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_PADRAO_WEBISS_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_PADRAO_FLYENOTA_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_FLORIANOPOLIS_SC_IMP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_FLORIANOPOLIS_SC_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_ARACAJU_SE_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_FEIRA_DE_SANTANA_BA_EXP','SYNCHRO') DDL FROM DUAL;
--select dbms_metadata.get_ddl('PROCEDURE','NFSE_ANGRA_DOS_REIS_RJ_EXP','SYNCHRO') DDL FROM DUAL;



select dbms_metadata.get_ddl('PROCEDURE','OBR_ARQMAG_GIF_FLORIANOPOLIS','SYNCHRO') DDL FROM DUAL;

OBR_ARQMAG_GIF_FLORIANOPOLIS
obr_arqmag_gif_florianopolis