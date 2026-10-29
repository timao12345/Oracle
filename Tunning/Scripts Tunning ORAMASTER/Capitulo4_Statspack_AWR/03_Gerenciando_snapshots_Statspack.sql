-- listar snapshots em ordem decrescente:
 select  s.snap_id, s.snap_time, snap_level
      from    stats$snapshot s
      join    stats$database_instance di
        on    s.dbid = di.dbid 
       and    s.instance_number = di.instance_number 
       and    di.startup_time     = s.startup_time
      join    v$database d
        on    d.dbid = s.dbid
      join    v$instance i
        on    s.instance_number = i.instance_number 
      where   s.snap_time > (sysdate - 1) -- filtrar ultimos 7 dias
      ORDER BY s.snap_time asc;
	  
-- criar snapshot manualmente:
EXECUTE STATSPACK.SNAP;

-- apagar snapshots:
 exec statspack.PURGE(I_BEGIN_SNAP => &BEGIN_SNAP, I_END_SNAP => &END_SNAP);
 
	  
	  