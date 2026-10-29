-- Verifica estatisticas de tabela de todos owners do BD com filto de 10 dias atrás
set lines 800 pages 10000
select distinct 'exec dbms_stats.gather_table_stats(ownname=> ' ||''''|| a.owner ||''''|| ', tabname=>'|| '''' || '"' || a.table_name || '"' || '''' || ', partname=> null)'|| '/*' ||a.last_analyzed||' */;'
from dba_tables a, dba_objects c
where (a.last_analyzed is null or a.last_analyzed < sysdate -10)
AND a.OWNER not in ('APPQOSSYS','ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS','MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB','PUBLIC','ORACLE_OCM', 'PERFSTAT', 'GSMADMIN_INTERNAL', 'AUDSYS', 'OJVMSYS', 'DBSFWUSER', 'ORDDATA', 'DVSYS', 'APEX_040200')
and a.temporary = 'N'
and a.table_name not in (select table_name from dba_external_tables)
and c.created < trunc(sysdate-10)
and a.table_name=c.object_name;

-- verifica estatisticas de tabela por owner de 2 dias atrás
set lines 9000 
col query for 9999999999999999999
select distinct 'exec dbms_stats.gather_table_stats(ownname=> ' ||''''|| a.owner ||''''|| ', tabname=>'|| '''' || '"' || a.table_name || '"' || '''' || ', partname=> null)'|| '/*' ||a.last_analyzed||' */;' as Query
from dba_tables a, dba_objects c
where (a.last_analyzed is null or a.last_analyzed > sysdate - 100)
AND a.OWNER='KIPREV' 
and a.temporary = 'N'
and a.table_name not in (select table_name from dba_external_tables)
and a.table_name=c.object_name;


-- tudo que teve movimenação após o último analyze
set lines 800 pages 10000
alter session set "_optimizer_adaptive_plans"=false;
select 'exec dbms_stats.gather_table_stats(ownname=>' || ''''|| '"' || table_owner ||'"'|| ''',tabname=>''' ||'"'|| table_name||decode(partition_name,null,'','.'||partition_name) ||'"' || ''', METHOD_OPT=>''FOR ALL COLUMNS SIZE AUTO'',degree=>15);'
  from (select a.*,
               nvl(decode(num_rows, 0, '-1', 100 * tot_updates / num_rows), -1) perc_updates
          from (select (select num_rows
                         from dba_tables
                        where dba_tables.table_name = DBA_TAB_MODIFICATIONS.table_name
                          and DBA_TAB_MODIFICATIONS.table_owner = dba_tables.owner) num_rows,
                       (select last_analyzed
                          from dba_tables
                         where dba_tables.table_name = DBA_TAB_MODIFICATIONS.table_name
                           and DBA_TAB_MODIFICATIONS.table_owner = dba_tables.owner) last_analyzed,
                       (inserts + updates + deletes) tot_updates,
                       DBA_TAB_MODIFICATIONS.*
                  from sys.DBA_TAB_MODIFICATIONS
               ) a
       ) b
 where perc_updates >5
   and table_owner NOT IN ('APPQOSSYS','ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS','MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB','PUBLIC','ORACLE_OCM')
 order by last_analyzed desc
/

-- verifica ultima coleta de estatistica
select  owner, table_name,STATUS,to_char (last_analyzed, 'DD-MON-YY HH24:MI:SS') as last_analyzed
from dba_tables 
where owner='KIPREV' AND table_name='FO_DISTRIB_CORRETORES';

-- ver qtas alteracoes objeto ja teve desde a ultima coleta de estatisticas:
col SUBPARTITION_NAME for a25
col PARTITION_NAME for a25
col TABLE_OWNER for a25
col TABLE_NAME for a28
SELECT * FROM DBA_TAB_MODIFICATIONS
WHERE   TABLE_NAME = 'FO_SAIDAS_TIPSALDOSXAPORTE'
order by INSERTS desc;


