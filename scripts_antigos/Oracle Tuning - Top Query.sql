-- Inicialização
create table tuning_sql_stats as
select sql_id, 2 snap_id, sysdate snap_time, executions, cpu_time, application_wait_time, concurrency_wait_time, cluster_wait_time, user_io_wait_time, plsql_exec_time, java_exec_time
from v$sqlstats;

-- Loop
delete tuning_sql_stats where snap_id = 1;
update tuning_sql_stats set snap_id = 1 where snap_id = 2;
insert into tuning_sql_stats
select sql_id, 2 snap_id, sysdate snap_time, executions, cpu_time, application_wait_time, concurrency_wait_time, cluster_wait_time, user_io_wait_time, plsql_exec_time, java_exec_time
from v$sqlstats;
commit;

-- Top queries do período
with
  times as
   (select
      t2.sql_id,
      t2.snap_time-t1.snap_time elapsed_time,
      t2.executions-t1.executions executions,
      (t2.cpu_time-t1.cpu_time)/1000000 cpu_time,
      (t2.application_wait_time-t1.application_wait_time)/1000000 application_wait_time,
      (t2.concurrency_wait_time-t1.concurrency_wait_time)/1000000 concurrency_wait_time,
      (t2.cluster_wait_time-t1.cluster_wait_time)/1000000 cluster_wait_time,
      (t2.user_io_wait_time-t1.user_io_wait_time)/1000000 user_io_wait_time,
      (t2.plsql_exec_time-t1.plsql_exec_time)/1000000 plsql_exec_time,
      (t2.java_exec_time-t1.java_exec_time)/1000000 java_exec_time
    from
      tuning_sql_stats t2,
      tuning_sql_stats t1
    where
      t1.snap_id = 1 and
      t2.sql_id = t1.sql_id and
      t2.snap_id = 2),
  queries as
   (select
      sql_id,
      round(elapsed_time*24*60*60,0) window_time_s,
      round(executions,1) executions,
      round(cpu_time,1) "CPU",
      round(application_wait_time,1) "APPLICATION",
      round(concurrency_wait_time,1) "CONCURRENCY",
      round(cluster_wait_time,1) "CLUSTER",
      round(user_io_wait_time,1) "USER_IO",
      round(plsql_exec_time,1) "PLSQL",
      round(java_exec_time,1) "JAVA",
      row_number() over(partition by 1 order by cpu_time+application_wait_time+concurrency_wait_time+cluster_wait_time+user_io_wait_time+plsql_exec_time+java_exec_time desc) seq,
      cpu_time+application_wait_time+concurrency_wait_time+cluster_wait_time+user_io_wait_time+plsql_exec_time+java_exec_time time,
      sum(cpu_time+application_wait_time+concurrency_wait_time+cluster_wait_time+user_io_wait_time+plsql_exec_time+java_exec_time) over(partition by 1) total_time
    from
      times
    where
      elapsed_time > 0)
select
  q.*,
  round(q.time/q.total_time*100,1) perc,
  s.sql_fulltext
from
  v$sqlstats s,
  queries q
where
  q.seq <= 10 and
  s.sql_id = q.sql_id
order by q.seq;

-- Limpar o ambiente
drop table tuning_sql_stats purge;
