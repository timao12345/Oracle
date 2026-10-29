undef file_id
undef block_id
set pagesize 5555
set linesize 5555
col segment_name for a30

SELECT owner, segment_name, segment_type,tablespace_name
FROM dba_extents     
WHERE file_id = &file_id  
and &block_id between block_id AND block_id + blocks - 1;

