-- lista tabelas fragmentadas de um owner
    col CREATED format a20
    col last_analyzed format a20
    col last_ddl_time format a20
    col table_name format a35
    col owner format a20
    col Num_Rows format 9999999999
    col Atual_Mb format 9999999
    col Estimate_MB format 99999999
    col Pct_Frag format 99999
    set lines 750 pages 1000
    set colsep '|'
    Select Dba_Objects.Created,
          Dba_Tables.Last_Analyzed,
          Dba_Objects.last_ddl_time,
          Dba_Objects.owner,
          Dba_Tables.Table_Name as table_name ,
          Dba_Tables.Num_Rows,
          Round(Dba_Tables.Avg_Row_Len) AvgRow_Bytes,
          Round((Dba_Tables.Blocks * '8192') / 1024 / 1024) Atual_Mb,
          Round((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024) Estimate_MB,
          Round(((Dba_Tables.Blocks * '8192') / 1024 / 1024) -
                ((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024)) Frag_Mb,
          Round(((Dba_Tables.Blocks * '8192') -
                (Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len)) /
                (Dba_Tables.Blocks * '8192') * 100) Pct_Frag
    From Dba_Objects, Dba_Tables
    Where Dba_Objects.Object_Name = Dba_Tables.Table_Name
      And Dba_Objects.Owner = Dba_Tables.Owner
      And Dba_Objects.OBJECT_TYPE = 'TABLE'
      and Dba_tables.tablespace_name = 'PSAPSR3'
      And Dba_Tables.table_name = upper('ZCONPREVTRD')
      And Dba_Tables.Blocks >= 10000
      And Dba_Tables.Num_Rows >= 1000
      and (dba_tables.blocks * 8192 / 1024 / 1024) > 10000
    Order By  Atual_Mb asc;

And Dba_Tables.Owner = upper('KIPREV')

-- ou
SELECT *
FROM (
  SELECT
    i.owner,
    i.index_name,
    i.table_name,
    i.num_rows,
    i.blevel,
    i.leaf_blocks,
    ROUND(s.bytes / 1024 / 1024, 2) AS size_mb,
    ROUND((i.leaf_blocks * ts.block_size) / 1024 / 1024, 2) AS used_mb,
    ROUND((1 - ((i.leaf_blocks * ts.block_size) / s.bytes)) * 100, 2) AS pct_wasted,
    ROUND((s.bytes - (i.leaf_blocks * ts.block_size)) / 1024 / 1024, 2) AS wasted_mb
  FROM
    dba_indexes i
    JOIN dba_segments s
      ON i.owner = s.owner
      AND i.index_name = s.segment_name
      AND s.segment_type = 'TABLE'
    JOIN dba_tablespaces ts
      ON i.tablespace_name = ts.tablespace_name
  WHERE
    i.owner NOT IN ('SYS', 'SYSTEM')
    AND i.status = 'VALID'
    AND i.num_rows IS NOT NULL
    AND s.bytes > 0
  ORDER BY
    wasted_mb DESC
)
WHERE ROWNUM <= 20;


--- // ---
set pagesize 5000
set lines 200
SELECT * FROM
(SELECT
    OWNER,
    TABLE_NAME,
    TABLESPACE_NAME,
    NUM_ROWS,
    AVG_ROW_LEN ROWLEN,
    BLOCKS,
    ROUND((AVG_ROW_LEN + 1) * NUM_ROWS / 1000000, 0) NET_MB,
    ROUND(BLOCKS * (8000 - 23 * INI_TRANS) *  (1 - PCT_FREE / 100) / 1000000, 0) GROSS_MB,
    ROUND((BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) - (AVG_ROW_LEN + 1) * NUM_ROWS) / 1000000) "WASTED_MB"
  FROM DBA_TABLES
  WHERE
    NUM_ROWS IS NOT NULL AND
---    OWNER LIKE 'SAP%' AND
    PARTITIONED = 'NO' AND
    (IOT_TYPE != 'IOT' OR IOT_TYPE IS NULL)
  ORDER BY 7 DESC)
WHERE ROWNUM <=40;



select  table_name,round((blocks*8),2)/1024 "size (mb)" ,
round((num_rows*avg_row_len/1024/1024),2) "actual_data (mb)",
       Round(((Dba_Tables.Blocks * '8192') / 1024 / 1024) -
             ((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024)) Frag_Mb
from  dba_tables
where (round((blocks*8),2) > round((num_rows*avg_row_len/1024/1024),2))
order by 2 asc;

-- Habilita as tabelas elegiveis a shrink
select 'alter table '||owner||'.'||table_name||' enable row movement;', 
(round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) diff_KB
from  dba_tables
where round((blocks*8192/1024/1024),2)>1
and (round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) > 250000
order by diff_KB asc;


-- gera script para Shrink
select 'alter table '||owner||'.'||table_name||' shrink space;',
(round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) diff_KB 
from  dba_tables
where round((blocks*8192/1024/1024),2)>1 
and (round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) > 250000
order by diff_KB asc;


-- Analiser LEMs (Linhas Encadeadas ou Migradas derivadas de INSERTS E UPDATES), é quando o oracle migra a linha para outro bloco dentro do mesmo segmento, 
--  e cria uma referência ou ponteiro dentro do bloco antigo para o novo bloco

--Para ver LEMs no nível da instância: 
select value 
from   v$sysstat 
where  name like 'table fetch continued row%';

--Para ver LEMs acessadas por cada sessão do BD: 
SELECT b.sid, b.value
FROM   v$statname a, v$sesstat b
WHERE  a.statistic# = b.statistic#
AND    lower(a.name) = 'table fetch continued row';

--Para ver LEMs acessadas na sua sessão: 
SELECT b.value
FROM   v$statname a, v$mystat b
WHERE  a.statistic# = b.statistic#
AND    lower(a.name) = 'table fetch continued row';

-- Realizar analyse na tabela escolhida para verificar se temos muitos blocos vazios e LEMs
ANALYZE TABLE SAPSR3.APQD COMPUTE STATISTICS;
      -- Apos o ANALYSE TABLE coletar estatisticas
      EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'SAPSR3', TABNAME=>'APQD', cascade=>true, degree=>4);

-- Verificar quantidade de blocos utilizados e vazios e se a tabela possui LEMs
select  blocks "Blocos Usados", empty_blocks "Blocos vazios",  chain_cnt "LEMs", num_rows "Total de Linhas" 
from    dba_tables 
where   owner = 'SAPSR3'
AND     table_name='APQD';

 -- INICIO DA DESFRAGMENTAÇÃO -- 
--MODO 1
-- Realizar o MOVE da tabela, pode lever bastante tempo dependendo da tabela, provavel que irá indisponibilizar a tabela durante o move, irá deixar alguns index com status unusuable.

SELECT 'ALTER TABLE '|| owner || '.'||TABLE_NAME|| ' MOVE;' FROM DBA_TABLES WHERE TABLESPACE_NAME='TSD_MEGA' ORDER BY 1;

ALTER TABLE SAPSR3.APQD  MOVE parallel 5 NOLOGGING;
-- ou move online em Oracle 12c enterprise pra cima
ALTER TABLE SAPSR3.APQD  MOVE ONLINE parallel 4 NOLOGGING;

NOLOGGING
-- Verifica indexes unusuable
SELECT 'ALTER INDEX '||OWNER||'."'||INDEX_NAME||'" REBUILD;' FROM DBA_INDEXES WHERE STATUS = 'UNUSABLE';

-- ou rebuild online versões 12c enterprise pra cima
SELECT 'ALTER INDEX '||OWNER||'."'||INDEX_NAME||'" REBUILD ONLINE;' FROM DBA_INDEXES WHERE STATUS = 'UNUSABLE';

-- Apos o processo realizar coleta de estatistica na tabela.
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'SAPSR3', TABNAME=>'APQD', cascade=>true, degree=>4);

