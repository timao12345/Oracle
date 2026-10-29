undef UNDO
SELECT  tablespace_name, STATUS, SUM(BYTES/1024/1024), COUNT(*) FROM DBA_UNDO_EXTENTS where tablespace_name = '&&UNDO'
GROUP BY tablespace_name, STATUS order by 1;
