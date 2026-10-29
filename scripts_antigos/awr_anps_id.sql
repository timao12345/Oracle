-- Check snps Ids awr
set lines 180 pages 999
select snap_id,
  snap_level,
  INSTANCE_NUMBER,
  to_char(begin_interval_time, 'dd/mm/yy hh24:mi:ss') begin
from 
   dba_hist_snapshot 
where instance_number=1
order by 1;
