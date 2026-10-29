Select snap_time, snap_id
from stats$snapshot
where snap_time between to_date('&data_ini', 'dd/mm/rrrr') 
                    and to_date('&data_fim', 'dd/mm/rrrr')+1-1/(24*60*60)
order by snap_time;
