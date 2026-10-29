select event, count(sid) as "QTD SESSOES", sum(wait_time), sum(seconds_in_wait), wait_class 
from v$session_wait
group by event, wait_class
order by sum(seconds_in_wait) desc
/