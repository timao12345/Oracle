show parameter db_unique_name

select count(type), type 
from v$logfile
group by type
order by 2;

exit;
