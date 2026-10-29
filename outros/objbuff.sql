select buff.*, (nro_buffers*par.VALUE ) /1024 /1024 mbytes,
               ((par2.value * percentual_buffers) / 100) /1024/1024 mbytes2
from (
    select owner,
           object_name                  ,
           count(1)                nro_buffers     ,
          (count(1)/(select count(*) from v$bh)) *100  percentual_buffers
    from dba_objects o,
         v$bh        bh
    where o.object_id  = bh.objd
      and o.owner not in ('SYS','SYSTEM','AURORA$JIS$UTILITY$','SYSMAN')
    group by owner, object_name )  buff,
    v$parameter par,
    v$parameter par2
where par.NAME = 'db_block_size'
  and par2.NAME ='db_cache_size'

