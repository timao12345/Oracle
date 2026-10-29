set pages 3000 lines 120
col TABLESIZE_KB form 999,999,999
col ACTUALTABLESIZE_KB form 999,999,999
col DIFF_KB form 999,999,999
select owner,table_name, 
       round((blocks*8192/1024),2) tablesize_KB, 
       trunc(round((num_rows*avg_row_len/1024),2)) actualtablesize_KB, 
       (round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) diff_KB
from  dba_tables
where -- table_size>1 para excluir temp
   round((blocks*8192/1024),2)>1 
-- ganho acima de 100Mb (tablesize-actualsize>100Mb)
  and (round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) > 100000
order by diff_KB; 
