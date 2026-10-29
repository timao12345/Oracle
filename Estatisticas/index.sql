-- indexDPC view poseidon.dpcv_dw_manifesto_matriz 

CREATE INDEX "CONSINCO"."LMSKY_DOCTOFISCAL_02" ON "CONSINCO"."MFL_DOCTOFISCAL" ("DTAHOREMISSAO","INDFATCRUZADO","NROCARGA")
TABLESPACE "TSI_CONSINCO";


CREATE INDEX "CONSINCO"."LMSKY_DOCTOFISCAL_03" ON "CONSINCO"."MFL_DOCTOFISCAL" ("NFECHAVEACESSO","DTAHOREMISSAO")
TABLESPACE "TSI_CONSINCO";

undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('INDEX','FAGLFLEXA~6','SAPSR3') ||chr(10)||';'  as DLL from dual;

BSIS~Z01   
BSIS~0     
FAGLFLEXA~6
FAGLFLEXA~4


-- rebuild index de partição de tabela
SELECT 'ALTER INDEX ' || INDEX_NAME || ' REBUILD PARTITION ' ||
                     PARTITION_NAME || ' PARALLEL NOLOGGING;' SQL_TEXT
FROM DBA_IND_PARTITIONS WHERE INDEX_NAME='PK_PERSONAS';

STATUS = 'N/A'; 

SELECT 'ALTER INDEX '||OWNER||'."'||INDEX_NAME||'" REBUILD ONLINE;' FROM DBA_INDEXES WHERE owner = 'KIPREV' AND TABLE_NAME ='PERSONAS';

select 'alter index '||segment_name||'  rebuild online parallel (degree 14);' from dba_segments where tablespace_name = 'SYSAUX'
and segment_name like '%OPT%' and segment_type='INDEX'
/

ALTER INDEX KIPREV."PK_PERSONASFISICAS" REBUILD ONLINE PARALLEL 64;
ALTER INDEX KIPREV."FK_PERFISICAS_SECTECONOMICOS" REBUILD ONLINE PARALLEL 64;

ALTER INDEX KIPREV."PK_PERSONAS" REBUILD ONLINE PARALLEL 64;
ALTER INDEX KIPREV."IDX_PERSONAS_NOMBRE" REBUILD ONLINE PARALLEL 64

alter index KIPREV.FK_IDPERSON_PARENT_PARENTEZCOS rebuild online  PARALLEL 64 compute statistics;
alter index KIPREV.FK_PERJURIDICAS_SECTECONOMICOS rebuild online  PARALLEL 64 compute statistics;

compute sum of total_mb on report
compute sum of used_mb on report
compute sum of free_mb on report

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where a.TABLE_NAME in ('FO_CONTRIB_HIST')
ORDER BY "Size(GB)";

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where a.owner = 'SAPSR3' and a.TABLESPACE_NAME='PSAPSR3'
ORDER BY "Size(GB)";


-- Retorna index
UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where a.TABLE_NAME='ZCD_LOG_COMU_COB'
ORDER BY "Size(GB)";
WHERE a.INDEX_NAME in ('DFKKOP~1');



col owner for a15
col INDEX_NAME for a50
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where a.TABLE_NAME in ('TEL_PERSONAS_HIST','TEL_PERSONAS','ID_PERSONAS_HIST','ID_PERSONAS','DIR_PERSONAS_HIST','DIR_PERSONAS_EXT','DIR_PERSONAS','PERSONAS_JURIDICAS','PERSONAS_HIST','PERSONAS_FISICAS_HIST','PERSONAS_FISICAS','PERSONAS')
and a.PARTITIONED='NO'
ORDER BY "Size(GB)";

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where a.index_type = 'BITMAP'
ORDER BY "Size(GB)";
WHERE a.INDEX_NAME in ('IDX_TO_CHAR');

-------------------

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
OWNER, 
INDEX_NAME, 
INDEX_TYPE, 
TABLE_NAME, 
STATUS,
LAST_ANALYZED,
TABLESPACE_NAME
FROM DBA_INDEXES 
WHERE INDEX_NAME ='IDX_TO_CHAR';
where TABLE_NAME='IDX_FO_SOLIC_MAN_CERT_DETA001';

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
FROM DBA_INDEXES where LAST_ANALYZED > sysdate -30;

