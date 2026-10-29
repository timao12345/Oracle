Select owner,
       segment_type,
       tablespace_name,
       count(*) Qte
  from dba_segments
 where (pct_increase <> 0 or max_extents = 121) and
       owner not in ('SYSTEM', 'SYS', 'OUTLN', 'DBSNMP', 'ORDSYS')
 group by owner, segment_type, tablespace_name
 order by 1, 2, 3
/
