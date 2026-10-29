select a.owner, a.object_type, a.object_name, c.owner, c.object_type, c.object_name, c.status, c.created, c.last_ddl_time
  from dba_objects a,
       dba_dependencies b,
	   dba_objects c
 where a.status = 'INVALID' 
   and a.object_name = b.name
   and b.referenced_owner = c.owner
   and b.referenced_name  = c.object_name
   and c.last_ddl_time > sysdate-2
   