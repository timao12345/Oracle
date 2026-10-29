select sid, serial, RMAN_STATUS_RECID , RMAN_STATUS_STAMP ,
 type, status, filename, total_bytes/power(1024,3), open_time, close_time,
 to_char (trunc (sysdate) + elapsed_time/100/60/60/24, 'hh24:mi:ss') e_time,
bytes/power(1024,2), EFFECTIVE_BYTES_PER_SECOND/power(1024,2)
from v$backup_async_io
/