--MODO 2
-- Metodo com shrink - não precisa de espaço extra

-- habilitar row movement é o recurso que permite reorganizar os dados dentro de uma tabela
ALTER TABLE SAPSR3.APQD ENABLE ROW MOVEMENT;

-- shrink sem ajustar a HWM - marca d'agua (não irá eliminar os blocos vazios da tabela) - não trava a tabela
ALTER TABLE SAPSR3.APQD  SHRINK SPACE COMPACT;

-- shrink ajustando a HWM - recomendado executar quando não tiver nenhum usuario ou sistema executando operações DML na tabela pois trava a tabela para operações DML.
ALTER TABLE SAPSR3.APQD SHRINK SPACE;
ALTER TABLE SAPSR3.APQD SHRINK SPACE CASCADE;




/* Scripts para uso*/
set timing on;
col CREATED format a20
col last_analyzed format a20
col last_ddl_time format a20
col table_name format a35
col owner format a20
col Num_Rows format 9999999999
col Atual_Mb format 9999999
col Estimate_MB format 99999999
col Pct_Frag format 99999
set lines 750 pages 1000
set colsep '|'
-- faz o enable row movement
alter table "SAPSR3"."LFBK"    enable row movement;
alter table "SAPSR3"."ZCONSEGTRDSUM"   enable row movement;
alter table "SAPSR3"."ZCONSEGPSA"      enable row movement;
alter table "SAPSR3"."ZCONSEGTRD"      enable row movement;
alter table "SAPSR3"."SXMSCLUP2"       enable row movement;
alter table "SAPSR3"."MLOG$_    " enable row movement;
alter table "SAPSR3"."DFKKINFCO"       enable row movement;
alter table "SAPSR3"."RFBLG"           enable row movement;

