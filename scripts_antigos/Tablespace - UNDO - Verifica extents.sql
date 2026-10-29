-- Verifica status dos undo extents (AGRUPADO) --

select status, count(*) Num_Extents, sum(blocks) Num_Blocks, round((sum(bytes)/1024/1024),2) MB from dba_undo_extents group by status order by status;


-- Verifica status geral --

select tablespace_name tablespace, status, sum(bytes)/1024/1024 sum_in_mb, count(*) counts from dba_undo_extents group by tablespace_name, status order by 1,2;