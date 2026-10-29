-- indexDPC view poseidon.dpcv_dw_manifesto_matriz 

CREATE INDEX "CONSINCO"."LMSKY_DOCTOFISCAL_02" ON "CONSINCO"."MFL_DOCTOFISCAL" ("DTAHOREMISSAO","INDFATCRUZADO","NROCARGA")
TABLESPACE "TSI_CONSINCO";


CREATE INDEX "CONSINCO"."LMSKY_DOCTOFISCAL_03" ON "CONSINCO"."MFL_DOCTOFISCAL" ("NFECHAVEACESSO","DTAHOREMISSAO")
TABLESPACE "TSI_CONSINCO";


-- Retorna index
UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
OWNER, 
INDEX_NAME, 
INDEX_TYPE, 
TABLE_NAME, 
STATUS,
LAST_ANALYZED
FROM DBA_INDEXES 
WHERE INDEX_NAME='IDX$$_1CE50001';

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
OWNER, 
INDEX_NAME, 
INDEX_TYPE, 
TABLE_NAME, 
STATUS,
LAST_ANALYZED
FROM DBA_INDEXES 
WHERE INDEX_NAME like 'LM%';

-- Retorna o DDL do index
--set heading off;
set echo off;
Set pages 9999;
set long 99999;
set lines 750
col DDL for a150
select dbms_metadata.get_ddl('INDEX',INDEX_NAME,OWNER) as DDL FROM DBA_INDEXES WHERE  TABLE_NAME = 'CUS_PEDPROGENTREGA' and owner='MGCUSTOM'; 


-- Retorna todos indexes da tabela no filtro.
col owner for a15
col TABLE_NAME for a20
col INDEX_TYPE for a8
col INDEX_NAME for a25
SELECT OWNER, INDEX_NAME, INDEX_TYPE, TABLE_NAME, STATUS,LAST_ANALYZED,VISIBILITY,TABLESPACE_NAME
FROM DBA_INDEXES 
WHERE  TABLE_NAME = 'CUS_PEDPROGENTREGA'
and owner = 'CONSINCO';

-- Realiza analise no index.
analyze index  CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 validate structure;

-- Realizar o rebuild
ALTER INDEX CONSINCO.SYS_C0024006  REBUILD online;
ALTER INDEX CONSINCOMONITOR.TB_DOCTOCUPOM_IE2  REBUILD;

-- Realiza analise na tabela
analyze table CONSINCO.SYS_C0024006 validate structure online;

-- Deixa index invisivel
alter index CONSINCO.IDX_LM_TB_CATEGORIA invisible;
-- Deixa index visivel
alter index CONSINCOMONITOR.TB_DOCTO_IE3 VISIBLE;

-- Verifica fragmentação do index.
-- coluna height >=4 ruim
-- Coluca ratio >20 ruim
select round((del_lf_rows/lf_rows)*100,2) ratio, height, lf_blks, lf_rows from index_stats;

col NAME for a15
SELECT name,height,lf_rows,lf_blks,lf_rows_len,lf_blk_len,del_lf_rows,distinct_keys,used_space/1024/1024 used_space FROM INDEX_STATS;

--procura objeto no BD
select 
owner
,object_name
,object_type
,Substr(To_Char(created, 'DD-MM-YY HH24:MI:SS'), 1, 8) created
,last_ddl_time
,timestamp 
,status 
from dba_objects   
where object_name ='&OBJETC';

select 
owner
,object_name
,object_type
,To_Char(created, 'DD-MM-YY HH24:MI:SS') created
,To_Char(last_ddl_time, 'DD-MM-YY HH24:MI:SS') last_ddl_time
,timestamp 
,status 
from dba_objects   
where object_name like 'CUS_PEDPROGENTREGA%';

select count(*) from MGCON.CON_TMP_SALDOANTERIOR;
 
select count(*) from MGCON.CON_TMP_SALDOTEMP;


select * from CONSINCO.ge_auditoriaddl where OSUSER='e4afe93c-5132-433e' and dtahorevento between '09-feb-2022' and '11-feb-2022';

-- index foi eficiente na MAMBO modulo LOCUSWM
CREATE INDEX "CONSINCO"."IDX_LS01_MRL_FAMEMBEMPRESA" ON "CONSINCO"."MRL_FAMEMBEMPRESA"("SEQFAMILIA","QTDEMBALAGEM","NROEMPRESA","CODTARA") 
TABLESPACE "TSI_CONSINCO" online;

alter index CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 invisible;
alter index CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 visible;

-- verificar se é tabela temporaria
select table_name from all_tables where temporary = 'Y' and table_name='MLO_PALETECONTROLSORTERQTDE';

CREATE INDEX "CONSINCO"."IDXLS_NREMPRESA_01" ON "CONSINCO"."MADMV_ABCDISTRIBPROD"("NROEMPRESA") ONLINE
TABLESPACE "TSI_CONSINCO" ;




  CREATE UNIQUE INDEX "MGCUSTOM"."PK_CUS_PEDPROGENTREGA" ON "MGCUSTOM"."CUS_PEDPROGENTREGA" 
  ("ORG_TAB_IN_CODIGO", "ORG_PAD_IN_CODIGO", "ORG_IN_CODIGO", "ORG_TAU_ST_CODIGO", "SER_ST_CODIGO", "PED_IN_CODIGO", "ITP_IN_SEQUENCIA", "IPE_IN_SEQUENCIA")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TSD_MEGA"

  27 - access("CIPE"."ORG_TAB_IN_CODIGO"="IPE"."ORG_TAB_IN_CODIGO" AND "CIPE"."ORG_PAD_IN_CODIGO"="IPE"."ORG_PAD_IN_CODIGO"
            AND "CIPE"."ORG_IN_CODIGO"="IPE"."ORG_IN_CODIGO" AND "CIPE"."ORG_TAU_ST_CODIGO"="IPE"."ORG_TAU_ST_CODIGO" AND
            "CIPE"."SER_ST_CODIGO"="IPE"."SER_ST_CODIGO" AND "CIPE"."PED_IN_CODIGO"="IPE"."PED_IN_CODIGO" AND
            "CIPE"."ITP_IN_SEQUENCIA"="IPE"."ITP_IN_SEQUENCIA" AND "CIPE"."IPE_IN_SEQUENCIA"="IPE"."IPE_IN_SEQUENCIA")