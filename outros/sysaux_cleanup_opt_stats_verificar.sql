set linesize 120
set pagesize 100
COLUMN "Item" FORMAT A25
COLUMN "Space Used (GB)" FORMAT 999.99
COLUMN "Schema" FORMAT A25
COLUMN "Move Procedure" FORMAT A40
SELECT  occupant_name "Item",
    space_usage_kbytes,
    schema_name "Schema",
    move_procedure "Move Procedure"
FROM v$sysaux_occupants
ORDER BY 1
/


col Mb form 9,999,999
col SEGMENT_NAME form a40
col SEGMENT_TYPE form a6
set lines 120
select sum(bytes/1024/1024) Mb, segment_name,segment_type from dba_segments
where  tablespace_name = 'SYSAUX'
and segment_name like 'WRI$_OPTSTAT%'
and segment_type='TABLE'
group by segment_name,segment_type order by 1 asc
/


col Mb form 9,999,999
col SEGMENT_NAME form a40
col SEGMENT_TYPE form a6
set lines 120
select sum(bytes/1024/1024) Mb, segment_name,segment_type from dba_segments
where  tablespace_name = 'SYSAUX'
and segment_name like '%OPT%'
and segment_type='INDEX'
group by segment_name,segment_type order by 1 asc
/


select 'alter table '||segment_name||'  move tablespace SYSAUX;' from dba_segments where tablespace_name = 'SYSAUX'
and segment_name like '%OPT%' and segment_type='TABLE'
/


select 'alter index '||segment_name||'  rebuild online parallel (degree 14);' from dba_segments where tablespace_name = 'SYSAUX'
and segment_name like '%OPT%' and segment_type='INDEX'
/


select  di.index_name,di.index_type,di.status  from  dba_indexes di , dba_tables dt
where  di.tablespace_name = 'SYSAUX'
and dt.table_name = di.table_name
and di.table_name like '%OPT%'
order by 1 asc
/


exec dbms_stats.alter_stats_history_retention(10); <-- dias de retenção
/