-- verifca ultimas alterações que a tabela sofreu (DML, DCL)
col OBJECT_NAME for a35
select object_name,created,to_char(last_ddl_time, 'DD/MM/YY HH:MM:SS' ) as last_ddl_time,timestamp   
from dba_objects   
where owner='KPVCUST04' and last_ddl_time > (sysdate -5);

-- verificando estatisticas de objetos do dicionario de dados agrupado por data de ultima coleta de 1 owner
SELECT 		NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, 
			COUNT(*) dictionary_tables
FROM 		dba_tables
WHERE 		owner = 'KPVCUST04'
GROUP BY 	TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 	1 DESC;

SELECT 		NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, 
			COUNT(*) dictionary_tables
FROM 		dba_tables
WHERE 		owner = 'KIPREV'
GROUP BY 	TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 	1 DESC;

SELECT table_owner,
       table_name,
       partition_name,
       last_analyzed
FROM   dba_tab_partitions
WHERE  table_owner = 'KIPREV'
ORDER BY table_name, partition_name;

SELECT table_owner,
       table_name,
       subpartition_name,
       last_analyzed
FROM   dba_tab_subpartitions
WHERE  table_owner = 'KIPREV'
ORDER BY table_name, subpartition_name;

-- verificando estatisticas de objetos do dicionario de dados agrupado por data de ultima coleta do banco full
SELECT 		NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, 
      COUNT(*) dictionary_tables
FROM 		dba_tables
GROUP BY 	TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 ASC;

-- verificando estatisticas de objetos do dicionario de dados agrupado por data de ultima coleta de 1 tabela
SELECT 		owner, table_name,NVL(TO_CHAR(last_analyzed, 'DD/MM/YY HH:MM:SS'), 'NO STATS') last_analyzed
FROM 		dba_tables
where table_name in ('FO_SAIDAS_TIPSALDOSXAPORTE')
ORDER BY 1 DESC;

AC_CARTAS_EMITIDAS_VARS	
CG_AGENDAMENTO_CONTABIL	
CG_MOVIMIENTO_DETALLE	
CG_MOVIMIENTO_RESUMEN	
FO_CONTRIB_HIST_OLD	
FO_MOVIMTOS_DETA	
FO_MOVIMTOS_OLD	
IL_IR_HIST_CONSOLIDADO	
MLOG$_FO_CAT_REGLAS_NEGOCI
MLOG$_FO_REGLAS_NEGOCIO
MLOG$_FO_REGLAS_NEGOCIO_DE
RE_COBRANCA
RE_DEPOSITOS_PLANILLA

-- Verifica coleta de estatiscia automatica em execução.
SELECT OPID, 
       ORIGIN, 
       STATUS, 
       TO_CHAR(START_TIME, 'DD/MM/YYYY HH24:MI:SS' ) AS BEGIN_TIME,
       TO_CHAR(END_TIME, 'DD/MM/YYYY HH24:MI:SS') AS END_TIME
FROM  DBA_AUTO_STAT_EXECUTIONS
ORDER BY OPID DESC
FETCH FIRST 10 ROWS ONLY;

SELECT DBMS_STATS.GET_PREFS('AUTO_TASK_STATUS') FROM DUAL;

-- Valores de estatisticas do BD
select a.*,
decode( a.class,
1, 'User',
2, 'Redo' ,
4, 'Enqueue',
8, 'Cache',
16, 'OS',
32, 'Real Application Clusters',
64, 'SQL',
128, 'Debug', 'Outros') descricao_classe
  from v$sysstat a
--where a.NAME like 'change write time'
Order by 4 Desc

-- verifica se a tabela está bloqueada para coleta de estatistica.
select owner,table_name,STATTYPE_LOCKED from dba_tab_statistics where table_name='TB_OMS_TRANSPORTADORA' and owner='A_RAIABD';
select owner,table_name,STATTYPE_LOCKED from dba_tab_statistics where owner='CONSINCO'  and STATTYPE_LOCKED='ALL';