-- Faz o shrink space
alter table "SAPSR3"."LFBK"    shrink space cascade;
alter table "SAPSR3"."ZCONSEGTRDSUM"   shrink space cascade;
alter table "SAPSR3"."ZCONSEGPSA"      shrink space cascade;
alter table "SAPSR3"."ZCONSEGTRD"      shrink space cascade;
alter table "SAPSR3"."SXMSCLUP2"       shrink space cascade;
alter table "SAPSR3"."MLOG$_FAGLFLEXA" shrink space cascade;
alter table "SAPSR3"."DFKKINFCO"       shrink space cascade;
alter table "SAPSR3"."RFBLG"           shrink space cascade;

-- Fazer o move
alter table "SAPSR3"."MLOG$_DFKKOP"    move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."ZCONSEGTRDSUM"   move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."ZCONSEGPSA"      move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."ZCONSEGTRD"      move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."SXMSCLUP2"       move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."MLOG$_FAGLFLEXA" move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."DFKKINFCO"       move tablespace PSAPSR3 parallel 5 nologging;
alter table "SAPSR3"."RFBLG"           move tablespace PSAPSR3 parallel 5 nologging;

-- Rebuild dos indices
--ALTER INDEX "SAPSR3"."SYS_IL0000079498C00009$$" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."SYS_IL0000075181C00008$$" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."SYS_IL0000190663C00008$$" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."SXMSCLUP2~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."DFKKINFCO~001" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."DFKKINFCO~Z01" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."DFKKINFCO~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."ZCONSEGPSA~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."RFBLG~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."ZCONSEGTRDSUM~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."ZCONSEGTRD~0" rebuild tablespace PSAPSR3 parallel 5 nologging;
--ALTER INDEX "SAPSR3"."I_MLOG$_DFKKOP" rebuild tablespace PSAPSR3USR parallel 5 nologging;
--ALTER INDEX "SAPSR3"."I_MLOG$_FAGLFLEXA" rebuild tablespace PSAPSR3USR parallel 5 nologging;

-- Faz o disable row movement
alter table "SAPSR3"."MLOG$_DFKKOP"    disable row movement;
alter table "SAPSR3"."ZCONSEGTRDSUM"   disable row movement;
alter table "SAPSR3"."ZCONSEGPSA"      disable row movement;
alter table "SAPSR3"."ZCONSEGTRD"      disable row movement;
alter table "SAPSR3"."SXMSCLUP2"       disable row movement;
alter table "SAPSR3"."MLOG$_FAGLFLEXA" disable row movement;
alter table "SAPSR3"."DFKKINFCO"       disable row movement;
alter table "SAPSR3"."RFBLG"           disable row movement;

-- Volta os indices para parallel 1
--ALTER INDEX "SAPSR3"."SYS_IL0000079498C00009$$" parallel 1;
--ALTER INDEX "SAPSR3"."SYS_IL0000075181C00008$$" parallel 1;
--ALTER INDEX "SAPSR3"."SYS_IL0000190663C00008$$" parallel 1;
--ALTER INDEX "SAPSR3"."SXMSCLUP2~0" parallel 1;
--ALTER INDEX "SAPSR3"."DFKKINFCO~001" parallel 1;
--ALTER INDEX "SAPSR3"."DFKKINFCO~Z01" parallel 1;
--ALTER INDEX "SAPSR3"."DFKKINFCO~0" parallel 1;
--ALTER INDEX "SAPSR3"."ZCONSEGPSA~0" parallel 1;
--ALTER INDEX "SAPSR3"."RFBLG~0" parallel 1;
--ALTER INDEX "SAPSR3"."ZCONSEGTRDSUM~0" parallel 1;
--ALTER INDEX "SAPSR3"."ZCONSEGTRD~0" parallel 1;
--ALTER INDEX "SAPSR3"."I_MLOG$_DFKKOP" parallel 1;
--ALTER INDEX "SAPSR3"."I_MLOG$_FAGLFLEXA" parallel 1;

