-- o tempo da reten��o

show parameter undo_retention;


-- Verificar o quanto esta sendo utilizado


set lines 200
set pages 100

select status,
       round(sum_bytes / (1024 * 1024), 0) as MB,
       round((sum_bytes / undo_size) * 100, 0) as PERC
  from (select status, sum(bytes) sum_bytes
          from dba_undo_extents
         group by status),
       (select sum(a.bytes) undo_size
          from dba_tablespaces c
          join v$tablespace b on b.name = c.tablespace_name
          join v$datafile a on a.ts# = b.ts#
         where c.contents = 'UNDO'
           and c.status = 'ONLINE'); 
		   
		   
-- alterar o tempo de rentenção ** as vezes precisa deixar esse parametro com um valor alto porque existem transações que demoram muito para comitar, e ai gera um erro parecido com  "snapshot too old"
-- não pode deixar os datafiles de undo em autoextend off.

alter system set undo_retention = 1800;


-- estimativa de valor correto para undo
 SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
                      SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
                      (TO_NUMBER(e.value) * TO_NUMBER(f.value) * g.undo_block_per_sec) / (1024*1024) "NEEDED UNDO SIZE [MByte]"
  FROM        (SELECT       SUM(a.bytes) undo_size
                       FROM        v$datafile a
                       inner join  v$tablespace b
                              on      a.ts# = b.ts#
                        inner join  dba_tablespaces c
                              on      b.name = c.tablespace_name
                       WHERE       c.contents = 'UNDO'
                      AND         c.status = 'ONLINE') d,
                      v$parameter e,
                      v$parameter f,        
                     ( SELECT   MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
                       FROM    v$undostat) g
  WHERE   e.name = 'undo_retention'
  AND         f.name = 'db_block_size';