-- Verifica o tamanho total dos index por owner
col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Tamanho_MB on report
break on report
set lines 750 pages 1000 
select owner, segment_name,SEGMENT_TYPE ,sum(bytes)/1024/1024 as Tamanho_MB from dba_segments where SEGMENT_TYPE='INDEX' and segment_name like 'DFKKINFCO%'
group by owner,SEGMENT_TYPE,segment_name
order by Tamanho_MB;

-- Cria e executa o script para realizar o rebuild
set lines 850 pages 0
spool 'gera_script_rebuild_online.sql'
SELECT 'ALTER INDEX '||OWNER||'."'||INDEX_NAME||'" REBUILD ONLINE;' AS "INDEX REBUILDS:" FROM DBA_INDEXES WHERE OWNER='SYS';
spool off
@gera_script_rebuild_online.sql

--ou

set lines 850 pages 0;
spool 'gera_script_rebuild.sql';
set timing on;
select 'ALTER INDEX '||idx.OWNER||'.'||idx.segment_name||' REBUILD ONLINE;' AS "INDEX REBUILDS:" 
from (
    select owner, segment_name, sum(bytes)/1024/1024 as MB 
    from dba_segments 
    where owner in ('NETWIN') and segment_type='INDEX' 
    group by owner,segment_name order by MB)  idx;

spool off
set timing on;
@gera_script_rebuild.sql

exit;


-- Constroi DLL para realizar rebuild dos index do menor para o maior.
select 'ALTER INDEX '||idx.OWNER||'.'||idx.segment_name||' REBUILD ONLINE;' AS "INDEX REBUILDS:" 
from (
    select owner, segment_name, sum(bytes)/1024/1024 as MB 
    from dba_segments 
    where owner in ('NETWIN') and segment_type='INDEX' 
    group by owner,segment_name order by MB)  idx;


select 'ALTER INDEX '||idx.OWNER||'.'||idx.index_name||' REBUILD;' AS "INDEX REBUILDS:" 
from (
     select owner, index_name
    FROM DBA_INDEXES WHERE  TABLE_NAME = 'RF_AUXNOTAMESTR' and owner='CONSINCO') idx; 


    

-- lista os indices do menor para o maior.
col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000
col owner for a15
col SEGMENT_NAME for a35
select owner, segment_name, sum(bytes)/1024/1024 as "Size" from dba_segments 
where SEGMENT_TYPE='INDEX' 
--and owner='NETWIN' 
group by owner, segment_name order by 3 asc;



set lines 850 pages 0;
spool 'gera_script_rebuild.sql';
set timing on;
select 'ALTER INDEX '||idx.OWNER||'.'||idx.segment_name||' REBUILD;' AS "INDEX REBUILDS:" 
from (
    select owner, segment_name, sum(bytes)/1024/1024 as MB 
    from dba_segments 
    where segment_type='INDEX' 
    group by owner,segment_name order by MB)  idx;

spool off
set timing on;
@gera_script_rebuild.sql

exit;


--
set lines 850 pages 0;
spool 'gera_script_rebuild.sql';
set timing on;
SELECT
--s.owner,
--s.segment_name,
'-- ' || ROUND(s.bytes/1024/1024/1024,2) || ' GB ' || CHR(10) ||
'ALTER INDEX '||s.OWNER||'.'||s.segment_name||' REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;' AS CMD
FROM dba_segments s
WHERE s.owner = 'SAPSR3'
AND s.tablespace_name = 'PSAPSR3'
AND s.segment_type = 'INDEX'
AND (s.bytes/1024/1024/1024) >= 10
ORDER BY s.bytes ASC;
@gera_script_rebuild.sql

exit;



-- 50.03 GB
ALTER INDEX SAPSR3.DFKKOP~6 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 63.13 GB
ALTER INDEX SAPSR3.DFKKOP~Z04 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 63.13 GB
ALTER INDEX SAPSR3.DFKKOP~Z08 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 71.25 GB
ALTER INDEX SAPSR3.DFKKOP~Z06 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 84.25 GB
ALTER INDEX SAPSR3.DFKKOP~Z10 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 84.28 GB
ALTER INDEX SAPSR3.DFKKOP~Z01 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 87.03 GB
ALTER INDEX SAPSR3.DFKKOP~Z11 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 92.5 GB
ALTER INDEX SAPSR3.DFKKOP~5 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 101.75 GB
ALTER INDEX SAPSR3.DFKKOP~Z09 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;

-- 102.69 GB
ALTER INDEX SAPSR3.DFKKOP~Z07 REBUILD PARALLEL 20 TABLESPACE PSAPSR3750;
