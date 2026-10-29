column size_for_estimate         format 999,999,999,999 heading 'Cache Size (m)'
column buffers_for_estimate      format 999,999,999 heading 'Buffers'
column estd_physical_read_factor format 999.90 heading 'Estd Phys|Read Factor'
column estd_physical_reads       format 999,999,999 heading 'Estd Phys| Reads'

SELECT size_for_estimate, buffers_for_estimate
     , estd_physical_read_factor, estd_physical_reads
  FROM V$DB_CACHE_ADVICE
 WHERE name          = 'DEFAULT'
   AND block_size    = (SELECT value FROM V$PARAMETER 
                         WHERE name = 'db_block_size')
   AND advice_status = 'ON';


SELECT SQL_ID, SUBSTR(sql_text, 1, 40) "SQL",
invalidations
FROM v$sqlarea
ORDER BY invalidations DESC;

select namespace,pins,reloads,invalidations
From v$librarycache;

select SUM(pins) "Executions",
SUM(reloads) "Cache Misses",
(SUM(reloads)/SUM(pins))*100 "Reload-to-pins Ratio"
From v$librarycache;

select sum(pins)/(sum(pins)+sum(reloads))*100 "Cache Hit Ration"
From v$librarycache;


select shared_pool_size_for_estimate AS po_size,
estd_lc_time_saved
from v$shared_pool_advice;

ALTER SYSTEM SET SHARED_POOL_SIZE = 1024M SCOPE=BOTH;

select (1-(sum(getmisses)/sum(gets)))*100 "Dic Cache Hit Ratio" 
From v$rowcache;

select parameter,gets,getmisses, TRUNC(decode(gets,0,'0',(getmisses/gets)*100),2)||'%' "Miss Ratio"
from v$rowcache
order by gets desc;

