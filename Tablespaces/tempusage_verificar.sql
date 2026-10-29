select s.username, s.OSUSER, s.SID, s.serial#, u.tablespace, s.logon_time, s.machine,
       u.contents, sum(u.extents) extents, sum(u.blocks) blocks, sum((u.blocks * par.value)/1024/1024) Mbytes
        from   sys.gv_$session s, sys.gv_$sort_usage u,
               v$parameter par
        where  s.saddr = u.session_addr
          and par.NAME = 'db_block_size'
group by s.username, s.OSUSER, s.SID, s.serial#, u.tablespace, s.logon_time, s.machine,
       u.contents
Order by 9
/
