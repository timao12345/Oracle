set lines 3000 pages 10000
col TABLE_NAME form a30
col COLUMN_NAME form a30
col owner form a8
SELECT * FROM (SELECT c.owner, c.table_name, cc.column_name, cc.position column_position
               FROM   dba_constraints c, dba_cons_columns cc
               WHERE  c.owner='&&schema_owner'
               AND    c.constraint_name = cc.constraint_name
               AND    c.constraint_type = 'R'
              MINUS
               SELECT i.owner, i.table_name, ic.column_name, ic.column_position
               FROM   dba_indexes i, dba_ind_columns ic
               WHERE  i.owner='&&schema_owner'
               AND    i.index_name = ic.index_name)
ORDER BY table_name, column_position;
