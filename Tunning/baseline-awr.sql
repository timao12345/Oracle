/* BASE LINE AWR*/
-- pesquisa o baseline
select sql_handle,plan_name,to_char(CREATED, 'DD-MM-YY HH24:MI') AS CREATED, ENABLED, FIXED, SQL_TEXT 
from dba_sql_plan_baselines 
where CREATED > sysdate -1/24 ;

SQL_TEXT like '%not in (1801, 9220)%';
plan_name='SQL_PLAN_1frb8h5myrha210ca7d24';

CREATED > sysdate -1/24 ;

-- Retorna PLAN_HASH_VALUE historico do AWR
col plan_hash_value format 9999999999999999999999999
select plan_hash_value, max(snap_id)-1 awr_snap, round(sum(elapsed_time_total)/sum(executions_total)/1e6,2) avg_et_secs
from dba_hist_sqlstat 
where sql_id='aqv2aq0u30w1b'
and executions_total > 0
group by plan_hash_value;

           PLAN_HASH_VALUE|  AWR_SNAP|AVG_ET_SECS
--------------------------|----------|-----------
                 330448429|      8905|    1464.29
                 349579760|      8922|     710.07
                1679588641|      8929|      52.43

SQL>

-- apartir do retorno da query acima executar abaixo para fixar o plano existente no AWR
DECLARE
 vSnapMin number       := 137450;            -- valor da coluna "awr_snap" na query anterior
 vSQL_ID varchar2(200) := 'aqv2aq0u30w1b';
 vHashPlan number      := 725026494;       -- hash_plan a ser importado, conforme query anterior
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
SET SERVEROUTPUT ON
DECLARE
 vChange VARCHAR2(200);
BEGIN
 vChange:= DBMS_SPM.ALTER_SQL_PLAN_BASELINE (
   plan_name       => 'SQL_PLAN_1frb8h5myrha210ca7d24',
   attribute_name  => 'FIXED',
   attribute_value => 'YES');
END;
/
   sql_handle      => 'SQL_175d688167ebc142',

-- Para desabilitar um baseline
DECLARE
 vChange VARCHAR2(200);
BEGIN
 vChange:= DBMS_SPM.ALTER_SQL_PLAN_BASELINE (
   plan_name       => 'SQL_PLAN_26d6q9rrdk5uz165e4f47',
   attribute_name  => 'ENABLED',
   attribute_value => 'NO');
END;
/


-- dropa o baseline
declare
drop_result pls_integer;
begin
  drop_result := DBMS_SPM.DROP_SQL_PLAN_BASELINE(
  sql_handle => 'SQL_175d688167ebc142',
  plan_name => 'SQL_PLAN_1frb8h5myrha210ca7d24');
  dbms_output.put_line(drop_result);
end;
/