----------------------------------------------------------------------------------------
-- EVENTOS DE CONTEN��O BASE
----------------------------------------------------------------------------------------
col event format a40
col p1raw format a30

select sid, event, p1, p2, p3, p1raw 
from v$session_wait 
where sid > 9 and event not like 'SQL%' and event not like 'rdbms%';


select owner, segment_name, segment_type
from dba_extents
where file_id = &p1 AND
      &p2 between block_id AND block_id + blocks - 1;