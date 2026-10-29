select 
   sid         c1,
   stat1.value c2, 
   stat2.value c3, 
   stat2.value c4
from 
   v$sesstat  stat1, 
   v$sesstat  stat2, 
   v$statname name1, 
   v$statname name2
where 
   stat1.statistic# = name1.statistic#  
and
   name1.statistic# = name2.statistic#;
and 
   name1.name = 'session cursor cache hits' 
and 
   stat2.statistic#=name2.statistic#
and 
   name2.name= 'parse count (total)'
and 
   stat2.sid= stat1.sid