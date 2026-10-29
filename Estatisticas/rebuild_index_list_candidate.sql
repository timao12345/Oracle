PROMPT +----------------------------------------------------------------+
PROMPT | Index Fragmentation Analysis                              v1.2 |
PROMPT +----------------------------------------------------------------+
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI';
SET SERVEROUTPUT ON
SET TRIMSPOOL OFF
UNDEF indexOwner, indexName, indexTablespace
ACCEPT indexOwner CHAR PROMPT "Owner:"
ACCEPT indexName CHAR PROMPT "Index:" 

PROMPT ---> Analyzing index(es) like "%&indexOwner%.%indexName%" with validate structure.
BEGIN
   DBMS_OUTPUT.ENABLE();
   DBMS_OUTPUT.PUT_LINE(  RPAD('CollectDate',19,' ')
                       || RPAD('Index',61,' ')
                       || LPAD('Mbytes',10,' ')||' '
                       || RPAD('Rows Per Key',13,' ')
                       || RPAD('LF Rows Used',14,' ')
                       || RPAD('Del Entry',10,' ')
                       || RPAD('Height',7,' ')
                       || 'RebuildCandidate'
                       );
   FOR indx IN ( SELECT i.owner||'.'||i.index_name name
                      , s.bytes/1024/1024 mb
                      , i.owner
                      , i.index_name
                   FROM dba_indexes i
                        INNER JOIN dba_segments s
                                ON s.owner = i.owner AND s.segment_name = i.index_name
                  WHERE i.owner LIKE UPPER('%&SCHEMA_NAME%')
                   
                  ORDER BY 2 ASC
               )
   LOOP
      EXECUTE IMMEDIATE 'ANALYZE INDEX '|| indx.owner||'.'||indx.index_name ||' VALIDATE STRUCTURE';
      FOR iStats IN ( SELECT ROUND( ( lf_rows - del_lf_rows) /(DECODE(lf_rows,0,0.01,lf_rows)) *100,2) lf_rows_used
                           , ROUND(del_lf_rows /(DECODE(lf_rows,0,0.01,lf_rows))*100,2) ibadness
                           , rows_per_key
                           , height
                           , CASE WHEN (del_lf_rows /(DECODE(lf_rows,0,0.01,lf_rows))*100) > 20 THEN 'Yes (fragmented)'
                                  WHEN height > 4 THEN 'Yes (>4 levels)'
                                  ELSE 'no'
                              END rebuild_candidate
                        FROM index_stats
                    )
      LOOP
         DBMS_OUTPUT.PUT_LINE(  RPAD(TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'),19,' ')
                             || RPAD(TO_CHAR(indx.name),61,' ')
                             || RPAD(TO_CHAR(indx.mb,'999999999'),11,' ')
                             || RPAD(iStats.rows_per_key,12,' ')
                             || RPAD(TO_CHAR(iStats.lf_rows_used,'099,99') || '%',14,' ')
                             || RPAD(TO_CHAR(iStats.ibadness,'099,99')||'%',11,' ')
                             || RPAD(iStats.height,7,' ')
                             || iStats.rebuild_candidate
                             );
      END LOOP;
   END LOOP;
END;
/

AND i.index_name LIKE UPPER('%&INDEX_NAME%')