log_date> sysdate -1


select OWNER, count(INDEX_NAME) from DBA_INDEXES group by OWNER order by 2 desc;

col owner for a15
col INDEX_NAME for a35
col DEGREE for a10
col INSTANCES for a10
col table_name for a35
set lines 1000 pages 50000
set colsep ' | '
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
WHERE a.OWNER='SAPSR3'
--and a.PARTITIONED='NO'
and a.TABLESPACE_NAME='PSAPSR3'
ORDER BY "Size(GB)" asc;

col owner for a15
col INDEX_NAME for a35
col DEGREE for a10
col INSTANCES for a10
col table_name for a35
set lines 1000 pages 50000
set colsep ' | '
SELECT 
a.OWNER, 
a.INDEX_NAME, 
a.INDEX_TYPE, 
a.TABLE_NAME, 
a.STATUS,
a.LAST_ANALYZED,
a.PARTITIONED,
DEGREE,
a.INSTANCES,
trunc((b.bytes/1024/1024/1024),2) as "Size(GB)",
b.TABLESPACE_NAME
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
WHERE a.PARTITIONED='NO'
and degree > 1;


-- Retorna o DDL do index
--set heading off;
set echo off;
Set pages 9999;
set long 99999;
set lines 750
col DDL for a150
select dbms_metadata.get_ddl('INDEX',INDEX_NAME,OWNER) as DDL FROM DBA_INDEXES WHERE owner='ADAIL' and TABLE_NAME = 'FO_MAN_HISTORICOS'; 



create index "USR_MS_UCONCILIATION"."IDX_TB_NF_01" ON "USR_MS_UCONCILIATION"."TB_NF"  ("NR_COO","CD_FILIAL","CD_OPERACAO_FISCAL") 
tablespace TSI_UCONCILIATION online;

create index "USR_MS_UCONCILIATION"."IDX_TB_NF_02" ON "USR_MS_UCONCILIATION"."TB_NF" ("CD_FILIAL","NR_CAIXA", "NR_COO","DT_EMISSAO")
tablespace TSI_UCONCILIATION online;

create index USR_MS_PAGTO.IDX_TB_MEIO_PAGAMENTO_01 on USR_MS_PAGTO.TB_MEIO_PAGAMENTO("ID_PAGAMENTO")
tablespace RDINDEXPAGTO online;

-- INDEX
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('INDEX','TB_AUTORIZACAO','USR_MS_UBONUS') ||chr(10)||';'  as DLL from dual;

  CREATE UNIQUE INDEX "A_RAIABD"."TB_PRODUTO_VLR_AGREGADO_PK" ON "A_RAIABD"."TB_PRODUTO_VLR_AGREGADO" ("CD_PRODUTO_VLR_AGREGADO")
  PCTFREE 10 INITRANS 5 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "RAIAINDEXES"
;


-- Retorna todos indexes da tabela no filtro.
col owner for a15
col TABLE_NAME for a20
col INDEX_TYPE for a8
col INDEX_NAME for a25
SELECT OWNER, INDEX_NAME, INDEX_TYPE, TABLE_NAME, STATUS,VISIBILITY,TABLESPACE_NAME
FROM DBA_INDEXES 
WHERE  TABLE_NAME = 'TB_AUTORIZACAO' 
and VISIBILITY='VISIBLE' 
order by INDEX_NAME;
and owner = 'SYSRH';

-- Realiza analise no index.
analyze index "NETWIN"."IDX_EQUIP_DESIGNACAO$SBI"   validate structure online;

analyze index CONSINCO.IDX$$_9BD2000C validate structure online;
 
alter index A_RAIABD.XIF524TB_PEDIDO_COMPRA_ITEM rebuild;   

alter index "NETWIN"."IDX_EQUIP_DESIGNACAO$SBI"  rebuild ONLINE; 

alter index SYSRH.HIE_I00 rebuild ONLINE;                 