-- Desbloqueia coleta de estatiscia na tabela
EXEC DBMS_STATS.unlock_table_stats('CONSINCO','RF_AUXNOTAITEM');
EXEC DBMS_STATS.unlock_table_stats('MGCON','CON_TMP_LISTARAZAO');

-- Coleta estatisticas do banco full
EXEC DBMS_STATS.GATHER_DATABASE_STATS;

exec DBMS_STATS.GATHER_DATABASE_STATS(ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE, METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO', DEGREE => 15, CASCADE => TRUE, options => 'GATHER');

exec DBMS_STATS.GATHER_DATABASE_STATS(ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE, DEGREE => 15, CASCADE => TRUE, options => 'GATHER');

set timing on;
BEGIN
  DBMS_STATS.GATHER_DATABASE_STATS(
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    method_opt       => 'FOR ALL COLUMNS SIZE AUTO',
    DEGREE           => 40
    cascade          => TRUE,
    granularity      => 'ALL',
    options          => 'GATHER',
    no_invalidate    => FALSE
  );
END;
/

-- Coleta estatistica owner full
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('KIPREV', CASCADE=>TRUE, DEGREE => 20);
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('KIPREVWEB', CASCADE=>TRUE, DEGREE => 20);
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('KPVCUST04', CASCADE=>TRUE, DEGREE => 20);


-- Coleta estatistica de tabela especifica
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'OWNER', TABNAME=>'NOME_TABELA', cascade=>true);
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'OWNER', TABNAME=>'TABELA', ESTIMATE_PERCENT=>1);  
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'OWNER', TABNAME=>'TABELA', ESTIMATE_PERCENT=>1, degree=>24);  

-- Remove estatisticas caso precise
EXEC DBMS_STATS.DELETE_TABLE_STATS (OWNNAME=>'OWNER', TABNAME=>'NOME_TABELA');



AC_CARTAS_EMITIDAS_VARS	
CG_AGENDAMENTO_CONTABIL	
CG_MOVIMIENTO_DETALLE	
CG_MOVIMIENTO_RESUMEN	
FO_CONTRIB_HIST_OLD	
FO_MOVIMTOS_DETA	
FO_MOVIMTOS_OLD	
IL_IR_HIST_CONSOLIDADO	
MLOG$_FO_CAT_REGLAS_NEGOCI
MLOG$_FO_REGLAS_NEGOCIO
MLOG$_FO_REGLAS_NEGOCIO_DE
RE_COBRANCA
RE_DEPOSITOS_PLANILLA

-- Recomendado apos uma atualização do BD, ou depois de uma carga pesada no banco de dados, coleta estatistica dos objetos fixos do BD,
-- essas estatisticas ajudam o otimizador a gerar bons planos de execução
-- A falha em obter estatísticas representativas pode levar a planos de execução abaixo do ideal, o que pode causar problemas de desempenho significativo

--Coleta estatistica de index 
execute dbms_stats.gather_index_stats(ownname=>'CONSINCO',indname=>'MAD_SEGMENTOIE1',degree=>2)

-- Coleta estatisticas dos objetos fixos do banco de dados
exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS();

-- Estatísticas do sistema operacional (disco, tempos de CPU).

SELECT PNAME, PVAL1 FROM SYS.AUX_STATS$ WHERE SNAME = 'SYSSTATS_MAIN';

exec DBMS_STATS.GATHER_SYSTEM_STATS();

-- Usados ​​para tornar as consultas de dicionário mais eficientes, 
-- coleta os mesmos metadados que o gather_table_stats , exceto para o número de blocos. 
-- Isso ocorre porque as estruturas x$ e as views de sistema (v$) só existem na RAM da SGA.
exec DBMS_STATS.GATHER_DICTIONARY_STATS();

 ---- // Coleta de estatisticas de index // --

-- Verifica quais index estão com coletas escassas.
col INDEX_NAME for a35
col OWNER for a15
select i.OWNER , i.INDEX_NAME, i.NUM_ROWS
        from DBA_INDEXES i
       where i.TEMPORARY = 'N'
         and i.OWNER ='KIPREV'
       order by nvl (i.LAST_ANALYZED, sysdate - 60),i.NUM_ROWS,i.TABLE_NAME,i.INDEX_NAME ;


