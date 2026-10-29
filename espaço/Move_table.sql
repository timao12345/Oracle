-- Gera o script com extenção .sql para ser executado em nohup
SET PAGESIZE 0
SET LINESIZE 32767
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET ECHO OFF
SET TRIMSPOOL ON
SET TERMOUT OFF

SPOOL move_table_PSAPSR3_from_PSAPSR31.sql

SELECT
    --s.owner,
    --s.segment_name,
     '-- ' || ROUND(s.bytes/1024/1024/1024,2) || ' GB ' || CHR(10) ||
    'ALTER TABLE "'|| s.owner||'"."'||s.segment_name||'" MOVE TABLESPACE PSAPSR3750 ONLINE PARALLEL 15;' AS cmd
FROM dba_segments s
WHERE s.owner = 'SAPSR3'
AND s.tablespace_name = 'PSAPSR3'
AND s.segment_type = 'TABLE'
AND (s.bytes/1024/1024/1024) >= 50
ORDER BY s.bytes ASC;

SPOOL OFF;


--- /*/*/ ---
-- Conta todos tipos de objetos para saber o tamanho total
set lines 750 pages 1000 
col owner for a25
select OWNER,SEGMENT_TYPE, TABLESPACE_NAME,count(segment_name) QTD, sum(bytes/1024/1024/1024) as "Size(GB)" 
from dba_segments 
where OWNER='SAPSR3'
and TABLESPACE_NAME='PSAPSR3'
group by OWNER,SEGMENT_TYPE,TABLESPACE_NAME order by QTD ASC;

PSAPSR3750

SELECT l.owner,
       l.table_name,
       l.column_name,
       s.segment_name,
       l.tablespace_name,
       s.bytes/1024/1024 MB
FROM dba_lobs l
JOIN dba_segments s
  ON s.segment_name = l.segment_name
 AND s.owner = l.owner
WHERE l.owner = 'SAPSR3' and l.tablespace_name = 'PSAPSR3' order by s.bytes asc;


set lines 750 pages 1000 
col owner for a25
select OWNER, SEGMENT_NAME, sum(bytes/1024/1024/1024) as "Size(GB)" 
from dba_segments 
where OWNER='SAPSR3'
and TABLESPACE_NAME='PSAPSR3750' AND (bytes/1024/1024/1024) > 100
group by OWNER,SEGMENT_NAME order by 3 ASC;



SELECT
    COUNT(*) AS QTD_TABELAS,
    ROUND(SUM(bytes)/1024/1024/1024,2) AS TOTAL_GB,
    ROUND(SUM(bytes)/1024/1024/1024/1024,2) AS TOTAL_TB
FROM dba_segments
WHERE owner = 'SAPSR3'
AND tablespace_name = 'PSAPSR3750'
AND segment_type = 'INDEX'
AND (bytes/1024/1024/1024) <= 50;



WITH hwm AS (
    SELECT file_id,
           owner,
           segment_name,
           segment_type,
           TABLESPACE_NAME,
           block_id,
           blocks,
           block_id + blocks - 1 AS end_block,
           ROW_NUMBER() OVER (
               PARTITION BY file_id
               ORDER BY block_id + blocks - 1 DESC
           ) rn
    FROM dba_extents
    where TABLESPACE_NAME='PSAPSR3'
)
SELECT *
FROM hwm
WHERE rn = 1
ORDER BY file_id;




