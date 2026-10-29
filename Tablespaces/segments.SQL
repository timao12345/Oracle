select a.OWNER, a.TABLESPACE_NAME, a.SEGMENT_NAME, a.SEGMENT_TYPE, sum(bytes)/1024/1024 mbytes, count(*) fragmentos
  from dba_extents a
 where a.OWNER = '&1'
group by a.OWNER, a.TABLESPACE_NAME, a.SEGMENT_NAME, a.SEGMENT_TYPE
Order by 6 Desc