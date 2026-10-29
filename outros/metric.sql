column metric_name format a30
select to_char(a.begin_time, 'dd/mm/yyyy hh24:mi:ss') begin_time, 
       to_char(a.end_time,  'dd/mm/yyyy hh24:mi:ss') end_time,
       a.metric_name metric_name, 
       to_char(a.value, '9999999.99') value, 
       a.metric_unit
 from v$sysmetric a
where upper(a.metric_name) like upper('%&metrica%')
order by a.metric_name
/
