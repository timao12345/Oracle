select d.FILE_NAME , round(x.total_file * 100 / y.total_bytes,2)
from sys.DBA_DATA_FILES  d,
(select a.FILE_ID, sum(bytes) total_file
  from dba_extents a
-- where a.OWNER = 'SAUDE'
 group by a.FILE_ID) x,

(select sum(bytes) total_bytes
  from dba_extents a
-- where a.OWNER = 'SAUDE') y
where d.file_id = x.FILE_ID



