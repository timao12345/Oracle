col TABLESPACE for a15
col STATUS for a15
col USERNAME for a20
col OSUSER for a20
SELECT   b.tablespace, b.segfile#, b.segblk#, b.blocks, a.sid, a.serial#,a.INST_ID,
          a.username, a.osuser, a.status
 FROM     gv$session a,gv$sort_usage b
 WHERE    a.saddr = b.session_addr
 ORDER BY a.status, b.tablespace, b.segfile#, b.segblk#, b.blocks
/


SELECT 'alter system kill session ' || '''' || a.sid || ',' || a.serial# || ',@' || a.inst_id || '''' || ' immediate;'
 FROM     gv$session a,gv$sort_usage b
 WHERE    a.saddr = b.session_addr and a.status='INACTIVE' 
/
