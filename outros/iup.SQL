clear col
column spid format a5
column osuser format a15
column machine format a12
column username format a12
column event format a15
column sql_text format a100
select p.SPID,a.SID, a.SERIAL#, a.OSUSER, a.USERNAME, s.EXECUTIONS, 
       a.event, a.seconds_in_wait sec,
       s.SQL_TEXT
  from gv$session a,
       gv$process p,
       gv$sqlarea s
where a.PADDR = p.ADDR
  and a.inst_id = p.inst_id
  and a.SQL_HASH_VALUE = s.HASH_VALUE (+)
  and a.inst_id = s.inst_id (+)
  and a.inst_id = &1
  and p.SPID in (&2)
/
