--
--
--   NAME
--     asmspc.sql
--
--   DESCRIPTION
--     Monitoramento Tablespace Temporário.
--
--   HISTORY
--     31/01/2013 => Carlos Dornelas
--
-----------------------------------------------------------------------------



###########################################
### Monitoramento Tablespace Temporário ###
###########################################


SELECT
d.tablespace_name tablespace_name,
d.status tablespace_status,
round(a.bytes/1024/1024) tablespace_size_mb,
--NVL(a.bytes, 0) tablespace_size,
round(t.bytes/1024/1024) used_mb,
--NVL(t.bytes, 0) used,
TRUNC(NVL(t.bytes / a.bytes * 100, 0)) used_pct,
NVL(s.current_users, 0) current_users
FROM sys.dba_tablespaces d,
(select tablespace_name, sum(bytes) bytes
from dba_temp_files
group by tablespace_name) a,
(select tablespace_name, sum(bytes_cached) bytes
from gv$temp_extent_pool
group by tablespace_name) t,
gv$sort_segment s
WHERE d.tablespace_name = a.tablespace_name(+)
AND d.tablespace_name = t.tablespace_name(+)
AND d.tablespace_name = s.tablespace_name(+)
AND d.extent_management like 'LOCAL'
AND d.contents like 'TEMPORARY'
/
