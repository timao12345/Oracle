select v1.inst_id,
       100 * (1 - (v3.value / (v1.value + v2.value))) "Cache Hit Ratio [%]"
  from gv$sysstat v1, gv$sysstat v2, gv$sysstat v3
 where v1.name = 'db block gets'
   and v2.name = 'consistent gets'
   and v3.name = 'physical reads'
   and v1.inst_id = v2.inst_id
   and v2.inst_id = v3.inst_id
 group by v1.inst_id, 100 * (1 - (v3.value / (v1.value + v2.value)))
/