-- verifica historico de alteração de parametro no awr
set linesize 155
col time for a15
col parameter_name format a50
col old_value format a30
col new_value format a30
break on instance skip 3
select instance_number instance, snap_id, time, parameter_name, old_value, new_value from (
select a.snap_id,to_char(end_interval_time,'DD-MON-YY HH24:MI') TIME, a.instance_number, parameter_name, value new_value,
lag(parameter_name,1) over (partition by parameter_name, a.instance_number order by a.snap_id) old_pname,
lag(value,1) over (partition by parameter_name, a.instance_number order by a.snap_id) old_value ,
decode(substr(parameter_name,1,2),'__',2,1) calc_flag
from dba_hist_parameter a, dba_Hist_snapshot b , v$instance v
where a.snap_id=b.snap_id
and a.instance_number=b.instance_number
and parameter_name like nvl('&parameter_name',parameter_name)
and a.instance_number like nvl('&instance_number',v.instance_number)
)
where
new_value != old_value
order by 1,2;


-- Outra opção de consultar um parametro específico
SELECT db.instance_number, s.snap_id, s.begin_interval_time, s.end_interval_time, db.parameter_name,db.value
FROM dba_hist_snapshot s join dba_hist_parameter db on db.snap_id=s.snap_id
where s.begin_interval_time > '31/07/25 00:00:00' and  s.end_interval_time < '31/07/25 23:59:59'
and db.parameter_name='log_archive_config' and db.instance_number=1
ORDER BY  2 asc;