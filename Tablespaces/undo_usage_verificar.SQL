select a.OSUSER, a.SID, a.serial#, a.machine, c.SEGMENT_NAME, c.TABLESPACE_NAME, b.USED_UREC linhas,
       b.USED_UBLK, (b.USED_Ublk * p.value) / 1024 / 1024  undoseg_mb
  from v$session a, 
       v$transaction b, 
       v$parameter p,
       sys.DBA_ROLLBACK_SEGS c
where a.TADDR = b.ADDR
  and b.XIDUSN = c.SEGMENT_ID
  and p.NAME = 'db_block_size'
order by 8;


-- filtrar por sessão
select a.OSUSER, a.SID, a.serial#, a.machine, c.SEGMENT_NAME, c.TABLESPACE_NAME, b.USED_UREC linhas,
       b.USED_UBLK, (b.USED_Ublk * p.value) / 1024 / 1024  undoseg_mb
  from gv$session a, 
       v$transaction b, 
       v$parameter p,
       sys.DBA_ROLLBACK_SEGS c
where a.TADDR = b.ADDR
  and b.XIDUSN = c.SEGMENT_ID
  and p.NAME = 'db_block_size'
  and a.sid = 7680
order by 8;

