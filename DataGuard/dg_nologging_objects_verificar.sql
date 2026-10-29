-- PROMPT TABLES THAT ARE IN NOLOGGING MODE
col table_name for a65
select owner||'.'||table_name table_name, logging from dba_tables
where LOGGING ='NO'
and owner not in ('SYS', 'SYSTEM', 'EXFSYS', 'WMSYS', 'MDSYS', 'OLAPSYS', 'DBSNMP')
order by owner, table_name
/

col index_name for a65
select owner||'.'||index_name index_name, logging 
from dba_indexes
where LOGGING ='NO'
and owner not in ('SYS', 'SYSTEM', 'EXFSYS', 
                       'WMSYS', 'MDSYS', 'OLAPSYS', 'DBSNMP')
/
