Criado pelo Arthur

with
  blocking_sessions as
   (select distinct
      s.sid, s.serial#, s.inst_id, s.blocking_session, s.blocking_instance,
      s.username, s.osuser, s.machine, s.service_name, s.program, s.module, s.action, s.state, s.event, s.seconds_in_wait, t.start_time,
      s.sql_id, o.object_type blk_obj_type, o.owner blk_owner, o.object_name blk_object
    from
      dba_objects o,
      gv$transaction t,
      gv$session s,
      (select distinct blocking_session bsid, blocking_instance binst_id
       from gv$session
       where
         blocking_session is not null and
         seconds_in_wait >= 30) b
    where
      ((s.sid = b.bsid and
        s.inst_id = b.binst_id) or
       (s.blocking_session = b.bsid and
        s.blocking_instance = b.binst_id)) and
      t.ses_addr (+) = s.saddr and
      t.inst_id (+) = s.inst_id and
      o.object_id (+) = s.row_wait_obj#)
select
  level,lpad(' ',2*(level-1))||sid sid,serial#,inst_id,blocking_session blk_sess,blocking_instance blk_inst, username,osuser,machine,service_name,
  program,module,action,state,event,seconds_in_wait siw,to_char(to_date(start_time,'mm/dd/yy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') tx_start_time,
  round((sysdate-to_date(start_time,'mm/dd/yy hh24:mi:ss'))*24*60*60,0) tx_secs,
  sql_id,blk_obj_type,blk_owner,blk_object
from blocking_sessions
start with blocking_session is null
connect by prior sid = blocking_session and prior inst_id = blocking_instance;




                

Modelo antigo usado no monitoramento


select /*+ rule */  sn.USERNAME ||'@'||sn.machine,
    '|SID->' || m.SID,
    '|Serial->'|| sn.SERIAL#,
    '|Lock Type->'||m.TYPE,
    decode(LMODE,
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive') lock_type,
    decode(REQUEST,
        0, 'None',
        1, 'Null',
        2, 'Row-S (SS)',
        3, 'Row-X (SX)',
        4, 'Share',
        5, 'S/Row-X (SSX)',
        6, 'Exclusive') lock_requested,
    '|Time (Sec)->'||m.CTIME "Time(sec)",
    '|ID1->'||m.ID1,
    '|ID2->'||m.ID2,
    '|SQL ID->'||t.SQL_ID,
    '|SQL Text->'||t.SQL_TEXT
from    v$session sn,
    v$lock m ,
    v$sqltext t
where   t.ADDRESS =sn.SQL_ADDRESS
and     t.HASH_VALUE =sn.SQL_HASH_VALUE
and     ((sn.SID =m.SID and m.REQUEST !=0)
or  (sn.SID =m.SID and m.REQUEST =0 and LMODE !=4 and (ID1, ID2) in
    (select s.ID1, s.ID2
     from   v$lock S
     where  REQUEST !=0
     and  s.ctime > 5
     and    s.ID1 =m.ID1
     and    s.ID2 =m.ID2)))
order by sn.USERNAME, sn.SID, t.PIECE;
