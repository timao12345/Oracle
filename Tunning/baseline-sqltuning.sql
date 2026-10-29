/*

SQL Tuning Set (STS) é um objeto de banco de dados que armazena uma lista de comando SQL junto com seus planos de execução. Um STS pode ser usado como fonte para outras features do Oracle Database, 
assim como usaremos com o SPM.

Podemos carregar um STS de diversas formas e com uma grande variedade de filtros. Neste exemplo veremos dois exemplos simples, um pegando os comandos SQL do Cursor Cache e o outro pegando do AWR. 
Também temos uma boa flexibilidade de filtro sobre quais comandos serão importados, podendo ser um conjunto limitado ou até mesmo todos os comandos disponíveis.

Basicamente STS serve para guardarmos planos atuais para apos alguma migração se os planos mudarem e ficarem ruins podemos setar o plano anterior.

*/

-- 1 Criar o SQL Tuning Set com um nome qualquer:

BEGIN
dbms_sqltune.create_sqlset(
 sqlset_name => 'STS_TUNNING_LSM',
 description => 'Plano dos SQL 01-02-23 ate 06-02-23'
);
END;
/

-- 2 pegando historico do awr

-- identifica o intervalo de snapshots pelo período
select min(snap_id), max(snap_id)
from dba_hist_snapshot 
where begin_interval_time 
between to_date('01/02/2023 00:00:00','dd/mm/yyyy hh24:mi:ss') 
    and to_date('6/02/2023 23:59:59','dd/mm/yyyy hh24:mi:ss');
 
MIN(SNAP_ID)|MAX(SNAP_ID)
------------|------------
      111861|      112430

 
-- importa os SQL do AWR passando o intervalo de snapshots
DECLARE
cur sys_refcursor;
BEGIN
open cur for
select value(p) 
  from table(dbms_sqltune.select_workload_repository
     (
     begin_snap   => 111861, 
     end_snap     => 112430, 
     basic_filter => 'parsing_schema_name <> ''SYS'' '
     )) p;
dbms_sqltune.load_sqlset('STS_TUNNING_LSM', cur);
close cur;
END;
/

-- 3 Pegando do cursor cache

-- pegando todos os comandos disponíveis no Cursor Cache que não foram executados pelo SYS
declare
sts_ref_cur sys_refcursor;
begin
    open sts_ref_cur for SELECT VALUE(P) FROM table(DBMS_SQLTUNE.SELECT_CURSOR_CACHE('parsing_schema_name <> ''SYS''')) P;
    DBMS_SQLTUNE.LOAD_SQLSET('STS_TUNNING_LSM', sts_ref_cur);
end;
/



-- 4 Podemos criar um baseline apartir do nosso STS criado anteriormente

set serveroutput on
declare
l_num_plans PLS_INTEGER;
begin
 l_num_plans := DBMS_SPM.LOAD_PLANS_FROM_SQLSET (sqlset_name=> 'STS_TUNNING_LSM',sqlset_owner=>'SYS', basic_filter=>'sql_id=''fb3fw1hahd4qh'' and plan_hash_value=598595646');
 DBMS_OUTPUT.put_line('Number of plans loaded: ' || l_num_plans);
end;
/

-- Retorna os planos existentes para o sql_id desejado
set serveroutput on
declare
l_num_plans PLS_INTEGER;
begin
    l_num_plans:= DBMS_SQLTUNE.SELECT_SQLSET (sqlset_name=>'STS_TUNNING_LSM', sqlset_owner=>'SYS', basic_filter=>'sql_id=''fb3fw1hahd4qh''');
    DBMS_OUTPUT.put_line ('Number of plans for sql_id:' || l_num_plans);
end;


-- verifica os planos existentes para o sql_id, pega o handle e o nome do plano
SELECT sql_handle, plan_name,ENABLED FROM dba_sql_plan_baselines WHERE signature IN ( SELECT exact_matching_signature FROM gv$sql WHERE sql_id='5fq3ns7qhja3u');


-- desabilitar um baseline
DECLARE
 vChange VARCHAR2(200);
BEGIN
 vChange:= DBMS_SPM.ALTER_SQL_PLAN_BASELINE (
   sql_handle      => 'SQL_7c21d8313c062c25',
   plan_name       => 'SQL_PLAN_7s8fs64y0cb1563256891',
   attribute_name  => 'ENABLED',
   attribute_value => 'NO');
END;
/

var v_num number;
EXEC  :v_num:=dbms_spm.alter_sql_plan_baseline(sql_handle =>'SQL_8d3dc3146997fc15',  plan_name => 'SQL_PLAN_8ugf32jntgz0p21418cc4',  attribute_name=> 'fixed',  attribute_value=>'NO');  
print v_num;


-- verifica os planos existentes para o sql_id
SELECT sql_handle, plan_name,ENABLED FROM dba_sql_plan_baselines WHERE signature IN ( SELECT exact_matching_signature FROM gv$sql WHERE sql_id='5fq3ns7qhja3u');

select sql_handle, plan_name,
origin, enabled, accepted,sql_text
 from   dba_sql_plan_baselines
 where  sql_text like 'SELECT%sh.sales%';

----------------
col plan_hash_value format 9999999999999999999999999
select plan_hash_value, max(snap_id)-1 awr_snap, round(sum(elapsed_time_total)/sum(executions_total)/1e6,2) avg_et_secs
from dba_hist_sqlstat 
where sql_id='9a9qrs746j1r7'
and executions_total > 0
group by plan_hash_value;

DECLARE
 vSnapMin number       := 43987;            -- valor da coluna "awr_snap" na query anterior
 vSQL_ID varchar2(200) := '9a9qrs746j1r7';
 vHashPlan number      := 276672087;       -- hash_plan a ser importado, conforme query anterior
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