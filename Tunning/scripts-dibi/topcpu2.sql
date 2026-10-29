col sql_text for a85
set lines 1000
set pages 10000
select rownum as top, 
       x.* 
from (
select 
     sql_id,
	 cpu_time,
	 executions,
	 round(cpu_time/executions,4) as cpu_avg,
	 elapsed,
	 round(elapsed/executions ,4) as elap_avg,
	 buffer_gets/executions as buffer_gets_avg
	 ,translate(sql_text, chr(10) || chr(13) || chr(09), ' ') as sql_text
from (
	select h.sql_id,     
		   greatest(sum(executions_delta) ,1) as executions,
		   sum(CPU_TIME_DELTA)/1e6     as cpu_time,
		   sum(ELAPSED_TIME_DELTA)/1e6 as elapsed,
		   sum(ROWS_PROCESSED_DELTA)   as rows_processed,
		   sum(iowait_delta)/1000000   as iowait,
		   sum(BUFFER_GETS_DELTA)      as buffer_gets,
		   sum(DISK_READS_DELTA)       as disk_reads
		   , dbms_lob.substr(t.sql_text,50,1) as sql_text
	  from dba_hist_sqlstat h
 left join dba_hist_sqltext t on (h.dbid = t.dbid and h.sql_id = t.sql_id)
	 where 1=1 
	   and h.snap_id >  61220 -- O TOP 10 no AWR em HTML desconsidera o snapshot 
	   and h.snap_id <= 62688 
	   and (0 = 0 or h.instance_number = 4)
	   and h.executions_delta > 0
  group by h.sql_id, dbms_lob.substr(t.sql_text,50,1)
  order by cpu_time desc
  )
) x where rownum <= 50
/
