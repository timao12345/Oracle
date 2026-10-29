----------------------------------------------------------------------------------------
-- VERIFICAR CONSUMO DE QUERY
----------------------------------------------------------------------------------------
col sql_text for a100
col "Usuario" for a15
SELECT *
  FROM (  SELECT ROUND ( ( (cpu_time / 1000000) / 60), 2) AS "Tempo total de CPU",
                 executions AS "Quant. exec.",
                 rows_processed AS "Quant. linhas proc.",
                 disk_reads AS "Leituras no disco",
                 first_load_time AS "Primeira utilizacao",
                 last_load_time AS "Ultima utilizacao",
                 parsing_schema_name AS "Usuario",
                 sql_text
            FROM v$sqlarea
           WHERE parsing_schema_name NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
        ORDER BY 1 DESC)
 WHERE ROWNUM <= 10;

-- filtrar pelo sql_id

col sql_text for a100
col "Usuario" for a15
SELECT *
  FROM (  SELECT sql_id,
                 ROUND ( ( (cpu_time / 1000000) / 60), 2) AS "Tempo CPU",
                 ROUND ( ( (ELAPSED_TIME / 1000000) / 60), 2) AS "Tempo exec",
                 executions AS "Quant. exec.",
                 rows_processed AS "Quant. linhas proc.",
                 disk_reads AS "Leituras no disco",
                 --first_load_time AS "Primeira utilizacao",
                 --last_load_time AS "Ultima utilizacao",
                 --parsing_schema_name AS "Usuario",
                 SHARABLE_MEM as "Shared Memory Used",
                 PERSISTENT_MEM as "QTD Memory Fixa usada",
                 RUNTIME_MEM as "QTD Memory Fixa necessaria",
                 sql_text
            FROM v$sqlarea
           WHERE parsing_schema_name NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
        ORDER BY 1 DESC)
 WHERE SQL_ID='crawma6yhcjm5';

-- Retorna querys com maior consumo utilizando a visão V$SQL_MONITOR("Options Diagnostic & Tuning Pack" necessário) 
-- show parameter control_management

select 
SQL_ID
from V$SQL_MONITOR
where SQL_ID='40gx8rwc5ktq5';