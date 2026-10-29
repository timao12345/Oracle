SELECT t.owner,t.table_name,lr.value+pr.value AS total_reads
FROM (SELECT owner,object_name,value
        FROM v$segment_statistics
       WHERE statistic_name='logical reads') lr,
     (SELECT owner,object_name,value
        FROM v$segment_statistics
       WHERE statistic_name='physical reads') pr,
dba_tables t
WHERE lr.owner=pr.owner AND lr.object_name=pr.object_name
  AND lr.owner=t.owner AND lr.object_name=t.table_name
ORDER BY 3 desc