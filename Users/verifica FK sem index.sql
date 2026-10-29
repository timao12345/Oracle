-- verifica todas Foreign Key de um determinado owner se tem index criado ou não
col OWNER for a20
col INDEX_NAME for a25
col INDEX_COLUMNS for a25
col TABLE_NAME for a25
col FK_NAME for a25
col FK_COLUMNS for a45
col status for a10
SELECT CASE
         WHEN b.table_name IS NULL THEN 'unindexed'
         ELSE 'indexed'
       END               AS status, 
       a.owner, 
       a.table_name      AS table_name, 
       a.constraint_name AS fk_name, 
       a.fk_columns      AS fk_columns, 
       b.index_name      AS index_name, 
       b.index_columns   AS index_columns 
FROM   (SELECT a.owner, 
               a.table_name, 
               a.constraint_name, 
               Listagg(a.column_name, ',') 
                 within GROUP (ORDER BY a.position) fk_columns 
        FROM   dba_cons_columns a, 
               dba_constraints b 
        WHERE  a.constraint_name = b.constraint_name 
               AND b.constraint_type = 'R'
               AND a.owner LIKE 'KIPREV%'
               AND a.owner = b.owner 
        GROUP  BY a.owner, 
                  a.table_name, 
                  a.constraint_name) a, 
       (SELECT table_name, 
               index_name, 
               Listagg(c.column_name, ',') 
                 within GROUP (ORDER BY c.column_position) index_columns 
        FROM   dba_ind_columns c 
        WHERE  c.index_owner LIKE 'KIPREV%'
        GROUP  BY table_name, 
                  index_name) b 
WHERE  a.table_name = b.table_name(+) 
       AND b.index_columns(+) LIKE a.fk_columns || '%'
ORDER  BY 1 DESC, 2; 