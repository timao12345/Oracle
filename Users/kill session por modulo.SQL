select 'alter system kill session ' || chr(39) || b.SID || ',' || b.SERIAL# || chr(39) || '--' || c.SPID
       || chr(13) || chr(10) || '/'
  from v$session b,
       sys.V_$PROCESS c
where upper(b.MODULE) = 'CS1.EXE'
  and b.PADDR = c.ADDR
