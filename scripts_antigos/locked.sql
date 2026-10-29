 column blocker format a25
 column blockee format a25
 column sid_serial format a10
 select
  (select username || ' - ' || osuser from v$session where sid=a.sid) blocker,
 a.sid || ', ' ||
 (select serial# from v$session where sid=a.sid) sid_serial,
 ' is blocking ',
 (select username || ' - ' || osuser from v$session where sid=b.sid) blockee,
   b.sid || ', ' ||
     (select serial# from v$session where sid=b.sid) sid_serial
     from v$lock a, v$lock b
    where a.block = 1
      and b.request > 0
      and a.id1 = b.id1
      and a.id2 = b.id2;
