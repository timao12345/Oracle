select START_TIME, USED_UBLK, username, segment_id, segment_name 
  from v$transaction t, v$session s, dba_rollback_segs r
 where t.SES_ADDR=s.saddr and t.XIDUSN=r.segment_id
