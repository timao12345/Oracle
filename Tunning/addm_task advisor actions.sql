col ATTR1 for a35
col ATTR2 for a35
col ATTR3 for a35
col ATTR4 for a35
col ATTR5 for a35
col owner for a10
col MESSAGE for a35
col task_name for a40
col execution_name for a7
set colsep '|'
select t.*, ac.*
  from dba_advisor_actions ac,
       (select x.*
          from (select tsk.task_id,
                       tsk.last_modified,
                       tsk.created,
                       tsk.execution_start
                  from dba_advisor_tasks tsk
                 order by tsk.last_modified desc) x
         where rownum < 11) t
 where ac.task_id = t.task_id
 order by t.last_modified desc;
