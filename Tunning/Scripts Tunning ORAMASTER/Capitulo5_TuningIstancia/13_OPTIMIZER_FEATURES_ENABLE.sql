-- voltar OPTIMIZER_MODE para valor padrao:
alter SESSION set optimizer_mode = all_rows;

alter system set optimizer_mode = all_rows;

CHOOSE

-- ver valor atual de OPTIMIZER_FEATURES_ENABLE:
show parameter OPTIMIZER_FEATURES_ENABLE

-- preparando o ambiente para o SQL que executaremos depois:
create bitmap index SOE.IX_ORDER_TOTAL on soe.orders(ORDER_STATUS, ORDER_TOTAL);  -- 28s

-- veja o tempo do SQL abaixo com a configuracao do OPTIMIZER_FEATURES_ENABLE atual e depois com versao anterior:
explain plan for
   UPDATE  SOE.ORDERS
    SET     ORDER_STATUS = 5
    WHERE   order_id IN (
                            SELECT  order_id 
                            FROM    SOE.ORDERS
                            WHERE   ORDER_TOTAL = 5000
                            );
select * from table(dbms_xplan.display);
--rollback;

-- configurando versao antiga do otimizador:
ALTER SESSION SET OPTIMIZER_FEATURES_ENABLE='8.0.0';  -- 81s

-- configurando versao atual do otimizador:
ALTER SESSION SET OPTIMIZER_FEATURES_ENABLE='18.1.0.1';  -- 0,074s

alter system set OPTIMIZER_FEATURES_ENABLE='11.2.0.4' scope=both;

-- ver features por versao do otimizador:
select      optimizer_feature_enable,
            count(*) 
from        v$system_fix_control !
group by    optimizer_feature_enable 
order by    1 asc;

optimizer_features_enable

-- hint optimizer_features_enable:
select /*+ optimizer_features_enable('9.2.0') */ * from dual;

-- geralmente bancos com boa performance tem os valores abaixo, porém cada banco tem um motivo de ter os valores dos parametros abaixo
NAME                                |TYPE       |VALUE
------------------------------------|-----------|------------------------------
optimizer_adaptive_plans            |boolean    |TRUE
optimizer_adaptive_reporting_only   |boolean    |FALSE
optimizer_adaptive_statistics       |boolean    |FALSE
optimizer_capture_sql_plan_baselines|boolean    |FALSE
optimizer_dynamic_sampling          |integer    |2
optimizer_features_enable           |string     |19.1.0
optimizer_ignore_hints              |boolean    |FALSE
optimizer_ignore_parallel_hints     |boolean    |FALSE
optimizer_index_caching             |integer    |90
optimizer_index_cost_adj            |integer    |20
optimizer_inmemory_aware            |boolean    |TRUE
optimizer_mode                      |string     |ALL_ROWS
optimizer_real_time_statistics      |boolean    |FALSE
optimizer_secure_view_merging       |boolean    |TRUE
optimizer_session_type              |string     |NORMAL
optimizer_use_invisible_indexes     |boolean    |FALSE
optimizer_use_pending_statistics    |boolean    |FALSE
optimizer_use_sql_plan_baselines    |boolean    |TRUE

ALTER SYSTEM SET OPTIMIZER_FEATURES_ENABLE='19.1.0' scope=spfile;

-- magmax
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
optimizer_adaptive_plans             boolean     FALSE
optimizer_adaptive_reporting_only    boolean     FALSE
optimizer_adaptive_statistics        boolean     FALSE
optimizer_capture_sql_plan_baselines boolean     FALSE
optimizer_dynamic_sampling           integer     2
optimizer_features_enable            string      19.1.0
optimizer_ignore_hints               boolean     FALSE
optimizer_ignore_parallel_hints      boolean     FALSE
optimizer_index_caching              integer     90
optimizer_index_cost_adj             integer     20
optimizer_inmemory_aware             boolean     TRUE
optimizer_mode                       string      ALL_ROWS
optimizer_real_time_statistics       boolean     TRUE
optimizer_secure_view_merging        boolean     TRUE
optimizer_session_type               string      NORMAL
optimizer_use_invisible_indexes      boolean     FALSE
optimizer_use_pending_statistics     boolean     FALSE
optimizer_use_sql_plan_baselines     boolean     TRUE
