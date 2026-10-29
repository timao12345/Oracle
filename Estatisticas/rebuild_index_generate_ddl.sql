PROMPT +----------------------------------------------------------------+
PROMPT | Index Fragmentation - Generate DDL                        v1.2 |
PROMPT +----------------------------------------------------------------+
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI';
SET SERVEROUTPUT ON
SET TRIMSPOOL OFF
UNDEF indexOwner, indexName, indexTablespace
ACCEPT indexOwner CHAR PROMPT "Owner:"
ACCEPT indexName CHAR PROMPT "Index:" 
ACCEPT indexTablespace CHAR PROMPT "Rebuild tablespace:"

SELECT CASE WHEN r.kb*1.20 >= ( ( SELECT SUM(CASE WHEN d.autoextensible='YES'
                                                       THEN CASE WHEN d.maxbytes > bytes
                                                                     THEN d.maxbytes
                                                                 ELSE d.bytes
                                                            END
                                                   ELSE d.bytes
                                              END)/1024 kb
                                    FROM dba_data_files d
                                   WHERE d.tablespace_name = r.tablespace_name
                                 )
                               - ( SELECT SUM(bytes)/1024 kb 
                                     FROM dba_segments 
                                    WHERE tablespace_name = r.tablespace_name
                                 )
                               )
            THEN 'Atencao!!! Espaco insuficiente no tablespace &indexTablespace para rebuild do index.'
           ELSE ( SELECT 'ALTER INDEX '||i.owner||'.'||i.index_name
                      || ' REBUILD'
                      || ' TABLESPACE '|| DECODE( ( SELECT COUNT(1) 
                                                      FROM dba_tablespaces 
                                                     WHERE tablespace_name = UPPER('&indexTablespace') 
                                                  )
                                                , 0 ,TABLESPACE_NAME
                                                , '&indexTablespace'
                                                )
                      || ( SELECT CASE WHEN p.maxparallel > 4 
                                       THEN ' PARALLEL 4' 
                                       ELSE ' PARALLEL '|| TO_CHAR(p.maxparallel)
                                       END val 
                             FROM ( SELECT MAX(DECODE(name,'cpu_count',value,null))
                                         * MAX(DECODE(name,'parallel_threads_per_cpu',value,null))
                                         * 0.25 maxparallel 
                                      FROM v$parameter 
                                     WHERE name in ('cpu_count','parallel_threads_per_cpu') 
                                  ) p
                         )
                      || DECODE ( ( SELECT COUNT(1) FROM v$version WHERE LOWER(banner) LIKE 'oracle database%enterprise%' )
                                , 1, ' ONLINE '
                                , ''
                                )
                   FROM dba_indexes i
                  WHERE i.owner LIKE UPPER('%&indexOwner%')
                    AND i.index_name LIKE UPPER('%&indexName%')
                )
       END info
  FROM ( SELECT tablespace_name 
              , SUM(bytes)/1024 kb
           FROM dba_segments s
          WHERE s.owner LIKE UPPER('%&indexOwner%')
            AND s.segment_name LIKE UPPER('%&indexName%')
          GROUP BY tablespace_name
       ) r

/