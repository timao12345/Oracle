set feedback off
set lines 600 pages 1000
set head on
col "Create Time" format a23
col name format a20
col curr_size_mb format 99999999.9
col growth_per_day format 99999999.9
col projection_growth_30_days format 99999999.9
col projection_growth_90_days format 99999999.9
col projection_growth_180_days format 99999999.9
col projection_growth_365_days format 99999999.9
break on report
compute sum of curr_size_mb on report
compute sum of growth_per_day on report
compute sum of projection_growth_30_days on report
compute sum of projection_growth_90_days on report
compute sum of projection_growth_180_days on report
compute sum of projection_growth_365_days on report
select min(creation_time) "Create Time", ts.name, round(sum(df.bytes)/1024/1024/1024) curr_size_mb,
round( (sum(df.bytes)/1024/1024/1024)/round(sysdate-min(creation_time)),1) growth_per_day,
round( (sum(df.bytes)/1024/1024/1024)/round(sysdate-min(creation_time)) * 30,1) projection_growth_30_days,
round( (sum(df.bytes)/1024/1024/1024)/round(sysdate-min(creation_time)) * 90,1) projection_growth_90_days,
round( (sum(df.bytes)/1024/1024/1024)/round(sysdate-min(creation_time)) * 180,1) projection_growth_180_days,
round( (sum(df.bytes)/1024/1024/1024)/round(sysdate-min(creation_time)) * 365,1) projection_growth_365_days
from v$datafile df ,v$tablespace ts where df.ts#=ts.ts# and ts.name not like '%UNDO%' group by df.ts#,ts.name order by ts.name;