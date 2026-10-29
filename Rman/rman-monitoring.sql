-- ASYNC
select sid, serial, use_count, status, filename,EFFECTIVE_BYTES_PER_SECOND,type,open_time,
       round(bytes/1024/1024/1024,2) gbytes 
from  v$backup_async_io 
where status <>'FINISHED';

-- ASYNC
select sid, serial, use_count, status, EFFECTIVE_BYTES_PER_SECOND,type,BUFFER_SIZE,BUFFER_COUNT,MAXOPENFILES,
       round(bytes/1024/1024/1024,2) gbytes 
from  v$backup_async_io 
where status <> 'FINISHED';




--SYNC
select sid, serial, use_count, status, filename, EFFECTIVE_BYTES_PER_SECOND,type,
       round(bytes/1024/1024/1024,2) gbytes 
from  v$backup_sync_io 
where status <> 'FINISHED';



BUFFER_COUNT
TOTAL_BYTES 
OPEN_TIME   
CLOSE_TIME  
ELAPSED_TIME
MAXOPENFILES
BYTES       