select 	o.owner, o.object_name, o.subobject_name, o.object_type, a.sql_text
from	dba_objects o
join	v$session s 
on		o.object_id = s.row_wait_obj#
join	v$sqlarea a
on		a.sql_id = s.sql_id
where 	s.event = 'buffer busy waits';