CREATE OR REPLACE FORCE VIEW "UOLDIVEO_DBA"."V_INDEX_USAGE" ("OWNER", "INDEX_NAME", "TABLE_NAME", "MONITORING", "USAGE", "START_MONITORING", "END_MONITORING") AS 
select
  u.username owner,
  io.name index_name,
  t.name table_name,
  decode(bitand(i.flags, 65536), 0, 'NO', 'YES') monitoring,
  decode(bitand(ou.flags, 1), 0, 'NO', 'YES') usage,
  ou.start_monitoring,
  ou.end_monitoring
from
  dba_users u,
  sys.obj$ io,
  sys.obj$ t,
  sys.ind$ i,
  sys.object_usage ou
where
  i.obj# = ou.obj# and
  io.obj# = ou.obj# and
  t.obj# = i.bo# and
  u.user_id = io.owner#;

create public synonym V_INDEX_USAGE for "UOLDIVEO_DBA"."V_INDEX_USAGE";

set define off;
CREATE OR REPLACE PROCEDURE "UOLDIVEO_DBA"."START_MONITORING_NEW_INDEXES" 
authid current_user
as
begin
  for row in (select 'alter index '||owner||'.'||index_name||' monitoring usage' x
              from
               (select owner, index_name
                from dba_indexes
                where
                  owner not in ('SYS','OUTLN','SYSTEM','TSMSYS','DBSNMP','DBACORP','TEMPLATE','CTXSYS','SYSMAN','EXFSYS','XDB','WMSYS') and
                  index_type not in ('LOB')
                minus
                select owner, index_name
                from v_index_usage)) loop
    begin
      execute immediate row.x;
    exception
      when others then
        null;
    end;
    -- dbms_lock.sleep(1);
  end loop;
end;
/

set define off;
CREATE OR REPLACE PROCEDURE "UOLDIVEO_DBA"."STOP_MONITORING_USED_INDEXES" 
authid current_user
as
begin
  for row in (select 'alter index '||owner||'.'||index_name||' nomonitoring usage' x
              from v_index_usage
              where
                monitoring = 'YES' and
                usage = 'YES') loop
    begin
      execute immediate row.x;
    exception
      when others then
        null;
        --dbms_output.put_line(sqlerrm);
    end;
  end loop;
end;
/

exec "UOLDIVEO_DBA"."START_MONITORING_NEW_INDEXES";
exec "UOLDIVEO_DBA"."STOP_MONITORING_USED_INDEXES";

select * from v_index_usage;
select * from v_index_usage where monitoring = 'YES' and usage = 'NO';
select * from v_index_usage where monitoring = 'YES' and usage = 'YES';
select
  owner,
  count(1) indexes,
  sum(decode(monitoring,'YES',1,0)) monitoring,
  sum(decode(usage,'NO',1,0)) unused,
  sum(decode(usage,'YES',1,0)) used
from v_index_usage
group by grouping sets ((),(owner))
order by owner nulls first;

declare
  x binary_integer;
begin
  dbms_job.submit(x,'begin start_monitoring_new_indexes; stop_monitoring_used_indexes; end;',sysdate,'trunc(sysdate+2)-1/24 /* 23:00 dayly */');
  commit;
end;
/

select * from dba_jobs;

--exec sys.dbms_ijob.next_date(44,sysdate);
--commit;