-- Volta tabelas para parallel 1

-- Coleta de estatistica nas tabelas e indices.
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'SYS_IL0000079498C00009$$',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'SYS_IL0000075181C00008$$',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'SYS_IL0000190663C00008$$',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'SXMSCLUP2~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'DFKKINFCO~001',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'DFKKINFCO~Z01',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'DFKKINFCO~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'ZCONSEGPSA~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'RFBLG~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'ZCONSEGTRDSUM~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'ZCONSEGTRD~0',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'I_MLOG$_DFKKOP',degree=>5);
--execute dbms_stats.gather_index_stats(ownname=>'SAPSR3',indname=>'I_MLOG$_FAGLFLEXA',degree=>5); 

-- Gera o comando para rebuild do indice para o tablespace que o indice ja pertence.
set serveroutput on
begin
for r in (select a.owner, a.index_name, a.tablespace_name,trunc((b.bytes/1024/1024/1024),2) as "Size(GB)" from dba_indexes a join dba_segments b on b.segment_name = a.INDEX_NAME 
where table_name IN ('MLOG$_DFKKOP','ZCONSEGTRDSUM','ZCONSEGPSA','ZCONSEGTRD','SXMSCLUP2','MLOG$_FAGLFLEXA','DFKKINFCO','RFBLG') and a.owner = 'SAPSR3' and a.index_name = b.segment_name
order by "Size(GB)")
loop
dbms_output.put_line('ALTER INDEX "'||r.owner ||'"."'||r.INDEX_NAME||'" rebuild tablespace '||r.TABLESPACE_NAME||' parallel 5 nologging;');
end loop;
end;
/

-- Gera o comando para transformar o indice em paralelo 1.
set serveroutput on
begin
for r in (select owner, index_name, tablespace_name 
from dba_indexes where table_name IN ('MLOG$_DFKKOP','ZCONSEGTRDSUM','ZCONSEGPSA','ZCONSEGTRD','SXMSCLUP2','MLOG$_FAGLFLEXA','DFKKINFCO','RFBLG') and owner = 'SAPSR3')
loop
dbms_output.put_line('ALTER INDEX '||r.owner ||'."'||r.INDEX_NAME||'" PARALLEL 1;');
end loop;
end;
/


alter index KIPREV.IND_PERSONAS_CODPERJURIDICA PARALLEL 1;     


--
col last_analyzed format a20;
select  blocks "Blocos Usados", empty_blocks "Blocos vazios", LAST_ANALYZED, num_rows "Total de Linhas",INITIAL_EXTENT,PARTITIONED
from    dba_tables 
where   owner = 'SAPSR3'
AND     table_name='RFBLG';

Blocos Usados Blocos vazios LAST_ANALYZED        Total de Linhas INITIAL_EXTENT PAR
------------- ------------- -------------------- --------------- -------------- ---
    357419985             0 11-MAR-26                  504808667          16384 NO


select blocks "Blocos Usados", chain_cnt "LEMs",
  num_rows "Total de Linhas"
from   dba_tables
where   owner = 'SAPSR3'
AND     table_name='RFBLG';

ANALYZE TABLE ECOMMERCE.PEDIDO COMPUTE STATISTICS;


set serveroutput on
declare
   v_unformatted_blocks number;
   v_unformatted_bytes number;
   v_fs1_blocks number;
   v_fs1_bytes number;
   v_fs2_blocks number;
   v_fs2_bytes number;
   v_fs3_blocks number;
   v_fs3_bytes number;
   v_fs4_blocks number;
   v_fs4_bytes number;
   v_full_blocks number;
   v_full_bytes number;
