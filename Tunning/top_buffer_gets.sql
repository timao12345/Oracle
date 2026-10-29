-- top 50 querys com maior buffer gets
set lines 500
set pages 500
SELECT *
FROM (SELECT SQL_ID,SQL_FULLTEXT,BUFFER_GETS
        FROM V$SQL
       ORDER BY BUFFER_GETS DESC)
WHERE ROWNUM <= 10;