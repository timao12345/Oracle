select  r.owner, 
        r.table_name as tabela, 
        r.constraint_name as nome_chave,
        u.COLUMN_NAME
from  dba_constraints r, 
      dba_constraints o,
      dba_cons_columns u
where r.r_owner = o.owner 
and u.CONSTRAINT_NAME = r.CONSTRAINT_NAME 
and r.r_constraint_name = o.constraint_name 
and o.constraint_type in ('P','U') 
and r.constraint_type = 'R' 
and o.table_name = 'TB_NF_ITEM'
AND r.table_name= 'TB_RESSARC';


      PERFSTAT.STATS$SQL_SUMMARY_PK

select OWNER,CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME from dba_constraints where CONSTRAINT_NAME like '%STATS$SQL_SUMMARY_PK%';


tabela STATS$SQL_SUMMARY
STATS$SQL_SUMMARY


alter table STATS$SQL_SUMMARY disable constraint PERFSTAT.STATS$SQL_SUMMARY_PK;