begin
   dbms_space.space_usage ('SAPSR3', 'RFBLG', 'TABLE',   
         v_unformatted_blocks, v_unformatted_bytes, v_fs1_blocks, 
         v_fs1_bytes, v_fs2_blocks, v_fs2_bytes, v_fs3_blocks, v_fs3_bytes,               v_fs4_blocks, v_fs4_bytes, v_full_blocks, v_full_bytes);

   dbms_output.put_line('Unformatted Blocks = '||v_unformatted_blocks);
   dbms_output.put_line('FS1 Blocks = '||v_fs1_blocks);
   dbms_output.put_line('FS2 Blocks = '||v_fs2_blocks);
   dbms_output.put_line('FS3 Blocks = '||v_fs3_blocks);
   dbms_output.put_line('FS4 Blocks = '||v_fs4_blocks);
   dbms_output.put_line('Full Blocks = '||v_full_blocks);
end;
/


SET SERVEROUTPUT ON
DECLARE
    v_unformatted_blocks NUMBER;
    v_unformatted_bytes  NUMBER;
    v_fs1_blocks         NUMBER; -- 0 a 25% livre (75-100% ocupado)
    v_fs1_bytes          NUMBER;
    v_fs2_blocks         NUMBER; -- 25 a 50% livre (50-75% ocupado)
    v_fs2_bytes          NUMBER;
    v_fs3_blocks         NUMBER; -- 50 a 75% livre (25-50% ocupado)
    v_fs3_bytes          NUMBER;
    v_fs4_blocks         NUMBER; -- 75 a 100% livre (0-25% ocupado)
    v_fs4_bytes          NUMBER;
    v_full_blocks        NUMBER;
    v_full_bytes         NUMBER;
BEGIN
    DBMS_SPACE.SPACE_USAGE(
        segment_owner      => 'SAPSR3', -- Altere aqui (em maiúsculas)
        segment_name       => 'RFBLG', -- Altere aqui (em maiúsculas)
        segment_type       => 'TABLE',
        unformatted_blocks => v_unformatted_blocks,
        unformatted_bytes  => v_unformatted_bytes,
        fs1_blocks         => v_fs1_blocks,
        fs1_bytes          => v_fs1_bytes,
        fs2_blocks         => v_fs2_blocks,
        fs2_bytes          => v_fs2_bytes,
        fs3_blocks         => v_fs3_blocks,
        fs3_bytes          => v_fs3_bytes,
        fs4_blocks         => v_fs4_blocks,
        fs4_bytes          => v_fs4_bytes,
        full_blocks        => v_full_blocks,
        full_bytes         => v_full_bytes
    );

    DBMS_OUTPUT.PUT_LINE('Blocos | Faixa de Ocupacao Estimada');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    DBMS_OUTPUT.PUT_LINE(v_full_blocks || ' | Totalmente cheios (100%)');
    DBMS_OUTPUT.PUT_LINE(v_fs1_blocks  || ' | Muito cheios (75% a 100% de uso)');
    DBMS_OUTPUT.PUT_LINE(v_fs2_blocks  || ' | Ocupacao Media (50% a 75% de uso)');
    DBMS_OUTPUT.PUT_LINE(v_fs3_blocks  || ' | Baixa Ocupacao (25% a 50% de uso)');
    DBMS_OUTPUT.PUT_LINE(v_fs4_blocks  || ' | Quase vazios (0% a 25% de uso)');
    DBMS_OUTPUT.PUT_LINE(v_unformatted_blocks || ' | Nao formatados');
END;
/


Blocos | Faixa de Ocupacao Estimada
---------------------------------------
356956489 | Totalmente cheios (100%)
3 | Muito cheios (75% a 100% de uso)
2 | Ocupacao Media (50% a 75% de uso)
5 | Baixa Ocupacao (25% a 50% de uso)
1840 | Quase vazios (0% a 25% de uso)
5720 | Nao formatados


SELECT 
    s.owner, 
    s.segment_name, 
    s.bytes/1024/1024/1024 AS total_gb, -- Tamanho físico no disco
    t.num_rows,
    t.avg_row_len,
    ROUND((t.num_rows * t.avg_row_len) / 1024 / 1024 / 1024, 2) AS data_real_gb, -- Estimativa de dados reais
    ROUND((s.bytes - (t.num_rows * t.avg_row_len)) / 1024 / 1024 / 1024, 2) AS gap_gb
