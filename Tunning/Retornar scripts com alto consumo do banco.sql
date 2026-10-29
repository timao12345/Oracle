--Retorna querys com maior tempo de execução na instancia atual
SELECT *
  FROM (  SELECT ROUND ( ( (cpu_time / 1000000) / 60), 2) AS "Tempo total de CPU",
                 executions AS "Quant. exec.",
                 rows_processed AS "Quant. linhas proc.",
                 disk_reads AS "Leituras no disco",
                 first_load_time AS "Primeira utilização",
                 last_load_time AS "Última utilização",
                 parsing_schema_name AS "Usuário analisado",
                 sql_text AS "SQL exec."
            FROM v$sqlarea
           WHERE parsing_schema_name NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
        ORDER BY 1 DESC)
 WHERE ROWNUM <= 10;