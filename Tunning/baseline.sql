
-- pesquisa o baseline
select sql_handle,plan_name,to_char(CREATED, 'DD-MM-YY HH24:MI') AS CREATED, ENABLED,SQL_TEXT from dba_sql_plan_baselines 
where plan_name like '%7rrdmgstpkgbz%';

CREATED > sysdate -1/24 ;

SELECT SQL_HANDLE,PLAN_NAME, SQL_TEXT 
FROM DBA_SQL_PLAN_BASELINES 
WHERE PLAN_NAME like '%7rrdmgstpkgbz%';


--listar comandos SQL no Cursor Cache que utilizam SPM Baseline:
SELECT SQL_ID, SQL_PLAN_BASELINE 
FROM V$SQL 
WHERE SQL_PLAN_BASELINE IS NOT NULL;

-- dropar
declare
drop_result pls_integer;
begin
drop_result := DBMS_SPM.DROP_SQL_PLAN_BASELINE(
sql_handle => 'SQL_175d688167ebc142',
plan_name => 'SQL_PLAN_1frb8h5myrha210ca7d24');
dbms_output.put_line(drop_result);
end;
/

-- parametro optimizer_use_sql_plan_baselines  deve estar como TRUE para funcionar o baseline.

show parameter optimizer_use_sql_plan_baselines.
NAME                                 TYPE        VALUE
------------------------------------ ----------- ----------
optimizer_use_sql_plan_baselines     boolean     TRUE
SQL>


 --existem 3 opções para criar um Baseline manualmente no SPM:

-- 1 Importando do Cursor Cache (LOAD_PLANS_FROM_CURSOR_CACHE)
SELECT inst_id,
       sql_id,
       child_number,
       plan_hash_value,
       parsing_schema_name,
       executions,
       elapsed_time/1000000 elapsed_sec,
       cpu_time/1000000 cpu_sec,
       buffer_gets,
       disk_reads,
       rows_processed,
       is_bind_sensitive,
       is_bind_aware
FROM gv$sql
WHERE sql_id = '1m33yn6324a7w'
ORDER BY elapsed_time;

SELECT inst_id,
       sql_id,
       plan_hash_value,
       executions,
       elapsed_time/1000000 elapsed_sec,
       cpu_time/1000000 cpu_sec,
       buffer_gets,
       disk_reads,
       rows_processed,
       fetches,
       parse_calls
FROM gv$sqlstats
WHERE sql_id = '1m33yn6324a7w'
ORDER BY elapsed_time;

/*  ou caso queria carregar todos os planos do SQL_ID, basta remover o plan_hash_value (não recomendado pois pode carregar planos ruins também).
obs: Casos que o SQL_ID tem muitos planos e somente queremos os melhores podemos carregar mais de 1 usando a query abaixo mais de uma vez deixando o banco de decidir qual usar
Ao executar o comando abaixo, o plano será carregado para o SPM e poderá ser usado pelo otimizador, se executar mais de 1x para o mesmo SQL_ID com plan_hash_value diferente, 
o otimizador irá escolher qual plano usar baseado no custo estimado do plano.
*/
-- Carrega um plano especifico bom.
SET SERVEROUTPUT ON
DECLARE
 vLoad varchar2(200);
BEGIN
 vLoad := DBMS_SPM.LOAD_PLANS_FROM_CURSOR_CACHE (SQL_ID => 'bd5c8fvmh78c6', PLAN_HASH_VALUE => 3735151949);
 DBMS_OUTPUT.put_line('Number of plans loaded: ' || vLoad);
END;
/

-- caso tenha mais de um plan_hash_value pode usar o codigo abaixo.
set serveroutput on;
ECLARE
l_plans_loaded PLS_INTEGER;
BEGIN
      l_plans_loaded := DBMS_SPM.load_plans_from_cursor_cache(sql_id => '&sql_id', plan_hash_value => '&plan_hash_value');
      DBMS_OUTPUT.put_line('Plans Loaded: ' || l_plans_loaded);
END;
/

-- 2 Importando de um SQL Tuning Set (LOAD_PLANS_FROM_SQLSET) 
-- Crei primeiro o SQLSET para armazenar os planos de SQL que quero carregar para o SPM.
BEGIN
dbms_sqltune.create_sqlset(
 sqlset_name => 'STS_PRE_MIGRACAO',
 description => 'Plano dos SQL antes da Migracao'
);
END;
/

-- Pegando do AWR
-- Importe os comandos SQL para o SQL Tuning Set criado antes, nesse caso vamos pegar uma data pelo SNAP 
select min(snap_id), max(snap_id)
from dba_hist_snapshot 
where begin_interval_time 
between to_date('01/09/2026 00:00:00','dd/mm/yyyy hh24:mi:ss') 
    and to_date('16/09/2026 23:59:59','dd/mm/yyyy hh24:mi:ss');

