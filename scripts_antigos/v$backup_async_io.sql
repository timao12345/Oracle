select sid, serial,
 type, status, filename, total_bytes/power(1024,3) total_dbf, open_time, close_time,
 to_char (trunc (sysdate) + elapsed_time/100/60/60/24, 'hh24:mi:ss') e_time,
bytes/power(1024,2) tot_processado, EFFECTIVE_BYTES_PER_SECOND/power(1024,2),
sum (decode (type,'OUTPUT',total_bytes,0)/power(1024,2)) over (partition by sid, serial order by sid, serial) - (2*1024) tot1
from v$backup_async_io order by sid, type
/

doc
select sid, serial, type, status, filename, total_bytes/power(1024,3), open_time, close_time,
 elapsed_time, bytes/power(1024,3), EFFECTIVE_BYTES_PER_SECOND/power(1024,3), DISCRETE_BYTES_PER_SECOND
from v$backup_sync_io
/
#