FROM dba_segments s
JOIN dba_tables t ON s.segment_name = t.table_name AND s.owner = t.owner
WHERE s.segment_name = 'LFBK' AND s.owner = 'SAPSR3';

OWNER                               SEGMENT_NAME                                    TOTAL_GB   NUM_ROWS AVG_ROW_LEN DATA_REAL_GB     GAP_GB
----------------------------------- --------------------------------------------- ---------- ---------- ----------- ------------ ----------
SAPSR3                              RFBLG                                         2726.12561  504808667        3001      1410.89    1315.24


SELECT segment_name, segment_type, bytes/1024/1024/1024 GB 
FROM dba_segments 
WHERE owner = 'SAPSR3' AND (segment_name = 'RFBLG' OR segment_name IN (SELECT index_name FROM dba_indexes WHERE table_name = 'RFBLG'));

SEGMENT_NAME                                  SEGMENT_TYPE               GB
--------------------------------------------- ------------------ ----------
SYS_IL0000075181C00008$$                      LOBINDEX           .000061035
RFBLG                                         TABLE              2726.12561
RFBLG~0                                       INDEX              20.3755493


SELECT chain_cnt FROM dba_tables WHERE table_name = 'RFBLG' AND owner = 'SAPSR3';SQL>

 CHAIN_CNT
----------
         0


-- Procurar os objetos de um tablespace que estejam mais proximo da HWM para fazer uma desframentação
col OWNER for a25
col SEGMENT_NAME for a45
SELECT *
FROM (
    SELECT
        FILE_ID,
        OWNER,
        SEGMENT_NAME,
        SEGMENT_TYPE,
        MAX(BLOCK_ID + BLOCKS -1) AS END_BLOCK
    FROM DBA_EXTENTS
    WHERE TABLESPACE_NAME = 'PSAPSR3'
    GROUP BY
        FILE_ID,
        OWNER,
        SEGMENT_NAME,
        SEGMENT_TYPE
    ORDER BY END_BLOCK DESC
)
WHERE ROWNUM <= 100;

SELECT file_name,
       bytes/1024/1024/1024 AS current_gb,
       (
         SELECT MAX(block_id + blocks - 1)
         FROM dba_extents
         WHERE file_id = df.file_id
       ) * ts.block_size /1024/1024/1024 AS highwater_gb
FROM dba_data_files df,
     dba_tablespaces ts
WHERE df.tablespace_name = ts.tablespace_name
AND df.tablespace_name = 'PSAPSR3';

----

set timing on
ALTER TABLE "SAPSR3"."DFKKOP" MOVE parallel 15 NOLOGGING;
ALTER TABLE "SAPSR3"."RFBLG" MOVE parallel 5 NOLOGGING;


-- precisa fazer o  NOPARALLEL depois nas tabelas e indices;
ALTER TABLE "SAPSR3"."LFBK" NOPARALLEL;
ALTER INDEX "SAPSR3"."nome_indice" NOPARALLEL;

----

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
'ALTER INDEX "' || i.OWNER || '"."' || i.INDEX_NAME || '" REBUILD NOLOGGING TABLESPACE PSAPSR3750 PARALLEL 15;'
FROM DBA_INDEXES i
JOIN DBA_SEGMENTS s
    ON s.OWNER = i.OWNER
   AND s.SEGMENT_NAME = i.INDEX_NAME
WHERE i.PARTITIONED = 'NO'
AND i.OWNER NOT IN ('SYS','SYSTEM','SYSMAN','XDB','MDSYS')
AND i.TABLESPACE_NAME = 'PSAPSR3'
AND s.SEGMENT_TYPE = 'INDEX'
ORDER BY s.BYTES ASC;

SPOOL OFF;


--
SELECT
'ALTER INDEX "' || OWNER || '"."' || INDEX_NAME || '" LOGGING NOPARALLEL;'
FROM DBA_INDEXES
WHERE TABLESPACE_NAME = 'PSAPSR3I';

