select distinct ('Grant all privileges on &owner||'.'||object_name||' to &usuario ;')
from dba_objects
where owner = '&owner'
order by 1;

select distinct ('create synonym &usuario'||'.'||object_name||' for &owner||'.'||object_name||';')
from dba_objects
where owner = '&owner'
order by 1;