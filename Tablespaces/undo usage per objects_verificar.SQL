select  s.username,  s.sid, s.osuser,     rn.name,     rs.extents
               ,rs.rssize /1024/1024 "Size (Mb)"
               ,rs.writes /1024/1024 "Mbytes used"
               ,rs.status,  t.used_ublk,  t.used_urec
               ,do.object_name
        from    v$transaction   t
               ,v$session       s
               ,v$rollname      rn
               ,v$rollstat      rs
               ,v$locked_object lo
               ,dba_objects     do
        where  t.addr        = s.taddr
        and    t.xidusn      = rn.usn
        and    rn.usn        = rs.usn
        and    t.xidusn      = lo.xidusn(+)
        and    do.object_id  = lo.object_id
