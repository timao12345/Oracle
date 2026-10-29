----------------------------------------------------------------------------------------
-- VERIFICAR OBJETOS SEM ESPAÇO PARA PROXIMO NEXT
----------------------------------------------------------------------------------------

select a.tablespace_name, a.maxNextExtent, b.maxFreeBytes
from ( select tablespace_name, max(next_extent) maxNextExtent
        from dba_segments
        group by tablespace_name ) a,
     ( select tablespace_name, max(bytes) maxFreeBytes
        from dba_free_space
        group by tablespace_name ) b
where a.tablespace_name = b.tablespace_name
  and a.maxNextExtent >= b.maxFreeBytes
/