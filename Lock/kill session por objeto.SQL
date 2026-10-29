select 'alter system kill session ' || chr(39) || b.SID || ',' || b.SERIAL# || chr(39) || '--' || c.SPID
       || ' ' || d.STATE || ' ' || d.SECONDS_IN_WAIT || '--' || ' '
       ||  b.OSUSER
       || chr(13) || chr(10) || '/'
  from sys.v_$access a,
           v$session b,
       sys.V_$PROCESS c,
           v$session_wait d
where a.OBJECT like 'BSCLIPROX%'
  and a.SID = b.SID
  and b.PADDR = c.ADDR
  and a.SID = d.SID (+)
  and d.STATE <> 'WAITING'
  and d.SECONDS_IN_WAIT > 5