-- Realizar o rebuild
ALTER INDEX TEKNISA.ISDB_ENDECLIE   REBUILD online;
ALTER INDEX CONSINCO.RF_NOTAMESTREIE4  REBUILD online;


-- Realiza analise na tabela
analyze table "NETWIN"."IDX_EQUIP_DESIGNACAO$SBI" validate structure online;

-- Deixa index invisivel
alter index GSRETAIL.IDX_LM_TB_CATEGORIA INVISIBLE;
-- Deixa index visivel
alter index CONSINCOMONITOR.TB_DOCTO_IE3 VISIBLE;


set autotrace traceonly explain
select /*+index("FK_NI_INS_ENTITY$SBI")*/ * from NETWIN.NI_DYN_INS_ATTRIBUTE_SBD;



-- Verifica fragmentação do index.
-- coluna height >=4 ruim
-- Coluca ratio >20 ruimq
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
where object_name ='&obj';

select 
owner
,object_name
,object_type
,To_Char(created, 'DD-MM-YY HH24:MI:SS') created
,To_Char(last_ddl_time, 'DD-MM-YY HH24:MI:SS') last_ddl_time
,timestamp 
,status 
,temporary
from dba_objects   
where object_name = '&index' ;

-- retorna tamanho do index.

col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000
col owner for a15
col SEGMENT_NAME for a35
select owner, segment_name, sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_NAME='&INDEX'  
group by owner, segment_name order by 3 asc;

-- calcula tamanho total de todos indices do BD
col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000
col owner for a15
col SEGMENT_NAME for a35
select owner, segment_name, sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_TYPE='INDEX'  
group by owner, segment_name order by 3 asc;



alter index CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 invisible;
alter index CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 visible;

-- verificar se é tabela temporaria
select table_name from all_tables where temporary = 'Y' and table_name='MLO_PALETECONTROLSORTERQTDE';

-- // --


CREATE INDEX "SELIPSE".ALARMS_IDX01 ON "SELIPSE"."ALARMS" ("EVENTTIMEDBL","INTIMEDBL","OUTTIMEDBL")TABLESPACE "TBS_ELIPSE" online;

CREATE INDEX "SELIPSE".ALARMS_IDX02 ON "SELIPSE"."ALARMS" ("EVENTTYPE","ACKED") TABLESPACE "TBS_ELIPSE" online;


STATUS    |OWNER               |TABLE_NAME               |FK_NAME                  |FK_COLUMNS               |INDEX_NAME               |INDEX_COLUMNS
----------|--------------------|-------------------------|-------------------------|-------------------------|-------------------------|-------------------------
unindexed |KIPREV              |FO_CUENTAS               |FK_FOCTA_PACLASSIFPLANO  |COD_CLASSIFICACAO_PLANO  |                         |
unindexed |KIPREV              |AF_ENCA_SOLICITUD        |FK_AFENCASOL_PACLASSIFPLA|COD_CLASSIFICACAO_PLANO  |                         |
unindexed |KIPREV              |FO_MR_SOL_ALT_PARAM_L    |FK_FOMRSOLALTPARAML_SEQPA|SEQ_PARAMETRO            |                         |
unindexed |KIPREV              |FO_MOTOR_RISCO_SOL_ALT_PA|FK_FOMOTRISSOLALTPAR_SEQP|SEQ_PARAMETRO            |                         |
unindexed |KIPREV              |FO_MOTOR_RISCO_PARAM_LIST|FK_FOMOTORISCPARALIST_SEQ|SEQ_PARAMETRO            |                         |
unindexed |KIPREV              |FO_MOTOR_RISCO_PARAMETROS|FK_FOMOTORRISCOPARAM_GRP |COD_GRUPO                |                         |
unindexed |KIPREV              |FO_PORTAB_MOTIVO_HIST    |FK_FOPORTMOTHIST_FOPORTSO|COD_EMPRESA,NUM_PORTABILI|                         |
unindexed |KIPREV              |FO_BLOQUEIO_MANUAL       |FK_TIPOBLOQUEIOMANUAL    |COD_TIPO_BLOQUEIO        |                         |
unindexed |KIPREV              |FO_SOLIC_ALTERACAO_TAF   |FK_FO_SOLIC_ALT_TAF_TRANS|COD_EMPRESA,NUM_TRANSFERE|                         |



