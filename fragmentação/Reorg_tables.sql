/*How to remove table fragmentation in oracle?

There are different ways to remove fragmentation like table export/import, moving tables to same or different tablespace and table recreation. But here we will discuss most easy and common ways of removing fragmentation.
Steps To Check and Remove Fragmentation:*/


/*STEP 1: First Gather table statistics
In order to find the exact difference between the total size and actual size of the table from dba_segments and dba_tables views. You can also check the last analysed date of a table. If table has recently analysed and stale_stats is no then you can skip this step.*/ 


select table_name,last_analyzed,stale_stats from user_tab_statistics where table_name='&TABLE_NAME';
EXEC dbms_stats.gather_table_stats(ownname => 'TABLE_OWNER', tabname => 'TABLE_NAME', method_opt=> 'for all indexed columns size skewonly', granularity => 'ALL', degree => 8 ,cascade => true,estimate_percent => 15);


-- Step 2: Check table size from dba_segments
select sum(bytes)/1024/1024/1024 from dba_segments where segment_name='&TABLE_NAME';

--STEP 3: Check actual table size, fragmented size and percentage of fragmentation in a table.
select table_name,avg_row_len,round(((blocks*16/1024)),2)||'MB' "TOTAL_SIZE",
round((num_rows*avg_row_len/1024/1024),2)||'Mb' "ACTUAL_SIZE",
round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2) ||'MB' "FRAGMENTED_SPACE",
(round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2)/round(((blocks*16/1024)),2))*100 "percentage"
from dba_tables WHERE table_name='&TABLE_NAME';

/*Note: If you find more than 20% fragmentation then you can proceed for de-fragmentation. You can also de-fragment based on size you are going to reclaim from the above mentioned  query.*/

-- STEP 4:  Check the indexes on the table
select index_name from dba_indexes where table_name='&TABLE_NAME';

-- STEP 5: Remove fragmentation by moving tables to same tablespace. You can also move tables to different tablespace.
alter table <table_name> move;  

--For moving tables into different tablespace

alter table <table_name> enable row movement;
alter table <table_name> move tablespace <new_tablespace>

-- STEP 6: Rebuild the indexes.
alter index index_name rebuild online;

-- Step 7: Gather the statistics:
EXEC dbms_stats.gather_table_stats(ownname => 'TABLE_OWNER', tabname => 'TABLE_NAME', method_opt=> 'for all indexed columns size skewonly', granularity => 'ALL', degree => 8 ,cascade => true,estimate_percent => 15);

-- STEP 8: Finally check the table size and percentage of fragmentation:
select sum(bytes)/1024/1024/1024 from dba_segments where segment_name='&TABLE_NAME';

select table_name,avg_row_len,round(((blocks*16/1024)),2)||'MB' "TOTAL_SIZE",
round((num_rows*avg_row_len/1024/1024),2)||'Mb' "ACTUAL_SIZE",
round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2) ||'MB' "FRAGMENTED_SPACE",
(round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2)/round(((blocks*16/1024)),2))*100 "percentage"
from all_tables WHERE table_name='&TABLE_NAME';

/*Please note that the above mentioned steps is only for non-partitioned tables. For partitioned tables you can move table partition by partition or the easiest way is to recreate the table.*/