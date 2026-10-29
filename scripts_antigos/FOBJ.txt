set long 10000000
set pages 900
set lines 500
col owner for a20
col object_name for a30
col OBJECT_TYPE for a18
col LAST_DDL_TIME for a13
col TIMESTAMP for a20
select OWNER,OBJECT_NAME,OBJECT_TYPE, to_char(CREATED,'dd/mm HH24:MI') CREATED,to_char(LAST_DDL_TIME,'dd/mm HH24:MI') LAST_DDL_TIME , TIMESTAMP,STATUS
from dba_objects
where object_name like upper ('%&PARTE_obj%') 
order by 1
/
