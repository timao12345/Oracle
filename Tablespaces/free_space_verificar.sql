SELECT *
  FROM (SELECT c.tablespace_name,
               ROUND(a.bytes / 1048576, 2) MB_Allocated,
               ROUND(b.bytes / 1048576, 2) MB_Free,
               ROUND((a.bytes - b.bytes) / 1048576, 2) MB_Used,
               ROUND(b.bytes / a.bytes * 100, 2) tot_Pct_Free,
               ROUND((a.bytes - b.bytes) / a.bytes, 2) * 100 tot_Pct_Used
          FROM (SELECT tablespace_name, SUM(a.bytes) bytes
                  FROM sys.DBA_DATA_FILES a
                 GROUP BY tablespace_name) a,
               (SELECT a.tablespace_name, NVL(SUM(b.bytes), 0) bytes
                  FROM sys.DBA_DATA_FILES a, sys.DBA_FREE_SPACE b
                 WHERE a.tablespace_name = b.tablespace_name(+)
                   AND a.file_id = b.file_id(+)
                 GROUP BY a.tablespace_name) b,
               sys.DBA_TABLESPACES c
         WHERE a.tablespace_name = b.tablespace_name(+)
           AND a.tablespace_name = c.tablespace_name)
 WHERE tot_Pct_Used >= 0
 ORDER BY tot_Pct_Free