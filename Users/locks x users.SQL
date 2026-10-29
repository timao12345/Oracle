select sid, username, osuser, process, program, machine, terminal
from V$session
where sid in (select sid
              from V$lock
              where (id1, id2) in (select id1, id2 from V$lock
                                   where block in (2,3)
                                   and sid = 113)
              and block=2);