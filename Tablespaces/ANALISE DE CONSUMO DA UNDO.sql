**VERIFICA��O DO TAMANHO E PORCENTAGEM DE UTILIZA��O DA UNDO


SELECT size_allocated.tablespace_name,
       size_allocated.size_allocated_mb,
       size_used.size_used_mb,
       ROUND (size_used.size_used_mb / size_allocated.size_allocated_mb * 100,  2) pct_size_used_mb
FROM (SELECT due.tablespace_name, SUM (due.BYTES) / 1024 / 1024 AS size_used_mb
         FROM dba_undo_extents due   GROUP BY due.tablespace_name) size_used,
      (SELECT dt.tablespace_name, SUM(ddf.BYTES)/1024/1024 size_allocated_mb
         FROM dba_tablespaces dt, dba_data_files ddf
        WHERE dt.tablespace_name = ddf.tablespace_name AND dt.CONTENTS = 'UNDO'
        GROUP BY dt.tablespace_name) size_allocated
WHERE size_allocated.tablespace_name = size_used.tablespace_name(+)
ORDER BY tablespace_name; 


TABLESPACE_NAME                          SIZE_ALLOCATED_MB    SIZE_USED_MB            PCT_SIZE_USED_MB
------------------------------          -----------------     ---------------         ----------------
PSAPUNDO                                 1125121               1019982.125            90.66


From <http://glufke.net/oracle/viewtopic.php?f=6&t=9300> 


***VERIFICA O TEMPO DE RETEN��O DA UNDO
SQL> show parameter ret

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_flashback_retention_target        integer     2880
sec_return_server_release_banner     boolean     FALSE
sort_area_retained_size              integer     0
undo_retention                       integer     28800


***VERIFICA A UTILIZA��O DA UNDO PELO USUARIO

select s.sid, s.username, s.PROGRAM, (v.rssize)/1024/1024 uso_mb
  from gv$rollstat v, 
       dba_rollback_segs d,
       gv$transaction t,
       gv$session s
where v.usn             = d.segment_id
       and t.ses_addr    = s.saddr
       and t.xidusn      = d.segment_id; 

From <http://glufke.net/oracle/viewtopic.php?f=6&t=9300> 






***UNDO STATS
select status,
         round(sum_bytes / (1024 * 1024), 0) as MB,
         round((sum_bytes / undo_size) * 100, 0) as PERC
    from (select status, sum(bytes) sum_bytes
            from dba_undo_extents
           group by status),
         (select sum(a.bytes) undo_size
            from dba_tablespaces c
            join v$tablespace b on b.name = c.tablespace_name
            join v$datafile a on a.ts# = b.ts#
           where c.contents = 'UNDO'
             and c.status = 'ONLINE');

             
STATUS     MB              PERC
---------- --------------- ---------------
ACTIVE              813466              72
EXPIRED              67678               6
UNEXPIRED           131914              12

