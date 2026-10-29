SELECT DECODE(partition_name, NULL, 
owner || '.' || s.segment_name, 
owner || '.' || s.segment_name || '.' || s.partition_name) particao, 
segment_type, bytes/1024, extents 
FROM sys.dba_segments s, ctxsys.dr$dbo m 
WHERE s.tablespace_name = 'SYSAUX' and s.owner like '%CTXSYS%' 
AND m.dbo_name = s.segment_name; 
