col object_name for a40
col status for a20

select 'CALLED PLSQL', vs.username, d_o.object_name, vs.status, (vs.last_call_et / 60) as MINUTES_FROM_LAST_CALL, TO_CHAR(vs.logon_Time,'DD-MON-YYYY HH24:MI:SS') -- whatever info you need
  from dba_objects d_o
       inner join
       v$session vs
          on d_o.object_id = vs.plsql_entry_object_id
union all
select 'CURRENT PLSQL', vs.username, d_o.object_name, vs.status, (vs.last_call_et / 60) as MINUTES_FROM_LAST_CALL, TO_CHAR(vs.logon_Time,'DD-MON-YYYY HH24:MI:SS')
  from dba_objects d_o
       inner join
       v$session vs
          on d_o.object_id = vs.plsql_object_id;