select max(a.value) "highest_open_cur", p.value "max_open_cur"
  from v$sesstat a, v$statname b, v$parameter p
 where a.statistic#=b.statistic#
  and b.name='opened cursors current'
  and p.name='open_cursors'
group by p.value
/

