select inst_id, username, count(1) 
from gv$session 
where username is not null
group by rollup(inst_id) , rollup(username) 
order by username, inst_id nulls last
/