-- importa todos os SQL do AWR passando o intervalo de snapshots (modificar as variaveis conforme necessário) e o filtro de schema (nesse caso SAPSR3) para o SQLSET criado.
-- Nesse exemplo pegamos todos os SQL do AWR do schema SAPSR3 entre os snapshots 194838 e 197141 e carregamos para o SQLSET STS_PRE_MIGRACAO.
DECLARE
cur sys_refcursor;
BEGIN
open cur for
select value(p) 
  from table(dbms_sqltune.select_workload_repository
     (
     begin_snap   => 194838, 
     end_snap     => 197141, 
     basic_filter => 'parsing_schema_name = ''SAPSR3'' '
     )) p;
dbms_sqltune.load_sqlset('STS_PRE_MIGRACAO', cur);
close cur;
END;
/

-- Pegando do Cursor Cache
-- pegando todos os comandos disponíveis no Cursor Cache que foram executados por um owner especifico 'parsing_schema_name = ''SAPSR3'' ou full 'parsing_schema_name <> ''SYS''
declare
sts_ref_cur sys_refcursor;
begin
open sts_ref_cur for SELECT VALUE(P) FROM table(DBMS_SQLTUNE.SELECT_CURSOR_CACHE('parsing_schema_name = ''SAPSR3''')) P;
DBMS_SQLTUNE.LOAD_SQLSET('STS_PRE_MIGRACAO', sts_ref_cur);
end;
/

set serveroutput on
declare
l_num_plans PLS_INTEGER;
begin
 l_num_plans := DBMS_SPM.LOAD_PLANS_FROM_SQLSET (sqlset_name=> 'STS_PRE_MIGRACAO',sqlset_owner=>'SAPSR3' ,basic_filter=>'sql_id=''1m33yn6324a7w'' and plan_hash_value=598595646');
 DBMS_OUTPUT.put_line('Number of plans loaded: ' || l_num_plans);
end;
/

-- ou importar full os planos, da pra fazer varias alterações no filtr, ler doc.
DECLARE
  l_plans_loaded  PLS_INTEGER;
BEGIN
  l_plans_loaded := DBMS_SPM.load_plans_from_sqlset(
    sqlset_name => 'STS_PRE_MIGRACAO');
END;
/


SELECT sql_handle, plan_name, enabled, accepted 
FROM   dba_sql_plan_baselines
WHERE  sql_text LIKE '%SELECT COD_ENDERECO FROM KIPREV.PA_ENDERECOS E WHERE COD_NIVEL%';


-- 3 Importando do AWR (LOAD_PLANS_FROM_AWR) –> new feature do 12cR12
--  Identifique os planos disponíveis no AWR, assim como o intervalo de Snapshots mais recente para cada um:
col plan_hash_value format 9999999999999999999999999
select plan_hash_value, max(snap_id)-1 awr_snap, round(sum(elapsed_time_total)/sum(executions_total)/1e6,2) avg_et_secs
from dba_hist_sqlstat 
where sql_id='1m33yn6324a7w'
and executions_total > 0
group by plan_hash_value;

-- Importe o plano específico informando o intervalo de snapshots AWR:
DECLARE
 vSnapMin number       := 187353;            -- valor da coluna "awr_snap" na query anterior
 vSQL_ID varchar2(200) := '1m33yn6324a7w';
 vHashPlan number      := 629177156;       -- hash_plan a ser importado, conforme query anterior
 vLoad varchar2(200);
BEGIN
 vLoad := DBMS_SPM.LOAD_PLANS_FROM_AWR( 
  BEGIN_SNAP   => vSnapMin,
  END_SNAP     => vSnapMin+1,
  BASIC_FILTER => 'sql_id=''' || vSQL_ID || ''' and plan_hash_value=''' || vHashPlan || ''' '
);
DBMS_OUTPUT.put_line('Number of plans loaded: ' || vLoad);
END;
/

-- marcar como fixed pois se existe outros baseline pode ocorrer de não utilizar o desejado
COL sql_handle FORMAT A35
COL plan_name FORMAT A35
SELECT sql_handle,
       plan_name,
       enabled,
       accepted,
       fixed,
       optimizer_cost
FROM dba_sql_plan_baselines
WHERE signature IN (
  SELECT exact_matching_signature
  FROM v$sql
  WHERE sql_id = '7rrdmgstpkgbz'
);

SET SERVEROUTPUT ON
DECLARE
 vChange VARCHAR2(200);
BEGIN
 vChange:= DBMS_SPM.ALTER_SQL_PLAN_BASELINE (
   sql_handle      => 'SQL_c23d20412b7fb4af',
   plan_name       => 'SQL_PLAN_c4g9084przd5g284d126a',
   attribute_name  => 'FIXED',
   attribute_value => 'YES');
END;
/