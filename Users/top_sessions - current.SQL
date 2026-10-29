  select
   sid,
   username, osuser,
   round(100 * total_user_io/total_io,2) tot_io_pct
from
(select
     b.sid sid, b.OSUSER,
     nvl(b.username,p.name) username,
     sum(value) total_user_io
 from
     sys.v_$statname c,
     sys.v_$sesstat a,
     sys.v_$session b,
     sys.v_$bgprocess p
 where
      a.statistic#=c.statistic# and
      p.paddr (+) = b.paddr and
      b.sid=a.sid and
      c.name in ('physical reads',
                 'physical writes',
                 'physical writes direct',
                 'physical reads direct',
                 'physical writes direct (lob)',
                 'physical reads direct (lob)')
group by
      b.sid, b.OSUSER,  nvl(b.username,p.name)),
(select
      sum(value) total_io
 from
      sys.v_$statname c,
      sys.v_$sesstat a
 where
      a.statistic#=c.statistic# and
      c.name in ('physical reads',
                 'physical writes',
                 'physical writes direct',
                 'physical reads direct',
                 'physical writes direct (lob)',
                 'physical reads direct (lob)'))
order by
      4 desc