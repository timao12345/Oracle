-- Gerar scripts para realização do resize automatico --

set verify off
column file_name format a70 word_wrapped
column smallest format 999,990 heading "Smallest|Size|Poss."
column currsize format 999,990 heading "Current|Size"
column savings  format 999,990 heading "Poss.|Savings"
break on report
compute sum of savings on report

column value new_val blksize
select value from v$parameter where name = 'db_block_size'
/

select file_name,
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) smallest,
       ceil( blocks*&&blksize/1024/1024) currsize,
       ceil( blocks*&&blksize/1024/1024) -
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) savings
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
/

column cmd format a110 word_wrapped

select 'alter database datafile '''||file_name||''' resize ' ||
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 )  || 'm;' cmd
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
  and ceil( blocks*&&blksize/1024/1024) -
      ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) > 0
/


-- Seta autoextend 

select 'alter database datafile '''||file_name||''' autoextend on;' cmd
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
  and ceil( blocks*&&blksize/1024/1024) -
      ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) > 0
/

--Verficiar datafiles
col DATA_FILE_NAME for a58
set pagesize 50000
SELECT tablespace_name, 
       file_id, 
       file_name                                           DATA_FILE_NAME, 
       allocated_mbytes, 
       high_water_mark_mbytes, 
       free_mbytes, 
       Trunc(( free_mbytes / allocated_mbytes ) * 100, 2)  "% Free", 
       Trunc(allocated_mbytes - high_water_mark_mbytes, 2) Resizeble 
FROM   (SELECT ddf.tablespace_name 
               tablespace_name, 
               ddf.file_id                                            file_id, 
               ddf.file_name                                          file_name, 
               ddf.bytes / 1024 / 1024 
               Allocated_MBYTES, 
               Trunc(( ex.hwm * ( dt.block_size ) ) / 1024 / 1024, 2) 
                      High_Water_Mark_MBYTES, 
               free_mbytes 
        FROM   dba_data_files ddf, 
               dba_tablespaces dt, 
               (SELECT file_id, 
                       SUM(bytes / 1024 / 1024) FREE_MBYTES 
                FROM   dba_free_space 
                GROUP  BY file_id) free, 
               (SELECT file_id, 
                       Max(block_id + blocks) hwm 
                FROM   dba_extents 
                GROUP  BY file_id) ex 
        WHERE  ddf.file_id = ex.file_id 
               AND ddf.tablespace_name = dt.tablespace_name 
               AND ddf.file_id = free.file_id (+) 
        ORDER  BY ddf.tablespace_name, 
                  ddf.file_id)
                  order by 7 desc; 