SET PAGESIZE 0
SET LINESIZE 32767
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET ECHO OFF
SET TRIMSPOOL ON
SET TERMOUT OFF

SPOOL rebuild_index_for_PSAPSR3I_noredo.sql

SELECT '-- ' || ROUND(s.BYTES/1024/1024,2) || ' MB ' ||
CHR(10) ||
'ALTER INDEX "' || i.OWNER || '"."' || i.INDEX_NAME || '" REBUILD NOLOGGING TABLESPACE PSAPSR3750 PARALLEL 10;'
FROM DBA_INDEXES i
JOIN DBA_SEGMENTS s
    ON s.OWNER = i.OWNER
   AND s.SEGMENT_NAME = i.INDEX_NAME
WHERE i.PARTITIONED = 'NO'
--AND i.OWNER NOT IN ('SYS','SYSTEM','SYSMAN','XDB','MDSYS')
AND i.TABLESPACE_NAME = 'PSAPSR3'
AND s.SEGMENT_TYPE = 'INDEX'
ORDER BY s.BYTES ASC;

SPOOL OFF;


select 'alter index SAPSR3."' || a.index_name ||  '" rebuild partition "' || a.PARTITION_NAME || '" tablespace PSAPSR3I parallel 5;' 
from DBA_IND_PARTITIONS  a, DBA_TAB_PARTITIONS  b where a.partition_name=b.partition_name ;

select OWNER, COUNT (SEGMENT_NAME)as SEGMENT_NAME from dba_segments where segment_type LIKE '%INDEX%' 
GROUP BY OWNER ;

select OWNER, sum (bytes)/1024/1024/1024 as segment_type_gb from dba_segments where segment_type LIKE '%INDEX%' 
GROUP BY OWNER ;


SELECT
a.OWNER,
count(a.INDEX_NAME)QTD_IDX,
sum(b.bytes/1024/1024/1024) as "Size(GB)"
FROM DBA_INDEXES a join dba_segments b on b.segment_name = a.INDEX_NAME
where 
--a.owner = 'SAPSR3' and 
a.TABLESPACE_NAME='PSAPSR3'
group by a.OWNER
ORDER BY "Size(GB)";


select OWNER, TABLESPACE_NAME, count (index_name) QTD_INDEX from dba_indexes
where TABLESPACE_NAME='PSAPSR3'
group by owner, tablespace_name;

set lines 750 pages 1000 
col owner for a25
select OWNER,SEGMENT_TYPE, TABLESPACE_NAME,count(segment_name) QTD, sum(bytes/1024/1024/1024) as "Size(GB)" 
from dba_segments 
where OWNER='SAPSR3'
and TABLESPACE_NAME='PSAPSR3'
group by OWNER,SEGMENT_TYPE,TABLESPACE_NAME order by QTD ASC;


SET PAGESIZE 0
SET LINESIZE 32767
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET ECHO OFF
SET TRIMSPOOL ON
SET TERMOUT OFF

SPOOL back_degree_idx_PSAPSR3750.sql

SELECT
'ALTER INDEX "' || OWNER || '"."' || INDEX_NAME || '" LOGGING NOPARALLEL;'
FROM DBA_INDEXES
where DEGREE > 1
and TABLESPACE_NAME = 'PSAPSR3750';

SPOOL OFF;


SET PAGESIZE 0
SET LINESIZE 32767
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET ECHO OFF
SET TRIMSPOOL ON
SET TERMOUT OFF
spool move_idx_tablespace_ECQ.sql
SELECT
'ALTER INDEX "' || OWNER || '"."' || INDEX_NAME || '" REBUILD NOLOGGING TABLESPACE PSAPSR3750 PARALLEL 10;'
FROM DBA_INDEXES
where  TABLESPACE_NAME = 'PSAPSR3';
SPOOL OFF;



SELECT
 OWNER,INDEX_TYPE, STATUS,count(INDEX_NAME) QTD_IDX
FROM DBA_INDEXES
where TABLESPACE_NAME = 'PSAPSR3'
group by OWNER, INDEX_TYPE,status;