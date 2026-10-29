select c.SID, c.OSUSER, owner, terminal, lockwait, object_name, object_type,
       locked_mode,
       oracle_username,
       session_id, serial#
  from v$locked_object a,
       all_objects     b,
       v$session       c
 where a.object_id  = b.object_id and
       a.session_id = c.sid
       and b.OBJECT_NAME = 'ICT_LANCCTB16'