-- 
SET LINES 300
COL OWNER FORMAT A20
COL SEGMENT_NAME FORMAT A40
COL SEGMENT_TYPE FORMAT A25
COL FILE_NAME FORMAT A65
WITH extents AS (
    SELECT
        e.FILE_ID,
        df.FILE_NAME,
        e.OWNER,
        e.SEGMENT_NAME,
        e.SEGMENT_TYPE,
        e.BLOCK_ID,
        e.BLOCKS,
        (e.BLOCK_ID + e.BLOCKS - 1) AS END_BLOCK
    FROM DBA_EXTENTS e
    JOIN DBA_DATA_FILES df
        ON df.FILE_ID = e.FILE_ID
    WHERE e.TABLESPACE_NAME = 'PSAPSR3'
),
hwm AS (
    SELECT
        FILE_ID,
        MAX(END_BLOCK) AS HWM_BLOCK
    FROM extents
    GROUP BY FILE_ID
),
segment_size AS (
    SELECT
        OWNER,
        SEGMENT_NAME,
        SEGMENT_TYPE,
        SUM(BYTES)/1024/1024/1024 AS SEGMENT_GB
    FROM DBA_SEGMENTS
    WHERE TABLESPACE_NAME = 'PSAPSR3'
    GROUP BY
        OWNER,
        SEGMENT_NAME,
        SEGMENT_TYPE
)
SELECT
    e.FILE_ID,
    e.FILE_NAME,
    e.OWNER,
    e.SEGMENT_NAME,
    e.SEGMENT_TYPE,
    ROUND(s.SEGMENT_GB,2) AS SEGMENT_GB,
    ROUND((e.END_BLOCK * 8)/1024,2) AS OBJ_END_MB,
    ROUND((h.HWM_BLOCK * 8)/1024,2) AS HWM_MB,
    (h.HWM_BLOCK - e.END_BLOCK) AS BLOCKS_FROM_HWM,
    ROUND((e.BLOCKS * 8)/1024,2) AS EXTENT_MB
FROM extents e
JOIN hwm h
    ON e.FILE_ID = h.FILE_ID
LEFT JOIN segment_size s
    ON s.OWNER = e.OWNER
   AND s.SEGMENT_NAME = e.SEGMENT_NAME
   AND s.SEGMENT_TYPE = e.SEGMENT_TYPE
ORDER BY
    BLOCKS_FROM_HWM ASC,
    SEGMENT_GB DESC
FETCH FIRST 100 ROWS ONLY;


--- // --
índices grandes no topo → REBUILD;
tabelas grandes no topo → MOVE;
LOBSEGMENT → MOVE LOB;
partições grandes → MOVE PARTITION.
------------------------------------

select 'ALTER TABLE ' || owner||'."' ||table_name|| '" MOVE parallel 5 NOLOGGING' from dba_tables where TABLESPACE_NAME ='PSAPSR3';

-- primeiro
alter table "SAPSR3"."ZCD_LOG_CEF_VAL"  move parallel 10 nologging;
ALTER TABLE "SAPSR3"."ZCD_LOG_CEF_VAL" NOPARALLEL;

alter table "SAPSR3"."ZCD_LOG_CEF_VAL"  move parallel 15 nologging;
alter table "SAPSR3"."ZCDT_DFKKOP_LOG"  move parallel 15 nologging;
alter table "SAPSR3"."ZTE_LGMASS_A_IN"  move parallel 15 nologging;

ALTER TABLE "SAPSR3"."ZCD_LOG_CEF_VAL" NOPARALLEL;
ALTER TABLE "SAPSR3"."ZTE_LOG_CEFBOLIN" NOPARALLEL;
ALTER TABLE "SAPSR3"."ZTE_LGMASS_A_IN" NOPARALLEL;


-- Se for particionada ou Lob
select table_owner, table_name, partition_name, tablespace_name, logging, compression from dba_tab_partitions where table_name='ZTE_CEFBOL_MSGS' and table_owner='SAPSR3' order by partition_name;

ALTER TABLE  MOVE PARTITION  PARALLEL 4;



-- Procura os idices da tablea que foi feito o move.
SELECT
' -- MB  ' || ROUND(s.BYTES/1024/1024/1024,2) as GB,
' Tablespace ' || i.TABLESPACE_NAME,
'ALTER INDEX "' || i.OWNER || '"."' || i.INDEX_NAME ||'" REBUILD ONLINE TABLESPACE PSAPSR3750 PARALLEL 15;'  as COMAND_REBUILD
FROM DBA_INDEXES i join dba_segments s on s.segment_name = i.INDEX_NAME
WHERE 
--table_name='ZTE_LGMASS_A_IN' AND
i.tablespace_name = 'PSAPSR3' 
and i.PARTITIONED = 'NO' 
and s.BYTES/1024/1024/1024 > 100
ORDER BY s.BYTES ASC;


