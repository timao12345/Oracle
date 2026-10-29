select 'delete from ' || a.OWNER || '.' || a.TABLE_NAME || ' a ' ||
       ' where  not exists (select 0 from ' || c.OWNER || '.' || c.TABLE_NAME ||
       ' where ' || d.COLUMN_NAME  || ' = ' || 'a.' || b.COLUMN_NAME || ')' ||
       ' and ' || b.COLUMN_NAME || ' is not null;' || chr(13) || chr(10) ||
       'alter table ' || a.OWNER || '.' || a.TABLE_NAME || ' enable constraint ' ||  a.CONSTRAINT_NAME  || ';'
  from dba_constraints a,
       dba_cons_columns b,
       dba_constraints c,
       dba_cons_columns d
where a.VALIDATED = 'NOT VALIDATED'
 and a.OWNER = 'SAUDE'
 and a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
 and a.R_OWNER = c.OWNER
 and a.R_CONSTRAINT_NAME = c.CONSTRAINT_NAME
 and c.CONSTRAINT_NAME = d.CONSTRAINT_NAME
