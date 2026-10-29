-- Ver os blocos de dados de um datafile
col name for a35
select file_id, block_id, blocks*8192/1024 MB, owner || '.' || segment_name "Name",SEGMENT_TYPE, block_id*8192/1024 "Position MB"
from  sys.dba_Extents
where file_id = 11
   union  
      select file_id, block_id, blocks*8192/1024, 'Free' "Name",'Free', block_id*8192/1024 "Position MB" from sys.dba_free_space  
where file_id = 11 order by 1,2,3;

-- // --
set verify off 
column value new_val blksize 
select value from v$parameter where name = 'db_block_size';


select a.file_id, a.file_name, 
   ceil((nvl(hwm,1)*&&blksize)/1024) smallest, 
   ceil(blocks*&&blksize/1024) currsize, 
   ceil(blocks*&&blksize/1024) - ceil((nvl(hwm,1)*&&blksize)/1024) savings 
   from dba_data_files a, 
   (select file_id, max(block_id+blocks-1) hwm 
    from dba_extents where owner='SYSRHDC' 
group by file_id) b
where a.file_id = b.file_id;

 --
undef file_id
undef block_id
set pagesize 5555
set linesize 5555
col segment_name for a30
SELECT owner, segment_name, segment_type,tablespace_name
FROM dba_extents     
WHERE file_id = &file_id  
and &block_id between block_id AND block_id + blocks - 1;



undef file_id
undef block_id
set pagesize 5555
set linesize 5555
col segment_name for a30

SELECT owner, segment_name, segment_type,tablespace_name
FROM dba_extents     
WHERE block_id = &bloco  ;

