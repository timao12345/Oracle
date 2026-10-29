SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY off
COLUMN tablespace_name FORMAT a18 HEAD 'Tablespace'
COLUMN tablespace_status FORMAT a15 HEAD 'Status'
COLUMN tablespace_size FORMAT 999,999,999,999 HEAD 'TOTAL MB'
COLUMN used FORMAT 999,999,999,999 HEAD 'Usado MB'
COLUMN used_pct FORMAT 999 HEAD ' %Usado '
COLUMN current_users FORMAT 9,999 HEAD ' Usuários em uso'
COMPUTE SUM OF tablespace_size ON report
COMPUTE SUM OF used ON report
COMPUTE SUM OF current_users ON report
SELECT
d.tablespace_name tablespace_name, 
d.status tablespace_status, 
NVL(a.bytes/1024/1024, 0) "TOTAL MB", 
NVL(t.bytes/1024/1024, 0) "Usado MB", 
TRUNC(NVL(t.bytes / a.bytes * 100, 0)) used_pct, 
NVL(s.current_users, 0) "Usuários em uso"
FROM sys.dba_tablespaces d, 
( select tablespace_name, sum(bytes) bytes
from dba_temp_files group by tablespace_name) a, 
( select tablespace_name, sum(bytes_cached) bytes
from v$temp_extent_pool group by tablespace_name) t, 
v$sort_segment s
WHERE d.tablespace_name = a.tablespace_name(+) 
AND d.tablespace_name = t.tablespace_name(+) 
AND d.tablespace_name = s.tablespace_name(+) 
AND d.extent_management like 'LOCAL' 
AND d.contents like 'TEMPORARY'
/