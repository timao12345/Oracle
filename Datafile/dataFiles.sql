set lines 400
column file_name format a60
column tablespace_name format a15
select a.tablespace_name, (b.block_size/1024) blocoK ,  
       a.file_name, a.bytes/1024/1024 sizeMB, a.autoextensible, 
       (a.increment_by * b.block_size) /1024/1024 incrMB, 
       case
          when (a.maxbytes)/1024/1024 > 32760 then 'Unlim.'
       else
          to_char(a.maxbytes/1024/1024)
       end maximoMB
  from dba_data_files a, dba_tablespaces b
 where a.tablespace_name = b.tablespace_name
union
select a.tablespace_name, (b.block_size/1024) blocoK ,  
       a.file_name, a.bytes/1024/1024 sizeMB, a.autoextensible, 
       (a.increment_by * b.block_size) /1024/1024 incrMB, 
       case
          when (a.maxbytes)/1024/1024 > 32760 then 'Unlim.'
       else
          to_char(a.maxbytes/1024/1024)
       end maximoMB
  from dba_temp_files a, dba_tablespaces b
 where a.tablespace_name = b.tablespace_name
order by tablespace_name