SELECT a.name "Latch Name",
a.gets "Gets (Wait)",
a.misses "Misses (Wait)",
(1 - (misses / gets)) * 100 "Latch Hit Ratio %"
FROM v$latch a
WHERE a.gets != 0
AND LOWER(a.name) in('cache buffers chains', 'cache buffers lru chain' , 'row cache objects', 'redo allocation' , 'redo copy' )
UNION
SELECT a.name "Latch Name",
a.gets "Gets (Wait)",
a.misses "Misses (Wait)",
100 "Latch Hit Ratio"
FROM v$latch a
WHERE a.gets = 0
AND LOWER(a.name) in('cache buffers chains', 'cache buffers lru chain' , 'row cache objects', 'redo allocation' , 'redo copy' )
ORDER BY 1