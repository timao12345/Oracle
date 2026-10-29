select x.*, 100-(100* (1/somaext)) frag, mbytes/tempo_vida cresc_dia from
(
select a.SEGMENT_NAME, a.SEGMENT_TYPE, count(1) somaext, sum(a.BYTES)/1024/1024 mbytes, (sysdate - b.CREATED) tempo_vida
  from dba_extents a, dba_objects b
 where a.OWNER = 'SIC'
   and a.OWNER = b.OWNER
   and a.SEGMENT_NAME = b.OBJECT_NAME
group by a.SEGMENT_NAME, a.SEGMENT_TYPE, (sysdate - b.CREATED)) x
Order by 4 Desc