ALTER INDEX "SAPSR3"."ZCD_LOG_CEF_VAL~0" REBUILD ONLINE TABLESPACE PSAPSR3750 PARALLEL 15;
ALTER INDEX "SAPSR3"."ZCD_LOG_CEF_VAL~Z0" REBUILD ONLINE TABLESPACE PSAPSR3750 PARALLEL 15;



set timing on;
ALTER INDEX "SAPSR3"."ZTE_LOG_CEFBOLIN~0" REBUILD ONLINE TABLESPACE PSAPSR3750 PARALLEL 5;

--terceiro
ALTER TABLE "SAPSR3"."ZCONSEGDIGTRD" NOPARALLEL;
ALTER INDEX "SAPSR3"."ZTE_LGMASS_A_IN~0" NOPARALLEL;
ALTER INDEX "SAPSR3"."ZTE_LOG_CEFBOLIN~0" NOPARALLEL;

-- Particionado
SELECT 'ALTER INDEX ' || INDEX_NAME || ' REBUILD PARTITION ' ||
                     PARTITION_NAME || ' PARALLEL NOLOGGING;' SQL_TEXT
FROM DBA_IND_PARTITIONS WHERE INDEX_NAME='ZCD_LOG_COMU_COB~0';

SELECT owner, status, object_name, object_type
FROM dba_objects
WHERE object_id = 967990;


---- // --- Antes
NAME                             TOTAL_GB    USED_GB    FREE_GB   PCT_USED   PCT_FREE TYPE
------------------------------ ---------- ---------- ---------- ---------- ---------- ------
DATAC3                             108749      93476      15273  85.956103  14.043897 HIGH
RECOC3                              12083        150      11933 1.24051502  98.759485 HIGH


--- Antes do move na tablespace SAPSR3, 
OWNER                             QTD_IDX   Size(GB)
------------------------------ ---------- ----------
VIMERSON                                3 .000183105
SAPSR3                             105097 7413.18311

--- Antes do move na tablespace PSAPSR3USR, 
OWNER                             QTD_IDX   Size(GB)
------------------------------ ---------- ----------
SAPSR3                                112 1067.75513

--- Antes do move na tablespace PSAPSR3750, 
OWNER                             QTD_IDX   Size(GB)
------------------------------ ---------- ----------
SAPSR3                                658 6368.16681



DEFINE TS_NAME='PSAPSR3'
DEFINE QTD_FILES=10
WITH df AS (
SELECT file_id,
    file_name,
    bytes/1024/1024/1024 current_gb
FROM dba_data_files
WHERE tablespace_name = UPPER('&&TS_NAME')
),
top_extent AS (
SELECT *
FROM (
SELECT
    e.file_id,
    e.owner,
    e.segment_name,
    e.segment_type,
    e.partition_name,
    e.block_id,
    e.blocks,
    (e.block_id + e.blocks - 1) end_block,
    ROW_NUMBER() OVER (
        PARTITION BY e.file_id
        ORDER BY (e.block_id + e.blocks - 1) DESC
    ) rn
FROM dba_extents e
JOIN df d
      ON d.file_id = e.file_id
)
WHERE rn = 1
),
selected_files AS (
    SELECT *
    FROM top_extent
    WHERE segment_type NOT LIKE 'LOB%'
      AND segment_type = 'TABLE'
    ORDER BY end_block DESC
    FETCH FIRST &&QTD_FILES ROWS ONLY
)
SELECT
    s.file_id,
    d.file_name,
    s.owner,
    s.segment_name,
    s.segment_type, 
    '-- MOVE'
    || chr(10) ||
    'ALTER TABLE '
    || s.owner || '.' || s.segment_name
    || ' MOVE TABLESPACE &&TS_NAME;'
    AS move_cmd,    
    '-- RESIZE'
    || chr(10) ||
    'ALTER DATABASE DATAFILE '''
    || d.file_name
    || ''' RESIZE '
    || CEIL((s.end_block * ts.block_size)/1024/1024/1024)
    || 'G;'
    AS resize_cmd
FROM selected_files s
JOIN dba_data_files d
  ON d.file_id = s.file_id
JOIN dba_tablespaces ts
  ON ts.tablespace_name = '&&TS_NAME'
ORDER BY s.end_block DESC;