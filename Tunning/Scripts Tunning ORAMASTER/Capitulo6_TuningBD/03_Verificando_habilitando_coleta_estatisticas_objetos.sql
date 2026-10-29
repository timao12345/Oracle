-- ver se parametro STATISTICS_LEVEL tem valor igual a TYPICAL (padrao) ou ALL. Valor BASIC desabilita coleta de estatisticas e AWR:
SELECT 	statistics_name, activation_level, system_status
FROM 	v$statistics_level;


-- *** 10G ***
-- ver se coleta esta habilitada ou nao:
select * from dba_scheduler_jobs where schedule_name = 'GATHER_STATS_JOB';

-- desabilita coleta
BEGIN
  DBMS_SCHEDULER.DISABLE('GATHER_STATS_JOB');
END;

-- habilita coleta
BEGIN
  DBMS_SCHEDULER.ENABLE('GATHER_STATS_JOB');
END;


-- *** 11G em diante ***
-- ver se coleta esta habilitada ou nao
SELECT 	client_name, status 
FROM 	dba_autotask_operation 
where 	client_name = 'auto optimizer stats collection';

-- desabilita coleta
BEGIN
  DBMS_AUTO_TASK_ADMIN.disable(  client_name => 'auto optimizer stats collection',
                    operation => NULL,  window_name => NULL);
END;

-- habilita coleta
BEGIN
  DBMS_AUTO_TASK_ADMIN.enable(  client_name => 'auto optimizer stats collection',
                    operation => NULL,  window_name => NULL);
END;

-----------------------------------------------------------------------------------------------------------------------------
alter session set container = pdbxe;
-- Atualiza estatisticas de objetos.
exec dbms_stats.gather_table_stats('SOE','ORDERS');

-- ver se determinado objeto possui estatistica atualizada (coluna LAST_ANALYZED)
SELECT  OWNER, TABLE_NAME, avg_row_len, blocks, empty_blocks, num_rows, TO_CHAR(last_analyzed, 'DD/MM/YYYY HH24:MI:SS') LAST_ANALYZED
FROM    DBA_TABLES
WHERE   OWNER = UPPER(NVL('&OWNER',OWNER))
AND     TABLE_NAME = UPPER(NVL('&TABLE_NAME',TABLE_NAME));

-- ver qtas alteracoes objeto ja teve desde a ultima coleta de estatisticas:
SELECT * FROM DBA_TAB_MODIFICATIONS
WHERE   TABLE_OWNER = UPPER(NVL('&OWNER',TABLE_OWNER))
AND     TABLE_NAME = UPPER(NVL('&TABLE_NAME',TABLE_NAME));