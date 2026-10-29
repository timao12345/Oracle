-- verificando se coleta de estatisticas automatica esta habilitada (11G)
select client_name,status from dba_autotask_client
where  client_name = 'auto optimizer stats collection'; -- valor da coluna status deve ser ENABLED
	
-- verificar duracao da coleta de estatisticas
select  operation,target,start_time,end_time 
from    dba_optstat_operations
where   operation='gather_database_stats(auto)';

-- ver se determinado objeto possui estatistica atualizada (coluna LAST_ANALYZED)
SELECT  OWNER, TABLE_NAME, avg_row_len, blocks, empty_blocks, num_rows, TO_CHAR(last_analyzed, 'DD/MM/YYYY HH24:MI:SS') LAST_ANALYZED
FROM    DBA_TABLES
WHERE   OWNER = '&OWNER' AND last_analyzed < sysdate -1
AND     TABLE_NAME = UPPER(NVL('&TABLE_NAME',TABLE_NAME));

-- habilitando a coleta de estatisticas de objeto automatica no 11g:
BEGIN
  DBMS_AUTO_TASK_ADMIN.ENABLE(
    client_name => 'auto optimizer stats collection',
    operation => NULL,
    window_name => NULL);
END;
/