-- Retorna informação do tipos de coletas TYPICAL e ALL, mostrando cada feature ativa em cada level (basic, typical, all) 
COLUMN statistics_name      FORMAT A30 HEADING "Statistics Name"
COLUMN session_status       FORMAT A10 HEADING "Session|Status"
COLUMN system_status        FORMAT A10 HEADING "System|Status"
COLUMN activation_level     FORMAT A10 HEADING "Activation|Level"
COLUMN session_settable     FORMAT A10 HEADING "Session|Settable"

SELECT statistics_name,
       session_status,
       system_status,
       activation_level,
       session_settable
FROM   v$statistics_level
ORDER BY statistics_name;

-- Cria o comando para executar a coleta de estatisticas dos index com coletas escassa.
set lines 850 pages 0;
spool 'gera_script_coleta_estatistica_index.sql';
set timing on;
select ' execute dbms_stats.gather_index_stats(ownname=>''"'|| i.OWNER ||'"'',indname=>''"'|| i.INDEX_NAME ||'"'',degree=>2) ; '
        from DBA_INDEXES i
       where i.TEMPORARY = 'N'
             --and i.OWNER ='CONSINCO'
       order by nvl (i.LAST_ANALYZED, sysdate - 5),
                i.NUM_ROWS,
                i.TABLE_NAME,
                i.INDEX_NAME ;

spool off
set timing on;
@gera_script_coleta_estatistica_index.sql

exit;


---

-- tudo que teve movimenação após o último analyze
SET PAGESIZE 0
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TERMOUT OFF
SET LINESIZE 500
set TIMING on
alter session set "_optimizer_adaptive_plans"=false;
select 'exec dbms_stats.gather_table_stats(ownname=>' || ''''|| '"' || table_owner ||'"'|| ''',tabname=>''' ||'"'|| table_name||decode(partition_name,null,'','.'||partition_name) ||'"' || ''', METHOD_OPT=>''FOR ALL COLUMNS SIZE AUTO'',degree=>20);'
  from (select a.*,
               nvl(decode(num_rows, 0, '-1', 100 * tot_updates / num_rows), -1) perc_updates
          from (select (select num_rows
                         from dba_tables
                        where dba_tables.table_name = DBA_TAB_MODIFICATIONS.table_name
                          and DBA_TAB_MODIFICATIONS.table_owner = dba_tables.owner) num_rows,
                       (select last_analyzed
                          from dba_tables
                         where dba_tables.table_name = DBA_TAB_MODIFICATIONS.table_name
                           and DBA_TAB_MODIFICATIONS.table_owner = dba_tables.owner) last_analyzed,
                       (inserts + updates + deletes) tot_updates,
                       DBA_TAB_MODIFICATIONS.*
                  from sys.DBA_TAB_MODIFICATIONS
               ) a
       ) b
 where table_owner IN ('KIPREV') and table_name in ('AC_CARTAS_EMITIDAS_VARS','CG_AGENDAMENTO_CONTABIL','CG_MOVIMIENTO_DETALLE','CG_MOVIMIENTO_RESUMEN','FO_CONTRIB_HIST_OLD','FO_MOVIMTOS_DETA','FO_MOVIMTOS_OLD','IL_IR_HIST_CONSOLIDADO','MLOG$_FO_CAT_REGLAS_NEGOCI','MLOG$_FO_REGLAS_NEGOCIO','MLOG$_FO_REGLAS_NEGOCIO_DE','RE_COBRANCA','RE_DEPOSITOS_PLANILLA')
 order by last_analyzed desc
/


'MLOG$_FO_CAT_REGLAS_NEGOCI','MLOG$_FO_REGLAS_NEGOCIO','MLOG$_FO_REGLAS_NEGOCIO_DE',


