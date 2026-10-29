select cg "consistent gets", dbblock "db block gets", pr "physical reads",
  100*(1 - (pr / decode((cg + dbblock),0,1,(cg + dbblock)))) "Session Cache Hit Ratio [%]"
 from( 
  select nvl(v2.value,0) cg, nvl(v1.value,0) dbblock,
         nvl(v3.value,0) pr     
  from
    v$sesstat v1, v$sesstat v2, v$sesstat v3
  where
    v1.statistic# = 47 and
    v2.statistic# = 50  and
    v3.statistic# =  54 and
    v1.SID = v2.SID and
    v2.SID = v3.SID and
    v1.SID = &1)
/  
