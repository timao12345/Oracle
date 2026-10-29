--Top 10 querys com maior tempo de execução.
select
   sql_id,
   --child_number,
   sql_text,
   disk_reads,
   elapsed_time
from
   (select
      sql_id,
      child_number,
      sql_text,
      elapsed_time,
      cpu_time,
      disk_reads,
rank () over (order by disk_reads desc) as sql_rank from v$sql)
where
   sql_rank < 11;



