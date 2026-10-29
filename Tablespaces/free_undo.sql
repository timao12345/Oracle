col tablespace_name for a30
SELECT size_allocated.tablespace_name,
          size_allocated.size_allocated_mb,
          size_used.size_used_mb,
          ROUND ( size_used.size_used_mb /
          size_allocated.size_allocated_mb *
          100,  2 ) pct_size_used_mb
     FROM ( SELECT due.tablespace_name,
                   SUM (due.BYTES) / 1024 / 1024 AS size_used_mb
              FROM dba_undo_extents due
          GROUP BY due.tablespace_name) size_used,
            ( SELECT dt.tablespace_name,
                     SUM (ddf.BYTES) / 1024 / 1024 size_allocated_mb
                FROM dba_tablespaces dt, dba_data_files ddf
               WHERE dt.tablespace_name = ddf.tablespace_name
                 AND dt.CONTENTS = 'UNDO'
            GROUP BY dt.tablespace_name) size_allocated
    WHERE size_allocated.tablespace_name =
          size_used.tablespace_name(+)
 ORDER BY tablespace_name DESC;
