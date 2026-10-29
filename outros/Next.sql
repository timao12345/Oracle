----------------------------------------------------------------------------------------
-- VERIFICAR OBJETOS SEM ESPAÇO PARA PROXIMO NEXT
----------------------------------------------------------------------------------------

select substr(a.owner,1,8) "Dono",
       substr(a.segment_name,1,25) "Objeto",
       substr(a.segment_type,1,10) "Tipo",
       substr(a.tablespace_name,1,12) "Tablespace",
       a.next_extent/1024/1024 "Prox MB",
       c.bytes/1024/1024 "Free MB"
from dba_segments a, (select tablespace_name, max(bytes) bytes from dba_free_space group by tablespace_name) c
where a.next_extent >= c.bytes
  and a.tablespace_name = c.tablespace_name
order by a.owner, a.segment_name
/
