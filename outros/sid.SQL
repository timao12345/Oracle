clear col
column sid format a4
column spid format a5
column osuser format a15
column machine format a12
column username format a12
column event format a15
column sql_text format a100
column sec format a4
column seconds_in_wait format a4
select p.SPID, a.seq#, s.sql_id, 
       trim(a.sid) sid,
       a.SERIAL#, 
       a.osuser,
       a.machine, 
       a.program,
       trim(a.seconds_in_wait) sec, a.event, 
       a.USERNAME, s.EXECUTIONS, s.SQL_TEXT
  from v$session a,
       v$process p,
       v$sqlarea s
where a.PADDR = p.ADDR
  and a.SQL_HASH_VALUE = s.HASH_VALUE (+)
  and a.sid in (&1)
/