select distinct
'exec dbms_stats.gather_table_stats(ownname=> ' ||''''|| table_owner ||''''|| ', tabname=>'|| '''' || '"' || table_name || '"' || '''' 
|| ', method_opt=> ''for all columns size auto''' 
|| ', partname=>'||''''|| partition_name || ''''
||' granularity => ''ALL'', cascade => true, estimate_percent => 100, degree=>20);'
from dba_tab_partitions 
where table_owner='KIPREV' 
and table_name in ('FO_CUENTAS','AC_CARTAS_EMITIDAS_VARS','CG_AGENDAMENTO_CONTABIL','CG_MOVIMIENTO_DETALLE','CG_MOVIMIENTO_RESUMEN','FO_CONTRIB_HIST_OLD','FO_MOVIMTOS_DETA','FO_MOVIMTOS_OLD','IL_IR_HIST_CONSOLIDADO','RE_COBRANCA','RE_DEPOSITOS_PLANILLA') 
order by 1;




'EXEC dbms_stats.gather_table_stats(ownname=>' ||''''|| table_owner ||''''|| ', tabname=>'|| '''' || '"' || table_name || '"' || '''' || ', method_opt=> ''for all columns size auto''' ||', partname=>'||''''|| partition_name || ''''||' granularity => ''ALL'', cascade => true, estimate_percent => 100, degree=>20);'

-- Coleta estatistica também das partições e subpartições
/*
granularity => 'PARTITION' -- somente das partições
granularity => 'SUBPARTITION' -- somente das subpartições
granularity => 'ALL' -- coleta estatisticas da tabela, partições e subpartições
*/
EXEC dbms_stats.gather_table_stats(ownname => 'TABLE_OWNER', tabname => 'TABLE_NAME', method_opt=> 'for all columns size auto', granularity => 'ALL', degree => 20, cascade => true ,estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => 'ELMAH', tabname => 'ELMAH$ERROR_INTERIM', degree => 4, cascade => true, granularity => 'ALL' );

EXEC dbms_stats.gather_table_stats(ownname=>'KIPREV', tabname=>'"RE_DEPOSITOS_PLANILLA"', method_opt=> 'for all columns size auto', partname=>'PART9999' granularity => 'ALL', cascade => true, estimate_percent => 100, degree=>20);

'EXEC dbms_stats.gather_table_stats(ownname=>' ||''''|| table_owner ||''''|| ', tabname=>'|| '''' || '"' || table_name || '"' || '''' || ', method_opt=> ''for all columns size auto''' ||', partname=>'||''''|| partition_name || ''''||' granularity => ''ALL'', cascade => true, estimate_percent => 100, degree=>20);'

exec dbms_stats.gather_table_stats(ownname=> 'KIPREV', tabname=>'"RE_DEPOSITOS_PLANILLA"', method_opt=> 'for all columns size auto', partname=>'PART9999' granularity => 'ALL', cascade => true, estimate_percent => 100, degree=>20);

EXEC DBMS_STATS.GATHER_SCHEMA_STATS(ownname=> 'KIPREV',cascade=> TRUE,degree=> 15,granularity=> 'ALL');
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('KIPREV', CASCADE=>TRUE, DEGREE => 15);

set lines 1000
set pages 10000
col TABLE_NAME for a40
col PARTITION_NAME for a25
col LAST_ANAL for a30
col SUBPARTITION_NAME for a25
SELECT table_name,
       partition_name,
       subpartition_name,
       last_analyzed
FROM dba_tab_statistics
WHERE owner = 'KIPREV'
and table_name='FO_MOVIMTOS_DETA'
ORDER BY table_name, partition_name, subpartition_name;


BEGIN
  DBMS_STATS.GATHER_DATABASE_STATS(
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    method_opt       => 'FOR ALL COLUMNS SIZE AUTO',
    degree           => 40
    cascade          => TRUE,
    granularity      => 'ALL',
    options          => 'GATHER',
    no_invalidate    => FALSE
  );
END;
/