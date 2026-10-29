set pagesize 1000
set linesize 1000

-- ver valor atual:
show parameter optimizer_mode

-- limpando shared pool p/ resultados dos testes ficarem mais limpos nas consultas que mostram stats dos SQLs:
ALTER SYSTEM FLUSH SHARED_POOL;

-- configure um valor para o OPTIMIZER_MODE, execute o SQL1 e depois veja o PE:
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS;                -- 400S
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS;              -- 0,5s
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS_1;            -- 0,5s
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS_1000;         -- 0,5s

-- SQL 1: Veja o PE abaixo apos alterar o OPTIMIZER_MODE e veja também o tempo de execucao:
explain plan for
            SELECT      O.ORDER_DATE,
                        O.ORDER_ID,
                        P.PRODUCT_NAME,                        
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.PRODUCT_INFORMATION P       --    0,25 MB
            INNER JOIN  SOE.ORDER_ITEMS I               -- 1280,00 MB
                ON      P.PRODUCT_ID = I.PRODUCT_ID     
            INNER JOIN  SOE.ORDERS O                    -- 552,00 MB
                ON      O.ORDER_ID = I.ORDER_ID             
            WHERE ROWNUM < 1000            
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, P.PRODUCT_NAME;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);            

-- verifica stats dos SQLs acima na SGA:
        select        a.optimizer_mode,
                      a.sql_id,
                      u.username,
                      sc.username as schemaname,                      
                      a.executions,                       
                      a.cpu_time/(1000000) "cpu_time (s)",
                      a.disk_reads,
                      a.elapsed_time/(1000000) "elapsed_time (s)",
                      (a.sharable_mem + a.persistent_mem + a.runtime_mem) /1024/1024 "used_memory (mb)",
                      a.first_load_time,
                      TO_CHAR(a.last_load_time,'dd/mm/yy HH24:mi:ss') last_load_time,
                      a.buffer_gets,
                      a.sorts,
                      a.loads,
                      a.application_wait_time/(1000000) "application_wait_time (s)",
                      a.concurrency_wait_time/(1000000) "concurrency_wait_time (s)",
                      a.user_io_wait_time/(1000000) "user_io_wait_time (s)",
                      a.plsql_exec_time/(1000000) "plsql_exec_time (s)",
                      a.rows_processed,                      
                      a.optimizer_cost,                      
                      --a.sql_text,
                      DBMS_LOB.SUBSTR(a.SQL_FULLTEXT, 4000,1) sql_text,
                      b.value_string
        from          v$sqlarea a
        INNER JOIN    dba_users u
              ON      a.parsing_user_id = u.user_id
        INNER JOIN    dba_users sc
              ON      A.PARSING_SCHEMA_ID = SC.USER_ID
        INNER JOIN    v$sql_plan p
              ON      p.sql_id = a.sql_id
        LEFT JOIN     v$sql_bind_capture b
              ON      a.address = b.address
              AND     a.hash_value = b.hash_value
        where         a.sql_text like 'SELECT      O.ORDER_DATE,%';

-- ver PE real (necessario informar sql_id):
select * from table(dbms_xplan.display_cursor('&sql_id'));    

-- usando o hint FIRST_ROWS:
SELECT /*+ FIRST_ROWS */ * FROM DBA_OBJECTS WHERE OBJECT_ID = 1;