-- ver info detalhadas sobre os top sql executados nos ultimos 30 minutos
select      * 
from        v$sqlstats
where       last_active_time  > TO_TIMESTAMP(sysdate - 30/60/24)
order by    elapsed_time desc;


-- retorna estatisticas de SQLs executados de um determinado usuario , incluindo variaveis bind:
        select        u.username,
                      sc.username as schemaname,                      
                      a.executions,     
                      a.parse_calls,
                      a.cpu_time/(1000000) "cpu_time (s)",
                      a.disk_reads,
                      a.elapsed_time/(1000000) "elapsed_time (s)",
                      (a.elapsed_time/(1000000)) / a.executions "Tempo p/ exec. (s)",
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
                      a.optimizer_mode,
                      a.optimizer_cost,                                            
                      a.sql_id,
                      DBMS_LOB.SUBSTR(a.SQL_FULLTEXT, 4000,1) sql_text, --a.sql_text,
                      listagg(b.value_string, ', ' ) within group (order by B.POSITION) AS BIND_VALUE                     
        from          v$sqlarea a
        INNER JOIN    dba_users u
              ON      a.parsing_user_id = u.user_id
        INNER JOIN    dba_users sc
              ON      a.parsing_schema_id = sc.user_id
        LEFT JOIN     v$sql_bind_capture b
              ON      a.address = b.address
              AND     a.hash_value = b.hash_value              
        where         sc.username = NVL(UPPER('&USERNAME'),sc.username)
        and           a.executions > 0
        -- AND        executions = 0 and parse_calls > 0  -- acrescentar qundo quiser filtrar somente SQLs que tiveram parse mas nao foram executados
		-- AND		  a.command_type = 3 -- acrescentar quando quiser filtrar somente SELECT (command_type = 3)
        GROUP BY      u.username,
                      sc.username,                      
                      a.executions,  
                      a.parse_calls,
                      a.cpu_time/(1000000),
                      a.disk_reads,
                      a.elapsed_time/(1000000),
                      (a.elapsed_time/(1000000)) / a.executions,
                      (a.sharable_mem + a.persistent_mem + a.runtime_mem) /1024/1024,
                      a.first_load_time,
                      TO_CHAR(a.last_load_time,'dd/mm/yy HH24:mi:ss'),
                      a.buffer_gets,
                      a.sorts,
                      a.loads,
                      a.application_wait_time/(1000000),
                      a.concurrency_wait_time/(1000000),
                      a.user_io_wait_time/(1000000),
                      a.plsql_exec_time/(1000000),
                      a.rows_processed,
                      a.optimizer_mode,
                      a.optimizer_cost,           
                      a.sql_id,
                      DBMS_LOB.SUBSTR(a.SQL_FULLTEXT, 4000,1)    --a.sql_text,