-- 1: verificando estatisticas de objetos do dicionario de dados:
SELECT 		NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, 
			COUNT(*) dictionary_tables
FROM 		dba_tables
WHERE 		owner = 'GLOBUS327'
GROUP BY 	TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 	1 DESC;

-- 2: coletando estatisticas de objetos do DD:
EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

-- 3: verificando estatisticas de objetos fixos:
select 		NVL(TO_CHAR(last_analyzed, 'YY-Mon-DD'), 'NO STATS') last_analyzed, 
			COUNT(*) fixed_objects
FROM 		dba_tab_statistics
WHERE 		object_type = 'FIXED TABLE'
GROUP BY 	NVL(TO_CHAR(last_analyzed, 'YY-Mon-DD'), 'NO STATS')
ORDER BY 	1 DESC;

-- 4: coletando estatisticas de objetos fixos:
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS();


-- Mais info: https://blogs.oracle.com/optimizer/entry/fixed_objects_statistics_and_why